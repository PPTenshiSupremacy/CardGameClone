enum phases {
	start,
	deal,
	dealing,
	play,
	moving,
	resolve,
	cleanup
}
cards = array_create(48);
discard = ds_stack_create();
deck = ds_stack_create();
activeList = ds_list_create();
current_phase = phases.start;
cards_dealt = 0;
ai_cardX = 160;
ai_cardY = 96;
player_cardX = 160;
player_cardY = 416.00;
ai_turn = true;
lerpPercent = 0.28;
chosenCard = 0;
aiScore = 0;
plScore = 0;
cardIndex = 0;
lerped = 0;
depthCount = 0;
yPosDiscard = 320;
activeCard = false;
cardHolder = 0;
reshuffleCount = 0;
reshuffleYPos = 352;