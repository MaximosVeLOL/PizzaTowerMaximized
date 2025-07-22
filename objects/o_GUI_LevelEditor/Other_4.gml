//room_width = 960;
//room_height = 540;
//view_enabled = true;
//room_persistent = true;
//view_visible[0] = true;
//camera_create_view(0,0, 960, 540);
//view_wport[0] = 960;
//view_hport[0] = 540;
//camera_set_view_target(view_camera[0], o_GUI_LevelEditor);

var bg = layer_background_create(layer_create(100, "Background"), sprite_editor_background);
layer_background_htiled(bg, true);
layer_background_vtiled(bg, true);