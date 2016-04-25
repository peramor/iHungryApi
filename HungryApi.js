{
    var express = require('express');
    var path = require('path'); // модуль для парсинга пути
    var bodyParser = require('body-parser');
    var app = express();
    var parser = bodyParser.urlencoded({
        extended: true
    });

    var jwt = require('jwt-simple'); // модуль для токенов
    var secret = '1s72$медведь?_13ASDF';
    var moment = require('moment'); // работает с датами

    var mysql = require('mysql'),
        mysqlUtilities = require('mysql-utilities');
    var connection = mysql.createConnection({
        host: 'localhost',
        user: 'root',
        database: "hungry",
        charset: "utf8"
    });
    var crypto = require('crypto');

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
    console.log("sendMail start");

    var mail = req.body.mail;

    connection.query("Select * from users where email='" + mail + "'", function (err, result) {

        if (result.length == 0) {
            request = "insert into users (code, email) values (?, ?)"
        }
        else {
            if (result[0]["code"] == "0") {
                error = {error: "Такой  e-mail уже зарегистрирован!"};
                console.log(error);
                res.json(error);
                return;
            }
            else {
                request = "update users set code=? where email=?"
            }
        }

        var nodemailer = require('nodemailer');

        var transporter = nodemailer.createTransport({
            service: 'Gmail',
            auth: {
                user: 'i.hungry.info@gmail.com',
                pass: 'asdfasdf11'
            }
        }, {
            // sender info
            from: 'iHungry Support <i.hungry.info@gmail.com>'
        });

        var code = Math.floor(Math.random() * 8999) + 1000;
        console.log("Code: " + code);

        var message = {
            to: req.body.mail,
            subject: 'Регистрация в iHungry',
            text: 'Ваш код подтверждения: ' + code
        };

        transporter.sendMail(message, function (errorTransporter, info) {
            error = {error: "Код подтверждения не был отправлен, попробуйте позже."};
            if (errorTransporter) {
                console.log("Error transporter");
                res.json(error);
                return;
            }
            console.log('Message sent: ' + info.response);

            connection.query(request,
                [code, mail],
                function (errorDB, result) {
                    console.log(result);
                    if (!errorDB) {
                        res.json({status: "OK", text: "Код был отправлен на адрес " + mail + "."});
                    }
                    else {
                        res.json(error);
                    }
                })
        });
    });
});

app.get('/api/checkCode', parser, function (req, res) {
    console.log(req.url);
    mail = req.query.mail;
    code = req.query.code;
    console.log(mail);
    console.log(code);

    request = "select * from users where email='" + mail + "' and code=" + code;
    console.log(request);
    connection.query(request, function (err, result) {
        if (err) {
            console.log("Database error: " + err);
            res.json({error: "Ошибка проверки кода"});
        }

        if (result.length == 0) {
            er = {error: "Неправильный код!"};
            console.log(er);
            console.log(result);
            res.json(er);
        }
        else {
            console.log(result);
            res.json({status: "success"});
        }
    });
});

app.put('/api/registration', parser, function (req, res) {
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

    console.log('-> user : "' + email + '" try to sign in');

    // хэширование пароля с солью из email
    pass = crypto.createHash("sha1").update(pass).digest("hex");
    salt = crypto.createHash("md5").update(email).digest("hex");
    pass = crypto.createHash("sha1").update(pass + salt).digest("hex");

    // todo: загружать фото и сохранять url

    request = "update users set surname=?, name=?, gender=?," +
        "phone=?, vk=?, dorm_id=?, flat=?, fac_id=?, pass=?, code=0 where email=? AND pass IS NULL";
    params = [surname, name, gender, phone, vk, dorm_id, flat, fac_id, pass, email];

    connection.query(request, params, function (err, result) {
        // todo: ошибка такой email уже существует
        if (err || result.affectedRows == 0) {
            res.json({status: "error"})
        }
        else {
            connection.query('select user_id from users where email = ? and pass = ?', [email, pass], function (err, result) {
                console.log(result);
                var expires = moment().add(14, 'days').unix(); // время смерти токена
                var token = jwt.encode({
                    iss: result[0]['user_id'],
                    exp: expires
                }, secret);

                response = {
                    status: "success",
                    token: {
                        token: token,
                        expires: expires,
                        id: result[0]['user_id']
                    }
                };
                res.json(response);
            })
        }
    })
});

// todo: refreshtoken, ограничение на ip,
app.get('/api/login', parser, function (req, res) {
//  response = {status : "null", message : "null", token : "null"};
    email = req.query.mail;
    pass = req.query.password;

    console.log('-> user : "' + email + '" tries to login');

    // хэширование пароля с солью из email
    pass = crypto.createHash("sha1").update(pass).digest("hex");
    salt = crypto.createHash("md5").update(email).digest("hex");
    pass = crypto.createHash("sha1").update(pass + salt).digest("hex");

    connection.query('select email from users where email = ?', [email], function (err, result) {
        console.log(result);
        if (!err) {
            if (result.length != 0) {
                truemail = result[0]['email'];
                console.log(truemail);
                connection.query('select user_id from users where email = ? and pass = ?', [truemail, pass], function (err, result) {
                    console.log(result);
                    if (!err) {
                        if (result.length == 0) {
                            response = {status: "error", message: "Неверный пароль"};
                            res.json(response);
                        } else {

                            var expires = moment().add(14, 'days').unix(); // время смерти токена
                            var token = jwt.encode({
                                iss: result[0]['user_id'],
                                exp: expires
                            }, secret);

                            response = {
                                status: "success",
                                token: {
                                    token: token,
                                    expires: expires,
                                    id: result[0]['user_id']
                                }
                            };

                            res.json(response);
                        }
                    } else {
                        response = {status: "error", message: "Ошибка на сервере. Попробуйте позже."}
                        res.json(response);
                    }
                })
            } else {
                response = {status: "error", message: "Email не зарегистрирован"};
                res.json(response);
            }
        } else {
            response = {status: "error", message: "Ошибка на сервере. Попробуйте позже."}
            res.json(response);
        }
    });
});

app.post('/api/makeInvite', parser, function (req, res) {
    console.log('/api/MakeInvite');
// response = {status : "null", message : "null"}    

    token = jwt.decode(req.body.token, secret);
    dish = req.body.dish;
    dishabout = req.body.dishabout;
    meettime = req.body.meettime;

    exp = token.exp;
    now = moment().unix();

    tokenvalid = ((exp - now > 0) || (exp - now <= days * 24 * 60 * 60));

    if (!tokenvalid) {
        res.json({status: "tokendied"});
    } else {
        connection.query('insert into invitations (owner_id, dish, dish_about, meet_time) values (?,?,?,?)',
            [token.iss, dish, dishabout, meettime], function (err, result) {
                if (!err) {
                    console.log(token.iss);
                    connection.query('update users set status = ? where user_id = ?', ["owner", token.iss], function (err, result) {
                        if (!err) {
                            res.json({status: "success"});
                        } else {
                            console.log('/api/makeinvite/ update error ' + err);
                            res.json({status: "error", message: "Ошибка на сервере. Попробуйте позже"});
                        };
                    });
                } else {
                    console.log('/api/makeinvite/ insert error ' + err);
                    res.json({status: "error", message: "Ошибка на сервере. Попробуйте позже"});
                }
            });
    }
});

