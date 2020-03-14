#include <sourcemod>
#include <sdktools>

//Try to include sbpp
#undef REQUIRE_PLUGIN
#tryinclude <sourcebanspp>
#define SERVER 0

#pragma semicolon 1
#pragma newdecls required

public Plugin myinfo = {
		name = "Skins-remover",
		author = "Qawery",
		description = "No more !knife",
		url = "https://github.com/qawery-just-sad/skins-remover",
		version = "1.1"
}

//Cvars Reset
ConVar sm_skins_punish_type = null;
ConVar sm_skins_need_knife = null;
ConVar sm_skins_ban_time = null;
ConVar sm_skins_message = null;


public void OnPluginStart()
{		
		SetConVars();

		RegConsoleCmd("sm_glove", Prepare, "Go KYS");
		RegConsoleCmd("sm_gloves", Prepare, "Go KYS");
		RegConsoleCmd("sm_ws", Prepare, "Go KYS");

		NeedKnife();
}

public void SetConVars()
{
		sm_skins_punish_type = CreateConVar("sm_skins_punish_type", "0", "Controls punishment type 0=Kick, 1=Ban (Default=0)", FCVAR_NOTIFY, true, 0.0, true, 1.0);
		sm_skins_need_knife = CreateConVar("sm_skins_need_knife", "0", "If you want to have !knife (for people that lost their knife while surfing/bhoping) set it to 1, if you want to kick/ban those loosers leave it be", FCVAR_NOTIFY, true, 0.0, true, 1.0);
		sm_skins_ban_time = CreateConVar("sm_skins_ban_time", "5", "Controls ban time 0=Permaban, any other number represents minutes (Default=5)");
		sm_skins_message = CreateConVar("sm_skins_message", "Go and buy one!", "Message that is displayed when kicked / ban reason (512 characters limit)");

		AutoExecConfig(true, "skins-remover");
}

public void NeedKnife()
{
		if(sm_skins_need_knife.BoolValue == false)
		{
				RegConsoleCmd("sm_knife", Prepare, "Go KYS");
		}
		else
		{
			PrintToServer("[Skin-remover] You can get your knife back");
		}
}

public Action Prepare(int client, int args)
{	
	char reason[512];
	sm_skins_message.GetString(reason, 512);

	if(sm_skins_punish_type.BoolValue == false)
	{
			KickClient(client, reason);
			return Plugin_Handled;
	}
	if(sm_skins_punish_type.BoolValue == true)
	{
			int time = GetConVarInt(sm_skins_ban_time);
			if(defined _sourcebanspp_included)
			{
					SBPP_BanPlayer(SERVER, client, time, reason);
					return Plugin_Handled;
			}
			else
			{
					BanClient(client, time, BANFLAG_AUTO, reason);
					return Plugin_Handled;
			}
	}
	else
	{
			PrintToServer("It's 1 or 0. Wich one are you?");
			return Plugin_Handled;
	}
}
