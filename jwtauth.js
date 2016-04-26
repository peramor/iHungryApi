var jwt = require('jwt-simple');
var moment = require('moment');
var days = 14;
var secret = '1s72$медведь?_13ASDF';


function Tokenvalid(encodedtoken){
    var tokenvalid = false;
    try {
        token = jwt.decode(encodedtoken, secret);
        exp = token.exp;
        now = moment().unix();

        tokenvalid = ((exp - now > 0) && (exp - now <= days * 24 * 60 * 60));
    } catch(err){
        console.log(err);
        tokenvalid = false;
    }
    return tokenvalid;
}

function Gettoken(iss)
{
     var expires = moment().add(days, 'days').unix(); // время смерти токена
     var token = jwt.encode({
        iss: iss,
        exp: expires
     }, secret);
     return token;
}

module.exports.gettoken = Gettoken;
module.exports.tokenvalid = Tokenvalid;