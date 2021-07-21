function writeTable() {
	ax=Math.round(Math.random()*26);
	alphaArray=new Array("a", "n", "b", "d", "f", "h", "{", "i", "l", "v", "x", "z", "I", "J", "M", "N", "o", "O", "R", "S", "T", "U", "m", "6", "^", "u", "_", "[", "]")
	table="<table border=0 cellspacing=1 cellpadding=1 width='100%'><tr>"
	j=1;
	for ( i = 99 ; i >= 0 ; i-- ) {
		a=Math.round(Math.random()*26);
		if ( i%9 == 0 &&  i < 89 ) 
			a=ax;
		table+="<td class='numtd'>"+i+"</td><td class='symtd2'>"+alphaArray[a]+"</td>"
		if ( j%10 == 0 ) 
			table+="</tr><tr>"	
		j++
	}
	table+="</table>"
	sym.innerHTML=table
	sh.innerHTML=""
}
function showAnswer() {
	sh.innerHTML=alphaArray[ax]
	sym.innerHTML="<h1><a href='javascript:writeTable()'>Вот это да! Попробуем еще раз?</a></h1>"
}

