function lerpTo(card, xFinal, yFinal){
	var currentX = card.x;
	var currentY = card.y;
	var xx = lerp(currentX, xFinal, lerpPercent);
	var yy = lerp(currentY, yFinal, lerpPercent);
	//Move card
	card.x = xx;
	card.y = yy;
	if(int64(card.x) == xFinal && int64(card.y) == yFinal){
		audio_play_sound(moveCard, 10, false);
		return true;
	}
	return false;
}