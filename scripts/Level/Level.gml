function Level(_name, _room) constructor {
	self.name = _name;
	self.room = _room; 
	
	// Attributes that save and load
	self.completed = false;
	self.min_time = 0;
}

global.levels = [
	new Level("Tutorial", rm_lvl_0),
	new Level("Level 1", rm_lvl_1),
	new Level("Level 2", rm_lvl_2),
	new Level("Level 3", rm_lvl_3),
	new Level("Level 5", rm_lvl_5)
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

function setLevelCompleted(_room) {
	getLevelByRoom(_room).completed = true;
	save_levels();
}