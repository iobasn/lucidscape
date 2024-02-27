//a simple script to shift array elements

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
