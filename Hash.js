var crypto = require('crypto');
var sf = 'Hash.js' + '    | '; // stringFormat

var hash = function(data, salt){
    console.log(sf + 'hash started..');
    try {
        data = crypto.createHash("sha1").update(data).digest("hex");
        salt = crypto.createHash("md5").update(salt).digest("hex");
        data = crypto.createHash("sha1").update(data + salt).digest("hex");
    } catch(err){
        console.log(sf + 'Ошибка при хэшировании ' + err)
    }
    return data;
    // todo : возвращать ошибку
};

module.exports = hash;