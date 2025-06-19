alpha += faded ? -0.05 : 0.05;
if(alpha == 1 && !faded) {
    onFade();
	faded = true;
}
/*
if(alpha <= 0.5 && faded) {
}
*/
if(alpha == 0) {
	instance_destroy();
}