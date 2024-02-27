// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_save(){
	global.currentRoom = room;
	ini_open("lucidscape.ini");
	ini_write_string(string(global.filechoice), "MEDIUM", string(global.current_medium.my_stats.NAME));
	ini_write_real(string(global.filechoice), "CURRENT LIFE", global.current_medium.my_stats.LIFE);
	ini_write_real(string(global.filechoice), "MAX LIFE", global.current_medium.my_stats.MAXLIFE);
	ini_write_real(string(global.filechoice), "MONEY", global.current_medium.my_stats.MONEY);
	ini_write_real(string(global.filechoice), "SAVED", global.current_medium.my_stats.SAVED);
	ini_write_real(string(global.filechoice), "ROOM", global.currentroom);
	ini_write_real(string(global.filechoice), "X", global.current_medium.x);
	ini_write_real(string(global.filechoice), "Y", global.current_medium.y);
	ini_close();

}