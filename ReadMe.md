/api/login/ (GET)
==========

Parameters: mail, password
--------------------------
Response:
---------
*    if mail & password are correct
        status : "Success",
        token : {
            token : value1, // xxx.yyy.zzz token
            expires : value2, // время, до которого токен валидный, в формате unix
            id : value3 }  // id пользователя

*    if mail is correct, passwors is incorrect
        status : "Error"
        message : "Неверный пароль"

*    if mail is incorrect
        status : "Error"
        message : "Email не зарегистрирован"

*    Else
        status : "Error"
        message : "Ошибка на сервере. Попробуйте позже."

/api/makeInvite/ (POST)
================

Parameters:
-----------
* token
* dish
* dishabout
* meettime (unix)

Response:
--------
*    if token is invalid
        status : "tokendied"

*    if internal errors exist in api
        status : "error"
        message : "Ошибка на сервере. Попробуйте позже"

*    Else
        status : "success"
