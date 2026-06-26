function scr_solid(_x, _y) {
	var _tilemap = layer_tilemap_get_id("Collision"); 
	var _solid_tile = place_meeting(_x,_y,_tilemap);
	var _solid = place_meeting(_x,_y,obj_solid);
	
	var _platform = place_meeting(_x,_y,obj_platform);
	if !_platform return _solid || _solid_tile;
		else if instance_place(_x,_y,obj_platform).y < bbox_bottom return _solid || _solid_tile;
		else return _platform;
}