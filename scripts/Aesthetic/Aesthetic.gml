global.ui_base = 48*2; // Size of slice times 2
global.ui_scale = (1 + 2/3) * 48;

function getUIRelScale(_scale) {
	return global.ui_base + global.ui_scale * _scale;
}