
game_paused = !game_paused

if (game_paused) {
	build_pause_menu()
} else {
	if (ui_exists("Pause_Menu")) {
        ui_get("Pause_Menu").destroy();
    }
}