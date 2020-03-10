#include <sourcemod>
#include <sdktools>

#pragma semicolon 1
#pragma newdecls required

public Plugin myinfo = {
		name = "Skins",
		author = "Qawery",
		description = "No more !knife",
		url = "https://github.com/qawery-just-sad"
}

public void OnPluginStart()
{
	RegConsoleCmd("sm_knife", Command_prepare, "Go KYS");
    RegConsoleCmd("sm_glove", Command_prepare, "Go KYS");
    RegConsoleCmd("sm_gloves", Command_prepare, "Go KYS");
    RegConsoleCmd("sm_ws", Command_prepare, "Go KYS");
}

public Action Command_prepare(int client, int args)
{
	KickClient(client, "Go and buy one");
	return Plugin_Handled;
}