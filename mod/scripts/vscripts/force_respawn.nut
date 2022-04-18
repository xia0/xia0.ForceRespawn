global function ForceRespawnInit

void function ForceRespawnInit() {
	if (!IsRoundBased()) AddCallback_OnPlayerKilled(OnPlayerKilled);
}

void function OnPlayerKilled( entity player, entity attacker, var damageInfo ) {
	thread ForceRespawnPlayer(player, GetConVarFloat("force_respawn_time"));
}

void function ForceRespawnPlayer(entity player, float delay = 0) {

	wait delay;

	if (!IsValidPlayer(player)) return;
	if (IsPlayerEliminated( player )) return;
	if ( GetGameState() != eGameState.Playing && GetGameState() != eGameState.Epilogue && GetGameState() != eGameState.WinnerDetermined ) return;

	while (IsValidPlayer(player)) {

		if (IsAlive( player )) return;

		if (!player.IsWatchingKillReplay() && IsRespawnAvailable( player )) {
			if (Riff_SpawnAsTitan() == 1 && IsTitanAvailable(player)) ClientCommand(player, "CC_RespawnPlayer Titan");
			else ClientCommand(player, "CC_RespawnPlayer Pilot");
		}

		WaitFrame();
	}

}
