#pragma semicolon 1
#pragma newdecls required

bool b_gHudMoney[MAXPLAYERS + 1];

public Plugin pl_info = {
	author = "Hikka",
	name = "[CSGO] Disable HUD money",
	version = "0.01",
};

public void OnPluginStart() {
	RegConsoleCmd("sm_hudmoney", sm_hudmoney);
}

public void OnClientPutInServer(int client) {
	b_gHudMoney[client] = false;
}

public Action sm_hudmoney(int client, int args) {
	if (client && IsClientInGame(client)) {
		if (b_gHudMoney[client]) {
			HudMoney(1, client);	// display money HUD
			b_gHudMoney[client] = false;
		} else {
			HudMoney(0, client);	// hide money HUD
			b_gHudMoney[client] = true;
		}
	}
	return Plugin_Handled;
}
				
			
stock void HudMoney(int number, int client) {
	char num[5];
	FormatEx(num, sizeof(num), "%d", number);
	SendConVarValue(client, FindConVar("mp_playercashawards"), num);
	SendConVarValue(client, FindConVar("mp_teamcashawards"), num);
	PrintToChat(client, "\x01You \x04%s \x01hud money", (b_gHudMoney[client] = !b_gHudMoney[client]) ? "hide" : "display");
}
