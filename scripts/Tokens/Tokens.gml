global.tokens = 0;
function add_tokens(_value = 1) {
	global.tokens += _value;
	show_debug_message(string(_value) + " tokens added for a total of " + string(global.tokens));
	//save_tokens(); // MAYBE REMOVE if tokens only save after level completion
}

function save_tokens() {
    var _file = file_text_open_write("tokens.sav");
    file_text_write_string(_file, json_stringify({ tokens: global.tokens }));
    file_text_close(_file);
    show_debug_message("Tokens saved: " + string(global.tokens));
}

function load_tokens() {
    if (!file_exists("tokens.sav")) {
        show_debug_message("No tokens save found, using default");
		save_tokens();
        return;
    }
    var _file = file_text_open_read("tokens.sav");
    var _data = json_parse(file_text_read_string(_file));
    file_text_close(_file);
    
    if (struct_exists(_data, "tokens")) global.tokens = _data.tokens;
    show_debug_message("Tokens loaded: " + string(global.tokens));
}
load_tokens();