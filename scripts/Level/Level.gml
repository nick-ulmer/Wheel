global.goto_shop = false;
global.next_level_index = 0;

function Level(_name, _room, _max_timer_mins = 1) constructor {
	self.name = _name;
	self.room = _room; 
	self.max_timer_mins = _max_timer_mins;
	
	// Attributes that save and load
	self.completed = false;
	self.min_time = 60 * 60 * 60 * 24;
}

global.levels = [
	new Level("Tutorial", rm_lvl_0, 3),
	new Level("Level 1", rm_lvl_1, 1),
	new Level("Level 2", rm_lvl_2, 2),
	new Level("Level 3", rm_lvl_3, 3),
	new Level("Level 5", rm_lvl_5, 5),
	new Level("Game Completed", rm_game_completed)
]

function save_levels() {
    var _data = {};
    for (var i = 0; i < array_length(global.levels); i++) {
        var _a = global.levels[i];
        _data[$ _a.name] = {
            completed:  _a.completed,
            min_time: _a.min_time
        };
    }
    var _json = json_stringify(_data);
    var _file = file_text_open_write("levels.sav");
    file_text_write_string(_file, _json);
    file_text_close(_file);
    show_debug_message("Levels saved");
}
save_levels();

function load_levels() {
    if (!file_exists("levels.sav")) {
        show_debug_message("No levels file found, using defaults");
		global.save_levels();
        return;
    }
    var _file = file_text_open_read("levels.sav");
    var _json = file_text_read_string(_file);
    file_text_close(_file);
    
    var _data = json_parse(_json);
    for (var i = 0; i < array_length(global.levels); i++) {
        var _a = global.levels[i];
        if (struct_exists(_data, _a.name)) {
            var _saved = _data[$ _a.name];
            _a.completed  = _saved.completed;
            _a.min_time = _saved.min_time;
        }
    }
    show_debug_message("Levels loaded");
}
load_levels();

function getLevelByRoom(_room) {
    for (var i = 0; i < array_length(global.levels); i++) {
        if (global.levels[i].room == _room) return global.levels[i];
    }
    return undefined;
}

function getLevelByName(_name) {
    for (var i = 0; i < array_length(global.levels); i++) {
        if (global.levels[i].name == _name) return global.levels[i];
    }
    return undefined;
}

function getLevelIndexByRoom(_room) {
	for (var i = 0; i < array_length(global.levels); i++) {
        if (global.levels[i].room == _room) return i;
    }
    return undefined;
}

function setLevelCompleted(_room) {
	var _lvl = getLevelByRoom(_room)
	_lvl.completed = true;
	
	var _ticks = game_get_speed(gamespeed_fps) * 60 * _lvl.max_timer_mins;
	var _new_time = _ticks - gm.game_timer;
	if (_new_time < _lvl.min_time) {
		_lvl.min_time = _new_time;
	}
	
	save_levels();
}