if (game_over) return;
game_timer --;

if game_timer <= 0 {
	game_over();
}