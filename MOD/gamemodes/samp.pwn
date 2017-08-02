//======================== include's
#include <a_samp>
#include <a_mysql>
#include <sscanf2>

//======================== Data Base
#define SQL_HOST        "localhost" 
#define SQL_USER        "root"
#define SQL_DB          "exploding_kittens"
#define SQL_PASS        ""

//======================== Color's
#define		COLOR_WHITE     0xFFFFFFFF
#define 	COLOR_LIGHTRED  0xFF6347AA
#define 	COLOR_YELLOW    0xFFFF00AA

//======================== Define's
#define     SCM     SendClientMessage

//======================== Forward's

//======================== Dialog's
#define DIALOG_LOGIN        1
#define DIALOG_REGISTER     2
#define DIALOG_WRONGPAS     3

//======================== enum's
enum Variables
{
        aID,
        aName[MAX_PLAYER_NAME],
        aPassword[64],
        bool: aLogged,
        aWrongPassword,
};
new playerVariable[1000][Variables];

main()
{
	print("\n----------------------------------");
	print(" Blank Gamemode by your name here");
	print("----------------------------------\n");
}


public OnGameModeInit()
{
    ConnectMySQL();
	SetGameModeText("Blank Script");
	return 1;
}

public OnGameModeExit()
{
    DisconnectMySQL();
	return 1;
}

public OnPlayerRequestClass(playerid, classid)
{
	return 1;
}

public OnPlayerConnect(playerid)
{
        RemovePlayerVariables(playerid);
//------------------------------------------------------------------------------
        GetPlayerName(playerid, playerVariable[playerid][aName], MAX_PLAYER_NAME);
//------------------------------------------------------------------------------
        if(GetAccountID(playerid)) { // Аккаунт зарегистрирован
                new dialog[128+MAX_PLAYER_NAME];
                format(dialog, sizeof(dialog),
                        "Добро пожаловать на Сервер!\n\
                        Этот аккаунт зарегистрирован.\n\n\
                        Логин: %s\n\
                        Введите пароль:",
                        playerVariable[playerid][aName]);
                ShowPlayerDialog(playerid, DIALOG_LOGIN, DIALOG_STYLE_INPUT, "Авторизация.", dialog, "Войти", "Отмена");
        }
        else { // Аккаунт не зарегистрирован (return 0, в функции GetAccountID, т.е. не нашло записи с аккаунтом).
                new dialog[344+MAX_PLAYER_NAME];
                format(dialog, sizeof(dialog),
                        "Добро пожаловать на Сервер!\n\
                    Этот аккаунт не зарегистрирован.\n\n\
                    Логин: %s\n\
                        Введите пароль и нажмите \"Далее\".\n\n\
                        Примечания:\n\
                        - Пароль чувствительный к регистру.\n\
                    - Длина пароля от 6 до 32 символов.\n\
                    - В пароле можно использовать символы на кириллице и латинице.\n", playerVariable[playerid][aName]);
                ShowPlayerDialog(playerid, DIALOG_REGISTER, DIALOG_STYLE_INPUT, "Регистрация.", dialog, "Далее", "Отмена");
        }
		return 1;
}

public OnPlayerDisconnect(playerid, reason)
{
	return 1;
}

public OnPlayerSpawn(playerid)
{
	return 1;
}

public OnPlayerDeath(playerid, killerid, reason)
{
	return 1;
}

public OnVehicleSpawn(vehicleid)
{
	return 1;
}

public OnVehicleDeath(vehicleid, killerid)
{
	return 1;
}

public OnPlayerText(playerid, text[])
{
    if(playerVariable[playerid][aLogged] == false) return 0;
	return 1;
}

/*public OnPlayerCommandText(playerid, cmdtext[])
{
	if (strcmp("/mycommand", cmdtext, true, 10) == 0)
	{
		return 1;
	}
	return 0;
}*/

public OnPlayerEnterVehicle(playerid, vehicleid, ispassenger)
{
	return 1;
}

public OnPlayerExitVehicle(playerid, vehicleid)
{
	return 1;
}

public OnPlayerStateChange(playerid, newstate, oldstate)
{
	return 1;
}

public OnPlayerEnterCheckpoint(playerid)
{
	return 1;
}

public OnPlayerLeaveCheckpoint(playerid)
{
	return 1;
}

public OnPlayerEnterRaceCheckpoint(playerid)
{
	return 1;
}

public OnPlayerLeaveRaceCheckpoint(playerid)
{
	return 1;
}

public OnRconCommand(cmd[])
{
	return 1;
}

public OnPlayerRequestSpawn(playerid)
{
	return 1;
}

public OnObjectMoved(objectid)
{
	return 1;
}

public OnPlayerObjectMoved(playerid, objectid)
{
	return 1;
}

public OnPlayerPickUpPickup(playerid, pickupid)
{
	return 1;
}

public OnVehicleMod(playerid, vehicleid, componentid)
{
	return 1;
}

public OnVehiclePaintjob(playerid, vehicleid, paintjobid)
{
	return 1;
}

