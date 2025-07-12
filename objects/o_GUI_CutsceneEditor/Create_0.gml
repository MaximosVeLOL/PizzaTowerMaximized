event_inherited();

add(new Screen());
timestamp = 0;
screens[0].Add(new Slider(0,400, 960, 140, 0, function(t){timestamp = t}), "timestamp_gui");
