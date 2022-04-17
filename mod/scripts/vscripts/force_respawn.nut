global function ForceRespawnInit

void function ForceRespawnInit() {
	if (!IsRoundBased()) AddCallback_OnPlayerKilled(OnPlayerKilled);
}

void function OnPlayerKilled( entity player, entity attacker, var damageInfo ) {
	thread ForceRespawnPlayer(player, GetConVarFloat("force_respawn_time"));
}

void function ForceRespawnPlayer(entity player, float delay) {
	float lastSpawnTimeAtDeath = GetPlayerLastRespawnTime(player);
	wait delay;
	if (IsValidPlayer(player) && RespawnsEnabled() && !IsAlive(player) && GetPlayerLastRespawnTime(player) == lastSpawnTimeAtDeath) {
		if (Riff_SpawnAsTitan() == 1) thread RespawnAsTitan(player);
		else RespawnAsPilot(player);
	}
}