public OnVehicleRespray(playerid, vehicleid, color1, color2)
{
	return 1;
}

public OnPlayerSelectedMenuRow(playerid, row)
{
	return 1;
}

public OnPlayerExitedMenu(playerid)
{
	return 1;
}

public OnPlayerInteriorChange(playerid, newinteriorid, oldinteriorid)
{
	return 1;
}

public OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
	return 1;
}

public OnRconLoginAttempt(ip[], password[], success)
{
	return 1;
}

public OnPlayerUpdate(playerid)
{
	return 1;
}

public OnPlayerStreamIn(playerid, forplayerid)
{
	return 1;
}

public OnPlayerStreamOut(playerid, forplayerid)
{
	return 1;
}

public OnVehicleStreamIn(vehicleid, forplayerid)
{
	return 1;
}

public OnVehicleStreamOut(vehicleid, forplayerid)
{
	return 1;
}

public OnDialogResponse(playerid, dialogid, response, listitem, inputtext[]){
        switch(dialogid) {
                case DIALOG_LOGIN: { // Диалог авторизации.
                    if(!response) { // Если нажал "Отмена".
                                SendClientMessage(playerid, COLOR_YELLOW, "* Введите /q(uit), чтобы выйти из игры.");
                                Kick(playerid);
                                return 1;
                        }
                    if(!strlen(inputtext)) { // Если поле ввода пустое.
                    new dialog[134+MAX_PLAYER_NAME];
                    format(dialog, sizeof(dialog),
                                    "Добро пожаловать на Сервер!\n\
                                    Этот аккаунт зарегистрирован.\n\n\
                                    Логин: %s\n\
                                    Введите пароль:",
                                    playerVariable[playerid][aName]);
                    ShowPlayerDialog(playerid, DIALOG_LOGIN, DIALOG_STYLE_INPUT, "Авторизация.", dialog, "Войти", "Отмена");
                    return 1;
                    }
                	LoadAccount(playerid, inputtext); // Пробуем его авторизовать.
                }
                case DIALOG_REGISTER: { // Диалог регистрации.
                    if(!response) { // Если нажал "Отмена".
                                SendClientMessage(playerid, COLOR_YELLOW, "* Введите /q(uit), чтобы выйти из игры.");
                                Kick(playerid);
                                return 1;
                        }
                	if(!strlen(inputtext) || strlen(inputtext) < 6 || strlen(inputtext) > 64) { // Если пустое поле ввода или пароль имеет меньше 6 или больше 64 символов
                                new dialog[380+24+10];
                                format(dialog, sizeof(dialog),
                                        "Добро пожаловать на Сервер!\n\
                                    Этот аккаунт не зарегистрирован.\n\n\
                                    Логин: %s\n\
                                        Введите пароль и нажмите \"Далее\".\n\n\
                                        Примечания:\n\
                                - Пароль чувствительный к регистру.\n\
                                    - Длина пароля от 6 до 32 символов.\n\
                                    - В пароле можно использовать символы на кириллице и латинице.\n", playerVariable[playerid][aName]);
                                ShowPlayerDialog(playerid, DIALOG_REGISTER, DIALOG_STYLE_INPUT, "Регистрация.", dialog, "Далее", "Отмена");
                                return 1;
                        }
                    CreateAccount(playerid, inputtext); // Создаём аккаунт.
                    playerVariable[playerid][aLogged] = true; // Авторизуем игрока. <img src='http://pawn-wiki.ru/public/style_emoticons/<#EMO_DIR#>/smile.gif'class='bbc_emoticon' alt=':)' />
                }
                case DIALOG_WRONGPAS: { // Если неверный пароль.
                        if(response) {
                                new dialog[134+MAX_PLAYER_NAME];
                                format(dialog, sizeof(dialog),
                                        "Добро пожаловать на Сервер!\n\
                                        Этот аккаунт зарегистрирован.\n\n\
                                        Логин: %s\n\
                                        Введите пароль:",
                                        playerVariable[playerid][aName]);
                                ShowPlayerDialog(playerid, DIALOG_LOGIN, DIALOG_STYLE_INPUT, "Авторизация.", dialog, "Войти", "Отмена");
                                return 1;
                        }
                        else { // Если нажал "Отмена".
                                Kick(playerid);
                                return 1;
                        }
                }
        }
        return 1;
}

public OnPlayerClickPlayer(playerid, clickedplayerid, source)
{
	return 1;
}

//=================== stock's
stock ConnectMySQL() {
    mysql_connect(SQL_HOST, SQL_USER, SQL_DB, SQL_PASS); 
    switch(mysql_ping())
		{ // Проверка на то, что мы подключены к БД.
                case 1: print("MySQL connection: alive."); // Если подключена БД.
                case -1: print("MySQL connection: dead."); // Если не подключена БД.
        }
  	return 1;
}

stock DisconnectMySQL() { // Вставьте DisconnectMySQL(); в OnGameModeExit, отключаемся от БД.
        mysql_close();
        print("MySQL connection closed.");
}

