// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_shiftArrayElementsForward(_array){
	{ 
		for(var i = 0; i < array_length(_array) - 1; i++)
		{
			var temp = _array[i + 1]
			_array[i + 1] = _array[i]
			_array[i] = temp	
		}
	}
}