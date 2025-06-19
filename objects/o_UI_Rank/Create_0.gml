image_speed = 0.5; //Draw sprite just uses 60 fps no matter what.
var ranks = ["F", "D", "C", "B", "A", "S"];
curRank = ranks[clamp(floor(score / 500), 1, 6) - 1]; //I am so unbelievable