//Every single time I run instance_activate_all(), it doesn't allow for the Game manager to destroy all instances...
//So heres my hack!
o_GameManager.level.demo = true;
o_GameManager.goToHub();