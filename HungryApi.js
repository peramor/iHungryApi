{
    var express = require('express');
    var path = require('path'); // модуль для парсинга пути
    var bodyParser = require('body-parser');
    var app = express();
    var parser = bodyParser.urlencoded({
        extended: true
    });

    var jwt = require('./jwtauth.js');
    var tokenLive = 1; // hour
    var refreshTokenLive = 365; // days

    var mysql = require('mysql'),
        mysqlUtilities = require('mysql-utilities');
    var connection = mysql.createConnection({
        host: 'localhost',
        user: 'root',
        database: "hungry",
        charset: "utf8"

    });

    var hash = require('./Hash.js'); // crypto

    app.use(parser);
    app.use(bodyParser.json());

    connection.connect(function (err) {
        if (!err) {
            console.log("Database is connected");
        } else {
            console.log(err);
        }
    });
    mysqlUtilities.upgrade(connection);
    mysqlUtilities.introspection(connection);

    app.listen(8000, function () {
        console.log('Express server is listening on port 8000');
    });
}

app.get('/db/get', parser, function (req, res) {
// params: table
// response = result
    console.log('\n' + req.url + " started..");
    tablename = req.query.table;
    connection.query('select * from ' + tablename, function (err, result) {
        if (err) {
            console.log('- > TABLE ' + tablename + ' does not exist' + '\n' + err);
            res.send('null');
        } else {
            console.log('- > TABLE ' + tablename + '\n');
            res.json(result)
        }
    })
});

app.put('/api/sendMail', parser, function (req, res) {
// params : mail
// response = {status : "null", text : "null"}
    console.log('\n' + req.url + " started..");

    var mail = req.body.mail;
    var nodemailer = require('nodemailer');
    console.log('mail : ' + mail);

    connection.query("Select * from users where email='" + mail + "'", function (err, result) {
        if (result.length == 0) {
            console.log('не найден в базе данных')
            request = "insert into users (code, email) values (?, ?)"
        }
        else {
            if (result[0]["code"] == "0") {
                console.log("e-mail уже зарегистрирован");
                response = {status: "error", text: "Данный e-mail уже зарегистрирован!"};
                res.json(response);
                return;
            }
            else {
                request = "update users set code=? where email=?"
            }
        }

        var transporter = nodemailer.createTransport({
            service: 'Gmail',
            auth: {
                user: 'i.hungry.info@gmail.com',
                pass: 'asdfasdf11'
            }
        }, {
            from: 'iHungry Support <i.hungry.info@gmail.com>'
        });

        var code = Math.floor(Math.random() * 8999) + 1000;
        console.log("Code: " + code);

        var message = {
            to: mail,
            subject: 'Регистрация в iHungry',
            text: 'Ваш код подтверждения: ' + code
        };

        transporter.sendMail(message, function (errorTransporter, info) {
            response = {status: "error", text: "Код подтверждения не был отправлен, попробуйте позже."};
            if (errorTransporter) {
                console.log("Error transporter " + errorTransporter); // todo: фиксировать ошибку, сохранять список таких ошибок
                res.json(response);
                return;
            }
            console.log('Message sent: ' + info.response);

            connection.query(request, [code, mail], function (errorDB, result) {
                console.log('code : ' + code);
                if (!errorDB) {
                    console.log('код был отправлен');
                    res.json({status: "success", text: 'код подтверждения был отправлен на адрес : ' + mail});
                }
                else {
                    console.log('ERROR ошибка соединения с бд : ' + errorDB);
                    res.json(response);
                }
            })
        });
    });
});

app.get('/api/checkCode', parser, function (req, res) {
// params : mail, code (query string)
// response = {status : "null", text : "null"}
    console.log('\n' + req.url + " started..");
    mail = req.query.mail;
    code = req.query.code;
    console.log('mail = %s\ncode = %s', mail, code);

    request = "select * from users where email='" + mail + "' and code=" + code;
    connection.query(request, function (err, result) {
        if (err) {
            console.log("Database error: " + err);
            res.json({status: "error", text: "Ошибка на сервере, попробуйте позже"}); // todo: фиксировать такие ошибки
        }
        if (result.length == 0) {
            console.log('Совпадения не найдены')
            response = {status: "error", text: "Неправильный код!"};
            res.json(response);
        }
        else {
            console.log(result);
            res.json({status: "success"});
        }
    });
});

