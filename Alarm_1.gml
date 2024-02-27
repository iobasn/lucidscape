//how i figured out precisely timing dialogue with the song and events of the current intro "cinematic"
//a timer value is incremented every second and thats pretty much the anchor point of the whole operation
//upon incrementing a check is performed and if the current timer value lines up with one from the switch statement
//then x,y,z will be executed
//it's kinda ugly but really its just "do x at y time"
//in this case, dialogue is printed at specified coordinates
//there are some coordinates i preset because i knew i'd be using them alot
//other times i winged that shit with mad offsets

switch(timerVal)
{
	case 0:
		scr_createFreeSentence(midX, midY, 5, "THIS IS A STORY ABOUT A SLEEPY LITTLE WORLD TUCKED QUIETLY AWAY.", sfx_introTyping)
	break;
	
	case 10:
		scr_createFreeSentence(midX, midY - 64, 5, "A STORY ABOUT A PLACE FULL OF MANY COLORFUL SOULS.", sfx_introTyping)
	break;
	
	case 14:
		scr_createFreeSentence(midX, midY, 5, "A STORY ABOUT SACRIFICE.", sfx_introTyping)
	break;
	
	case 18:
		scr_createFreeSentence(midX, midY + 64, 12, "THE STORY OF...", sfx_introTyping)
	break;
	
	case 23:
		scr_createFreeSentence(midX, midY, 19, "LUCIDSCAPE", sfx_noiseChug, 2)
		alarm[2] += room_speed * 5.4
	break;
	
	case 30:
		scr_createFreeSentence(midX, botY + 22, 5, "THE STARS ABOVE")
	break;
	
	case 32:
		scr_createFreeSentence(midX, botY + 54, 5, "ARE REVERED BY ALL.")
	break;
	
	case 38:
		scr_createFreeSentence(midX, botY, 5, "MIRACLES HAPPENED. FATES CHANGED. DREAMS CAME TRUE WHEN STARPOWER WAS HARNESSED.")
	break;
	
	case 48:
		scr_createFreeSentence(midX, botY - 8, 5, "ALL WAS RIGHT WITH THE LUCIANS.", undefined, 0.8)
		scr_createFreeSentence(midX, botY + 22, 5, "ALL WAS RIGHT WITH THE WORLD.", undefined, 0.8)
		scr_createFreeSentence(midX, botY + 54, 5, "ALL WAS RIGHT WITH THE HEAVENS.", undefined, 0.8)
	break;
	
	case 55:
		scr_createFreeSentence(midX, botY - 8, 3, "UNTIL THE STARS WENT OUT.")
		scr_createFreeSentence(midX, botY + 22, 3, "UNTIL THE WICKED DARK CAME.")
		scr_createFreeSentence(midX, botY + 54, 5, "AND IN AN INSTANT...")
		alarm[2] += 3
		
	break;
	
	case 56:
		
	break;
	
	case 59:
		scr_createFreeSentence(midX, botY - 8, 5, "ALL STARPOWER WAS GONE.")
	break;
	
	case 60:
		scr_createFreeSentence(midX, botY + 22, 5, "ALL HOPE WAS GONE.")
	break;
	
	case 61:
		scr_createFreeSentence(midX, botY + 54, 5, "ALL PURPOSE WAS GONE...")
	break;
	
	case 74:
		alarm[2] += room_speed * 0.5
		
	break;
	
	case 77:
		scr_createFreeSentence(midX, botY, 5,  "OR SO THEY THOUGHT.")
	break;
	
	case 83:
		instance_create_layer(room_width/2, 500, "OVERTOP", obj_introCity)
		alarm[5] += 5
	break;
	
	case 84:
		scr_createFreeSentence(midX, midY - 64, 10, "LITTLE STAR")
	break;
	
	case 86:
		scr_createFreeSentence(midX, midY, 10, "BURN BRIGHT AND GO FAR")	
	break;
	
	case 87:
		scr_createFreeSentence(midX, midY + 64, 10, "LET YOUR PATH BE ONE THAT IS TRUE")
	break;
	case 90:
		//scr_createWhitePulse()
	break;
	
}
timerVal ++
alarm[1] = 60
