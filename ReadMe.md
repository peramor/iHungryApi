/api/registration (PUT)
=======================
Parameters:
----------
* mail
* surname
* name
* gender
* phone
* vk
* dorm_id
* flat
* fac_id
* pass

Response:
---------
status, text, accessToken, refreshToken

**all data is correct**
- status : "success"
- accessToken : xxx.yyy.zzz
- refreshToken : abc

**Else**
- status : "error"
- text : "Ошибка на сервере, попробуйте позже"

/api/login (GET)
==========

Parameters:
-----------
* mail,
* password

Response:
---------
status, text, refreshToken, accessToken

**if mail & password are correct**
- status : "Success",
- accessToken : xxx.yyy.zzz,
- refreshToken: abc

**if mail is correct, password is incorrect**
- status : "Error"
- text : "Неверный пароль"

**if mail is incorrect**
- status : "Error"
- text : "Email не зарегистрирован"

**Else**
- status : "Error"
- text : "Ошибка на сервере. Попробуйте позже."

/api/makeInvite/ (POST)
================

Parameters:
-----------
* token
* dish
* dishAbout
* meetTime (unix)

Response:
--------
**if token is invalid**
- status : "tokendied"

**if internal errors exist in api**
- status : "error"
- message : "Ошибка на сервере. Попробуйте позже"

**Else**
- status : "success"