app.put('/api/registration', parser, function (req, response) {
// params : appID, mail, surname, name, gender, phone, vk, dorm_id, flat, fac_id, pass
// response = {status : "null", text : "null", accessToken : "null", refreshToken : "null"}
    var email, surname, name, gender, phone, vk, dorm_id, flat, fac_id, pass, request, params, appID, userID, token, rt;

    console.log('\n' + req.url + " started..");
    appID = req.body.appID;
    email = req.body.mail;
    surname = req.body.surname;
    name = req.body.name;
    gender = req.body.gender;
    phone = req.body.phone;
    vk = req.body.vk;
    dorm_id = req.body.dorm_id;
    flat = req.body.flat;
    fac_id = req.body.fac_id;
    pass = req.body.pass;

    console.log('mail : ' + email);

    pass = hash(pass, email);

    // todo: загружать фото и сохранять url

    request = 'select user_id from users where email = ?';
    params = [email];
    connection.query(request, params, function (err, result) {
        if (result.length == 0) { // Если в users не найден email
            console.log("mail не зарегистрирован в системе");
            response.json({status: "error", text: "варификацмя email не была пройдена"});
        } else { // Если найден email
            userID = result[0]['user_id'];
            token = jwt.GetToken(tokenLive, 'h');
            rt = jwt.GetRefreshToken(userID, refreshTokenLive, 'd');  // rt = [id, RefreshToken, Expires]
            hrt = hash(rt[1], rt[0].toString());

            request = "INSERT into tokens (user_id, app_id, refresh_token, expires) value (?, ?, ?, ?)";
            params = [userID, appID, hrt, rt[2]];
            connection.query(request, params, function (err) {
                var error = {status: "error", text: "Ошибка на сервере. Попробуйте позже"};
                if (!err) { // Если токен добавлен в БД
                    console.log('токен добавлен в бд');

                    request = "UPDATE users set surname=?, name=?, gender=?," +
                        "phone=?, vk=?, dorm_id=?, flat=?, fac_id=?, pass=?, code=0 where email=? AND pass IS NULL ";
                    params = [surname, name, gender, phone, vk, dorm_id, flat, fac_id, pass, email];
                    connection.query(request, params, function (err, result) {
                        if (!err) { // Если удается выполнить запрос
                            if (result.affectedRows == 0) { // Если ни одна запись не изменена where email=? AND pass IS NULL
                                error.text = "Пользователь с таким email зарегистрирован";
                                response.json(error);
                                connection.query("DELETE from tokens where refresh_token = ?", [hrt], function (err){
                                    if (err) throw err;
                                    console.log('токен удален');
                                });
                            } else { // если одна запись измененена - пользователь зарегистрирован
                                console.log("Пользователь зарегистрирован");
                                response.json({status: "success", accessToken: token, refreshToken: rt[1]});
                            }
                        } else { // Если не удается добавить пользователя
                            console.log("DBerror : " + err);
                            response.json(error);
                            connection.query("DELETE from tokens where refresh_token = ?", [hrt], function (err, result) {
                                console.log('токен удален');
                            });
                        }
                    });
                } else { // Если не удаётся выполнить запрос (null или значение appID не уникально)
                    console.log(err);
                    response.json(error)
                }
            });
        }
    });
});

app.get('/api/login', parser, function (req, response) {
// params : appID, mail, pass
// response = {status : "null", text : "null", accessToken : "null", refreshToken : "null"};
    var email, pass, appID, userID, rt, token, request;

    console.log("\n/api/login started..");
    appID = req.query.appID;
    email = req.query.mail;
    pass = req.query.pass;

    console.log(req.query);

    pass = hash(pass, email);

    connection.query('select email from users where email = ?', [email], function (err, result) {
        console.log(result);
        if (!err) {
            if (result.length != 0) {
                var trueMail = result[0]['email'];
                console.log(trueMail);
                connection.query('select user_id from users where email = ? and pass = ?', [trueMail, pass], function (err, result) {
                    if (!err) if (result.length == 0) {
                        console.log("Неверный пароль")
                        response.json({status: "error", text: "Неверный пароль"});
                    } else {
                        userID = result[0]['user_id'];
                        token = jwt.GetToken(userID, tokenLive, 'h'); // todo : поменять обратно на -> "h"
                        rt = jwt.GetRefreshToken(userID, refreshTokenLive, 'days'); // todo : поменять обратно
                        hrt = hash(rt[1], rt[0].toString());

                        connection.query('select * from tokens where app_id = ?', [appID], function (err, result) {
                            if (result.length == 0) {
                                request = 'insert into tokens (user_id, refresh_token, expires, app_id) values (?, ?, ? ,?)';
                            } else {
                                request = 'update tokens set user_id = ?, refresh_token = ?, expires = ? where app_id = ?'
                            }

                            connection.query(request,
                                [userID, hrt, rt[2], appID],
                                function (err, res) {
                                    if (!err) {
                                        console.log(request);
                                        response.json({status: "success", accessToken: token, refreshToken: rt[1]});
                                    } else {
                                        console.log("DBerror " + err);
                                        response.json({
                                            status: "error",
                                            text: "Не удалось создать маркер доступа. Повторите попытку позже"
                                        });
                                    }
                                });
                        });

                    } else {
                        response.json({status: "error", text: "Ошибка на сервере. Попробуйте позже."});
                    }
                })
            } else {
                response.json({status: "error", text: "Email не зарегистрирован"});
            }
        } else {
            response.json({status: "error", text: "Ошибка на сервере. Попробуйте позже."});
        }
    });
});

