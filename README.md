# Pizza Tower: Maximized



Pizza Tower: Maximized is a recreation/port of Pizza Tower's Demo 0 or ETB build, and improves the game from that point.



### Implemented Features



|Feature|Status|
|-|-|
|Singleplayer||
|Multiplayer||
|Online Mode||
|Level Editor||
|Cross-Platform Support||







# Game Functionality





### Initialization

&#x09;When the game starts up, it starts in **Room\_Init**, and executes the room creation code.

&#x09;The room creation code includes the following:

&#x09;	the creation of struct **global.settings**

&#x09;	some debug startup settings

&#x09;**o\_UI\_Disclaimer**'s create event:

&#x09;	precache the textures and tilesets for the main menu

&#x09;	create the changelog text, with a special macro **GM\_version**

&#x09;	setup UI style (draw\_set\_...)

&#x09;	set up a key combo

&#x09;

&#x09;

