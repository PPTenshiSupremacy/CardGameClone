enum phases {
	start,
	deal,
	dealing,
	play,
	moving,
	resolve,
	cleanup
}
current_phase = phases.start;

//Game Setup Variables
cards = array_create(24);
discard = ds_stack_create();
deck = ds_stack_create();
activeList = ds_list_create();
pHand = ds_list_create();
turnCount = 0;
working = false;

//Shuffle Use
activeCard = false;



//Positions
pCardX = 400;
pCardY = 448;







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

cardHolder = 0;
reshuffleCount = 0;
reshuffleYPos = 352;

//Player Stats
pHealth = 75;
pAtk = 3;
pBlock = 0;

//Boss Stats
bHealth = 150;
bAtk = 6;
bBlock = 0;
bBleed = false;