app.post('/api/makeInvite', parser, function (req, res) {
// params = token, dishAbout, meetTime, dish
// response = {status : "null", text : "null", accessToken : "null"}
    console.log('\n_' + req.url + ' started...');

    token = req.body.token;
    dish = req.body.dish;
    dishabout = req.body.dishAbout;
    meettime = req.body.meetTime;

    console.log('token = %s\ndish = %s\ndishabout = %s\nmeettime = %s', token, dish, dishabout, meettime);

    if (!jwt.TokenValid(token)) {
        console.log('INVALID TOKEN')
        res.json({status: "invalid token"});
        // .. запрос от приложения, с refresh token'ом
    } else {
        console.log('id = ' + token.iss);

        connection.query('insert into invitations (owner_id, dish, dish_about, meet_time) values (?,?,?,?)',
            [token.iss, dish, dishabout, meettime], function (err, result) {
                error = {status : "error", text : "Ошибка на сервере. Попробуйте позже"}
                if (!err) {
                    console.log('запись добавлена в таблицу invitations')
                    connection.query('update users set status = ? where user_id = ?', ["owner", token.iss], function (err, result) {
                        if (!err) {
                            console.log('статус пользователя изменен на "owner"');
                            res.json({status: "success"});
                        } else {
                            console.log('ERROR : не удалось обновить статус пользователя -> ' + err);
                            res.json(error);
                        }
                        ;
                    });
                } else {
                    console.log('ERROR : не удалось создать запись в таблице invitations ' + err);
                    res.json(error);
                }
            });
    }
});

app.put('/api/updateToken', parser, function (req, response) {
// params = refreshToken, appID
// response = {status : "null", accessToken : "null"}
    var rt, appID, id, at;

    console.log('\n_' + req.url + " started..");
    rt = req.body.refreshToken;
    appID = req.body.appID;
    console.log("appID = %s", appID);

    connection.query("select user_id, expires from tokens where app_id = ?", [appID], function (err, result) {
        if (result.length == 1) {
            var id = result[0]['user_id'];
            var exp = result[0]['expires'];
            console.log("id = %s, exp = %s", id, exp);
            if (jwt.CheckExp(exp)){
                rt = hash(rt, id);

                connection.query("select * from tokens where app_id = ? and refresh_token = ?",
                    [appID, rt], function (err, res) {
                        if (res.length == 1) {
                            console.log(res);
                            console.log("совпадения найдены");
                            at = jwt.GetToken(id, tokenLive, 'h');
                            response.json({status: "success", accessToken: at})
                        } else { // Если неверный токен
                            console.log("Совпадения не найдены");
                            response.json({status: "error"}); // todo : различать ошибки
                        }
                    });
            } else { // Если время жизни токена истекло
                response.json({status: "error"}); // todo: различать ошибки
                connection.query("delete from tokens where app_id = ?", [appID], function(err){
                    if (err) throw err;
                    console.log("Токен удален");
                });
            }
        } else { // Если appID не зарегистрирован
            console.log("appID не зарегистрирован");
            response.json({status: "error"}); // todo: различать ошибки
        }
    })
});

app.put('/api/IHungry', parser, function (req, response) {
    console.log('\n_' + req.url + ' started..');
    var token = jwt.Decode(req.body.token);
    // todo: проверять баланс пользователя, если невозможно снять одну печеньку, отправить error
    connection.query('update users set status = ? where user_id = ?', ['guest', token.iss], function (err, result) {
        if (!err) {
            console.log('Статус пользователя изменен на guest');
            response.json({status : 'success'});
        } else {
            console.log(err);
            response.json({status : 'error', text : 'ошибка на сервере, попробуйте позже'});
        }
    })
})

app.get('/api/getList', parser, function(req,response) {
// params : token
// response = {"status" : "null", ...}
    console.log("_getList started..")
    token = jwt.Decode(req.query.token);
    var id = token.iss;

    connection.query('select status from users where user_id = ' + id, function (err, result) {
        if (!err) {
            status = result[0]['status'];
            switch (status) {
                case "owner":
                    request = "select * from users where status = 'guest'";
                    break;
                case "guest":
                    request = "select * from users where status = 'owner'";
                    break;
                default:
                    response.json({status: "error"});
                    return;
            }
/*
1. Определить статус пользователя
--2. Если статус пользователя owner выбрать из таблицы пользователей все записи, где статус = guest
3. Если статус пользователя guest выбрать из таблицы пользователей все записи, где статус = owner
4. Выбрать все* записи из таблицы invitations, где статус приглашения active // * - dish, dishabout, meettime, owner_id
5. Отсортировать полученный список по user_id
6. Соеденить массив из 2(3) с массивом из 5
7. Отправить полученный json
 */
            connection.query(request, function(err, res){
                if (!err) {
                    user = res;
                    console.log(user);
                    response.json({status : "success", user : user});
                    //todo: отправлять диш и дишабоут
                } else {
                    console.log(err);
                    response.json({status : "error"});
                }
            })
        }else {
            console.log(err);
            response.json({status:"error"});
        }
    })
})