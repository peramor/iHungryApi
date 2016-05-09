my message:
> 09/05/2016 SQL теперь читает русские символы, следует обновить свои. Исправлена ошибка в Registrations из-за которой сервер падал. Проверяется refreshToken при обработке updateToken. Ошибка возвращается, если время жизни токена истекло (365 дней по умолчанию) или appID отсутствует в базе или неверный токен.   

> Была немного изменена архитектура БД, поэтому прилагаемый sql
файл необходимо импортировать к себе. Также был добавлен параметр
appID - это уникальный идентификатор устройства пользователя. Так
как для определения client_id нужно сильно заморачиваться, я решил,
что мы можем генерировать уникальный идентификатор приложения, который
создается при инсталяции приложения. Сейчас его не обязательно
внедрять в код, но без него некоторые запросы работать не будут, поэтому
нужно отправлять его (любое значение). Good LucK..

all api/requests
----------------
- [ ] /api/sendMail
- [ ] /api/checkCode
- [x] /api/registration
- [x] /api/login
- [x] /api/makeInvite
- [x] /api/updateToken

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