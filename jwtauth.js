var jwt = require('jwt-simple');
var randtoken = require('rand-token');
var moment = require('moment');
var limit = 2;
var secret = '1s72$медведь?_13ASDF';
var sf = 'jwtauth.js' + '    | '; // stringFormat

function TokenValid(encodedToken){
    console.log(sf + 'Проверка маркера доступа : ' + encodedToken)
    var tokenValid = false;
    try {
        token = jwt.decode(encodedToken, secret);
        exp = token.exp;
        now = moment().unix();
        console.log(sf + 'exp = %d\n' + sf + 'now = %d', exp, now);

        tokenValid = ((exp - now > 0) && (exp - now <= limit * 24 * 60 * 60));
        console.log(sf + 'проверка пройдена : ' + tokenValid);
    } catch(err){
        console.log(sf + 'ERROR не удалось декодировать маркер доступа : ' + err);
        tokenValid = false;
    }
    return tokenValid;
}

function Decode(encodedToken){
    return jwt.decode(encodedToken, secret);
}

function GetToken(iss, exptime, timetype) {
    console.log(sf + 'GetToken started..');
    expires = moment().add(exptime, timetype).unix(); // время смерти токена
    console.log(sf + 'Access Token Expires : ' + expires);
    token = jwt.encode({
        iss: iss,
        exp: expires
    }, secret);
    console.log(sf + 'Access Token : ' + token);
    return token;
}

function GetRefreshToken(iss, exptime, timetype){
    console.log(sf + "GetRefreshToken started..");
    token = randtoken.generate(32);
    expires = moment().add(exptime, timetype).unix();
    console.log(sf + "Refresh Token : " + token);
    console.log(sf + "Refresh Token Expires : " + expires);
    refreshToken = [iss, token, expires];
    return refreshToken;
}

function CheckExp(exp) {
    console.log(sf + 'CheckExp started..');
    var now = moment().unix();
    console.log(sf + 'now = ' + now);
    expValid = (now<exp);
    console.log(sf + "Проверка пройдена : " + expValid);
    return expValid;
}

module.exports.CheckExp = CheckExp;
module.exports.GetToken = GetToken;
module.exports.TokenValid = TokenValid;
module.exports.GetRefreshToken = GetRefreshToken;
module.exports.Decode = Decode;