global.ui_base = 48*2; // Size of slice times 2
global.ui_scale = (1 + 2/3) * 48;

function getUIRelScale(_scale) {
	return global.ui_base + global.ui_scale * _scale;
}

function TimerText(_ticks) {
    var _seconds = _ticks div game_get_speed(gamespeed_fps);
    var _minutes = _seconds div 60;
    _seconds = _seconds mod 60;
    return string(_minutes) + ":" + string_format(_seconds, 2, 0);
}