stock CheckMySQLConnection() { // Этот сток мы будем использовать для проверки, подключена ли БД перед её использованием.
        if(mysql_ping() == -1) mysql_reconnect();
        return 1;
}

stock CreateAccount(playerid, password[]) {
        new
            query[128], // Для запроса.
                sqlname[MAX_PLAYER_NAME],
            sqlpassword[32];
        mysql_real_escape_string(playerVariable[playerid][aName], sqlname); // Защитит от sql inject
        mysql_real_escape_string(password, sqlpassword); // Защитит от sql inject
        format(query, sizeof(query), "INSERT INTO `model_user` (`Nickname`, `Password`) VALUE ('%s', '%s')", sqlname, sqlpassword); // Добавляем в таблицу запись.
        // INSERT - добавление записи в таблицу, 1. () - поля. 2. VALUE - значения этих полей.
        mysql_query(query); // Отправляем запрос.
	    GetAccountID(playerid); // Узнаём ИД аккаунта, будет использоваться для сохранения и прочих операций.
	    strmid(playerVariable[playerid][aPassword], password, 0, 64, 255); // Внедряем в массив аккаунта введенный игроком пароль.
        playerVariable[playerid][aLogged] = true; // Мы авторизованы.
        return 1;
}
stock LoadAccount(playerid, password[]) {
        new
                query[128],
                sqlpass[32],
                result[5+24+64],
                dialog[128];
        mysql_real_escape_string(password, sqlpass); // Защита от SQL Inject, шифрует кодировку.
        format(query, sizeof(query), "SELECT * FROM `model_user` WHERE `Password` = '%s' AND `ID` = '%i'", sqlpass, playerVariable[playerid][aID]);
        // SELECT * - выбрать, FROM - с таблицы, WHERE - где, пароль равен введенному паролю и ID равен иду ника человека.
        mysql_query(query); // Отправляем запрос.
        mysql_store_result(); // Смотрим записи, которые мы выбрали запросом выше.
        if(mysql_num_rows() == 1) { // Если выбрало только 1 аккаунт с таким паролем и ИД - успех, пароль введен верно, загружаем данные в массив.
        mysql_fetch_row_format(result, "|"); // split, данные в результате записываются типо "1|Snoowker|parol"
        sscanf(result, "p<|>is[24]s[32]", // i - ид (int), s[размер] - string, ник и пароль.
                        playerVariable[playerid][aID],
                        playerVariable[playerid][aName],
                        playerVariable[playerid][aPassword]);
       	playerVariable[playerid][aLogged] = true;
        mysql_free_result(); // Очищаем память.
        return 1;
        }
        else { // Мы ввели неверный пароль.
            if(playerVariable[playerid][aWrongPassword] == 4) {
                        SendClientMessage(playerid, COLOR_LIGHTRED, "Вы 3 раза ввели неверный пароль и были отключены от сервера.");
                        Kick(playerid);
                        return 1;
                }
        	format(dialog, sizeof(dialog),
                    "Вы ввели неверный пароль.\n\
                    У Вас осталось %i/3 попыток ввода.", 3 - playerVariable[playerid][aWrongPassword]);
            ShowPlayerDialog(playerid, DIALOG_WRONGPAS, DIALOG_STYLE_MSGBOX, "Ошибка.", dialog, "Повтор", "Отмена");
        }
        return 1;
}
stock GetAccountID(playerid) {
        new
                query[128];
        format(query, sizeof(query),"SELECT `ID` FROM `model_user` WHERE `Nickname` = '%s'", playerVariable[playerid][aName]);
        // Выбираем ID, с таблицы Accounts, где Ник равен нику игрока.
        mysql_query(query); // Отправляем запрос.
        mysql_store_result(); // Видим
        if(mysql_num_rows() == 1) { // Если у нас в результате выбрало 1 запись, т.е. аккаунт игрока.
                playerVariable[playerid][aID] = mysql_fetch_int(); // ИД игрока равен номеру записи.
                mysql_free_result(); // Очищаем память.
                return playerVariable[playerid][aID]; // Возвращаем ИД игрока.
        }
        return 0;
}

stock SaveAccount(playerid) { // Сохранение аккаунта.
        if(playerVariable[playerid][aLogged] == true) { // Проверка, если аккаунт авторизован.
            CheckMySQLConnection(); // Проверяем, подключена ли БД.
                new
                        query[186],
                        sqlname[MAX_PLAYER_NAME],
                        sqlpass[64];
                mysql_real_escape_string(playerVariable[playerid][aName], sqlname);
                mysql_real_escape_string(playerVariable[playerid][aPassword], sqlpass);
                format(query, sizeof(query), "UPDATE `model_user` SET `Nickname` = '%s', `Password` = '%s' WHERE `ID` = '%i'", sqlname, sqlpass, playerVariable[playerid][aID]);
                mysql_query(query); // Отправляем запрос
        }
        return 1;
}

stock RemovePlayerVariables(playerid) {
        playerVariable[playerid][aWrongPassword] = 0;
        playerVariable[playerid][aID] = 0;
        playerVariable[playerid][aLogged] = false;
        return 1;
}
