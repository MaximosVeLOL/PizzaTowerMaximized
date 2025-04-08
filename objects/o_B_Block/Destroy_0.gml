if(tilemap_get_at_pixel(layer_tilemap_get_id("FG"), x,y) > 0) layer_tilemap_destroy(tilemap_get_at_pixel(layer_tilemap_get_id("FG"), x, y));
event_inherited();