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
        if(GetAccountID(playerid)) { // ������� ���������������
                new dialog[128+MAX_PLAYER_NAME];
                format(dialog, sizeof(dialog),
                        "����� ���������� �� ������!\n\
                        ���� ������� ���������������.\n\n\
                        �����: %s\n\
                        ������� ������:",
                        playerVariable[playerid][aName]);
                ShowPlayerDialog(playerid, DIALOG_LOGIN, DIALOG_STYLE_INPUT, "�����������.", dialog, "�����", "������");
        }
        else { // ������� �� ��������������� (return 0, � ������� GetAccountID, �.�. �� ����� ������ � ���������).
                new dialog[344+MAX_PLAYER_NAME];
                format(dialog, sizeof(dialog),
                        "����� ���������� �� ������!\n\
                    ���� ������� �� ���������������.\n\n\
                    �����: %s\n\
                        ������� ������ � ������� \"�����\".\n\n\
                        ����������:\n\
                        - ������ �������������� � ��������.\n\
                    - ����� ������ �� 6 �� 32 ��������.\n\
                    - � ������ ����� ������������ ������� �� ��������� � ��������.\n", playerVariable[playerid][aName]);
                ShowPlayerDialog(playerid, DIALOG_REGISTER, DIALOG_STYLE_INPUT, "�����������.", dialog, "�����", "������");
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
                case DIALOG_LOGIN: { // ������ �����������.
                    if(!response) { // ���� ����� "������".
                                SendClientMessage(playerid, COLOR_YELLOW, "* ������� /q(uit), ����� ����� �� ����.");
                                Kick(playerid);
                                return 1;
                        }
                    if(!strlen(inputtext)) { // ���� ���� ����� ������.
                    new dialog[134+MAX_PLAYER_NAME];
                    format(dialog, sizeof(dialog),
                                    "����� ���������� �� ������!\n\
                                    ���� ������� ���������������.\n\n\
                                    �����: %s\n\
                                    ������� ������:",
                                    playerVariable[playerid][aName]);
                    ShowPlayerDialog(playerid, DIALOG_LOGIN, DIALOG_STYLE_INPUT, "�����������.", dialog, "�����", "������");
                    return 1;
                    }
                	LoadAccount(playerid, inputtext); // ������� ��� ������������.
                }
                case DIALOG_REGISTER: { // ������ �����������.
                    if(!response) { // ���� ����� "������".
                                SendClientMessage(playerid, COLOR_YELLOW, "* ������� /q(uit), ����� ����� �� ����.");
                                Kick(playerid);
                                return 1;
                        }
                	if(!strlen(inputtext) || strlen(inputtext) < 6 || strlen(inputtext) > 64) { // ���� ������ ���� ����� ��� ������ ����� ������ 6 ��� ������ 64 ��������
                                new dialog[380+24+10];
                                format(dialog, sizeof(dialog),
                                        "����� ���������� �� ������!\n\
                                    ���� ������� �� ���������������.\n\n\
                                    �����: %s\n\
                                        ������� ������ � ������� \"�����\".\n\n\
                                        ����������:\n\
                                - ������ �������������� � ��������.\n\
                                    - ����� ������ �� 6 �� 32 ��������.\n\
                                    - � ������ ����� ������������ ������� �� ��������� � ��������.\n", playerVariable[playerid][aName]);
                                ShowPlayerDialog(playerid, DIALOG_REGISTER, DIALOG_STYLE_INPUT, "�����������.", dialog, "�����", "������");
                                return 1;
                        }
                    CreateAccount(playerid, inputtext); // ������ �������.
                    playerVariable[playerid][aLogged] = true; // ���������� ������. <img src='http://pawn-wiki.ru/public/style_emoticons/<#EMO_DIR#>/smile.gif'class='bbc_emoticon' alt=':)' />
                }
                case DIALOG_WRONGPAS: { // ���� �������� ������.
                        if(response) {
                                new dialog[134+MAX_PLAYER_NAME];
                                format(dialog, sizeof(dialog),
                                        "����� ���������� �� ������!\n\
                                        ���� ������� ���������������.\n\n\
                                        �����: %s\n\
                                        ������� ������:",
                                        playerVariable[playerid][aName]);
                                ShowPlayerDialog(playerid, DIALOG_LOGIN, DIALOG_STYLE_INPUT, "�����������.", dialog, "�����", "������");
                                return 1;
                        }
                        else { // ���� ����� "������".
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
		{ // �������� �� ��, ��� �� ���������� � ��.
                case 1: print("MySQL connection: alive."); // ���� ���������� ��.
                case -1: print("MySQL connection: dead."); // ���� �� ���������� ��.
        }
  	return 1;
}

stock DisconnectMySQL() { // �������� DisconnectMySQL(); � OnGameModeExit, ����������� �� ��.
        mysql_close();
        print("MySQL connection closed.");
}

stock CheckMySQLConnection() { // ���� ���� �� ����� ������������ ��� ��������, ���������� �� �� ����� � ��������������.
        if(mysql_ping() == -1) mysql_reconnect();
        return 1;
}

stock CreateAccount(playerid, password[]) {
        new
            query[128], // ��� �������.
                sqlname[MAX_PLAYER_NAME],
            sqlpassword[32];
        mysql_real_escape_string(playerVariable[playerid][aName], sqlname); // ������� �� sql inject
        mysql_real_escape_string(password, sqlpassword); // ������� �� sql inject
        format(query, sizeof(query), "INSERT INTO `model_user` (`Nickname`, `Password`) VALUE ('%s', '%s')", sqlname, sqlpassword); // ��������� � ������� ������.
        // INSERT - ���������� ������ � �������, 1. () - ����. 2. VALUE - �������� ���� �����.
        mysql_query(query); // ���������� ������.
	    GetAccountID(playerid); // ����� �� ��������, ����� �������������� ��� ���������� � ������ ��������.
	    strmid(playerVariable[playerid][aPassword], password, 0, 64, 255); // �������� � ������ �������� ��������� ������� ������.
        playerVariable[playerid][aLogged] = true; // �� ������������.
        return 1;
}
stock LoadAccount(playerid, password[]) {
        new
                query[128],
                sqlpass[32],
                result[5+24+64],
                dialog[128];
        mysql_real_escape_string(password, sqlpass); // ������ �� SQL Inject, ������� ���������.
        format(query, sizeof(query), "SELECT * FROM `model_user` WHERE `Password` = '%s' AND `ID` = '%i'", sqlpass, playerVariable[playerid][aID]);
        // SELECT * - �������, FROM - � �������, WHERE - ���, ������ ����� ���������� ������ � ID ����� ��� ���� ��������.
        mysql_query(query); // ���������� ������.
        mysql_store_result(); // ������� ������, ������� �� ������� �������� ����.
        if(mysql_num_rows() == 1) { // ���� ������� ������ 1 ������� � ����� ������� � �� - �����, ������ ������ �����, ��������� ������ � ������.
        mysql_fetch_row_format(result, "|"); // split, ������ � ���������� ������������ ���� "1|Snoowker|parol"
        sscanf(result, "p<|>is[24]s[32]", // i - �� (int), s[������] - string, ��� � ������.
                        playerVariable[playerid][aID],
                        playerVariable[playerid][aName],
                        playerVariable[playerid][aPassword]);
       	playerVariable[playerid][aLogged] = true;
        mysql_free_result(); // ������� ������.
        return 1;
        }
        else { // �� ����� �������� ������.
            if(playerVariable[playerid][aWrongPassword] == 4) {
                        SendClientMessage(playerid, COLOR_LIGHTRED, "�� 3 ���� ����� �������� ������ � ���� ��������� �� �������.");
                        Kick(playerid);
                        return 1;
                }
        	format(dialog, sizeof(dialog),
                    "�� ����� �������� ������.\n\
                    � ��� �������� %i/3 ������� �����.", 3 - playerVariable[playerid][aWrongPassword]);
            ShowPlayerDialog(playerid, DIALOG_WRONGPAS, DIALOG_STYLE_MSGBOX, "������.", dialog, "������", "������");
        }
        return 1;
}
stock GetAccountID(playerid) {
        new
                query[128];
        format(query, sizeof(query),"SELECT `ID` FROM `model_user` WHERE `Nickname` = '%s'", playerVariable[playerid][aName]);
        // �������� ID, � ������� Accounts, ��� ��� ����� ���� ������.
        mysql_query(query); // ���������� ������.
        mysql_store_result(); // �����
        if(mysql_num_rows() == 1) { // ���� � ��� � ���������� ������� 1 ������, �.�. ������� ������.
                playerVariable[playerid][aID] = mysql_fetch_int(); // �� ������ ����� ������ ������.
                mysql_free_result(); // ������� ������.
                return playerVariable[playerid][aID]; // ���������� �� ������.
        }
        return 0;
}

stock SaveAccount(playerid) { // ���������� ��������.
        if(playerVariable[playerid][aLogged] == true) { // ��������, ���� ������� �����������.
            CheckMySQLConnection(); // ���������, ���������� �� ��.
                new
                        query[186],
                        sqlname[MAX_PLAYER_NAME],
                        sqlpass[64];
                mysql_real_escape_string(playerVariable[playerid][aName], sqlname);
                mysql_real_escape_string(playerVariable[playerid][aPassword], sqlpass);
                format(query, sizeof(query), "UPDATE `model_user` SET `Nickname` = '%s', `Password` = '%s' WHERE `ID` = '%i'", sqlname, sqlpass, playerVariable[playerid][aID]);
                mysql_query(query); // ���������� ������
        }
        return 1;
}

stock RemovePlayerVariables(playerid) {
        playerVariable[playerid][aWrongPassword] = 0;
        playerVariable[playerid][aID] = 0;
        playerVariable[playerid][aLogged] = false;
        return 1;
}
