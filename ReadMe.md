all api/requests
----------------
- [ ] /api/sendMail
- [ ] /api/checkCode
- [x] /api/registration
- [x] /api/login
- [x] /api/makeInvite
- [x] /api/updateToken
- [x] /api/IHungry

/api/IHungry (PUT)
==================
Patameters:
----------
* token

Response
--------
*status, owners : {meet_id, name, surname, gender, dorm_name, dish, dish_about, meet_time, status}*

**token has expired or token is incorrect**
- status : "invalid token"

**server error**
- status : "error"

**else**
- status : "success"
- owners : {meet_id, name, surname, gender, dorm_name, dish, dish_about, meet_time, status} - **10 rows sorted by meet_time (from higher to lower)**

/api/registration (PUT)
=======================
Parameters:
----------
* appID - *внутренний идентификатор приложения, который определяется при инсталяции (на данном этапе можно задать константой)*
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
*status, text, accessToken, refreshToken*

**appID, pass, mail переданы и корректны**
- status : "success"
- accessToken : xxx.yyy.zzz
- refreshToken : abc

**ошибка при выполнении запроса к бд ИЛИ не удалось добавить токен в бд (проверить отправку appID)**
- status : "error"
- text : "Ошибка на сервере, попробуйте позже"

**mail отсутствует в бд**
- status : "error"
- text : "варификацмя email не была пройдена"

**в таблице users ни одна запись не была изменена**
- status : "error"
- text : "Пользователь с таким email зарегистрирован"

/api/login (GET)
==========
Parameters:
-----------
- appID - *внутренний идентификатор приложения, который определяется при инсталяции (на данном этапе можно задать константой)*
- mail
- pass (**!!! password -> pass)**)

Response:
---------
*status, text, refreshToken, accessToken*

**appID, mail и pass переданы и корректны**
- status : "Success",
- accessToken : xxx.yyy.zzz,
- refreshToken: abc

**совпадения mail и pass отсутствуют в таблице users**
- status : "error"
- text : "Неверный пароль"

**mail отсутствует в таблице users**
- status : "error"
- text : "Email не зарегистрирован"

**ошибка при выполнении запроса к бд**
- status : "error"
- text : "Ошибка на сервере. Попробуйте позже."

**ошибка при добавлении access token'a в таблицу tokens**
- status : "error"
- text : "Не удалось создать маркер доступа. Повторите попытку позже"

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
*status, text*

**token is invalid**
- status : "invalid token"

**Запись добавлена в таблицу invitations, статус пользователя изменен на owner**
- status : "success"

**Else**
- status : "error"
- text : "Ошибка на сервере. Попробуйте позже"

/api/updateToken (GET)
================
Parameters:
----------
- refreshToken
- appID

Response:
--------
*status, accessToken*

**appID есть в базе tokens И refreshToken правильный**
- status : "success"
- accessToken : "xxx.yyy.zzz"

**Else**
- status : "error"