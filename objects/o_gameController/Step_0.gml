switch(current_phase) {
	case phases.start:
		for(i = 0; i < 24; i++) {
			if(i<6){
				var block = instance_create_layer(64,352,"Instances", o_block);
				cards[i] = block;
				show_debug_message("Making block");
			}
			else if(i>=6 && i<12){
				var strike = instance_create_layer(64,352,"Instances", o_strike);
				cards[i] = strike;
				show_debug_message("Making strike");
			}
			else if(i>=12 && i<16){
				var warcry = instance_create_layer(64,352,"Instances", o_warcry);
				cards[i] = warcry;
				show_debug_message("Making warcry");
			}
			else if(i>=16 && i<20){
				var gouge = instance_create_layer(64,352,"Instances", o_gouge);
				cards[i] = gouge;
				show_debug_message("Making gouge");
			}
			else if(i>=20 && i<24){
				var fStrike = instance_create_layer(64,352,"Instances", o_flamestrike);
				cards[i] = fStrike;
				show_debug_message("Making fStrike");
			}
		}
		randomise();
		//var shuffleDeck = array_shuffle(cards);//Shuffle the array
		array_shuffle_ext(cards);
		for(i = 0; i<24; i++) {
			ds_stack_push(deck, cards[i]);//Copy array into stack
			show_debug_message(i);
		}
		//Reset positions to pile properly
		yPos = 320;
		for(i = 0; i<ds_stack_size(deck); i++) {
			cards[i].y=yPos;
			cards[i].depth = -i;
			if(i % 3 == 0){
				yPos-=4;
			}
		}
		current_phase = phases.deal;
		show_debug_message("End Phase 1");
		break;
	case phases.deal:
		if(ds_stack_size(deck) != 0){//Check if there are cards in deck
			//Go through basic game loop
			//Assign card labels for dealing phase
			/*c1 = ds_stack_pop(deck);
			c2 = ds_stack_pop(deck);
			c3 = ds_stack_pop(deck);
			c4 = ds_stack_pop(deck);
			c5 = ds_stack_pop(deck);
			c6 = ds_stack_pop(deck);
			ds_list_add(activeList, c1);
			ds_list_add(activeList, c2);
			ds_list_add(activeList, c3);
			ds_list_add(activeList, c4);
			ds_list_add(activeList, c5);
			ds_list_add(activeList, c6);*/
			if(turnCount == 0){//Draw 3 cards if T0, otherwise draw 1
				/*for(i=0; i<3; i++;){
					var offset = i*16;
					ds_list_add(pHand, ds_stack_pop(deck));
					lerpTo(pHand[| i], pCardX-offset, pCardY)
				}*/
				
			}
			else{
				var temp = ds_stack_pop(deck)
				var offset = ds_list_size(pHand)*16;
				ds_list_add(pHand, temp);
				lerpTo(temp, pCardX-offset, pCardY)
			}
			current_phase = phases.dealing;
		}
		else{//Reshuffle discard pile into deck
			//show_debug_message("Reshuffling");
			//reshuffling = true;
			if(activeCard == false && ds_stack_size(discard)!=0){//If card is not active, start new one
				activeCard = true;
				cardHolder = ds_stack_pop(discard);
			}
			else if(activeCard == true){
				if(int64(cardHolder.x) != 64){
					cardHolder.faceUp = false;
					var currentX = cardHolder.x;
					var currentY = cardHolder.y;
					var xx = lerp(currentX, 64, 0.8);
					var yy = lerp(currentY, reshuffleYPos, 0.8);
					//Move card
					cardHolder.x = xx;
					cardHolder.y = yy;
					//show_debug_message(int64(cardHolder.x));
				}
				else if(int64(cardHolder.x) == 64){
					reshuffleCount++;
					audio_play_sound(moveCard, 10, false);
					cardHolder.depth = -reshuffleCount;
					if(reshuffleCount%3 == 0){
						reshuffleYPos -=4;
					}
					activeCard = false;
				}
			}
			else if(activeCard == false && ds_stack_size(discard) == 0){
				array_shuffle_ext(cards);
				for(i = 0; i<48; i++) {
					ds_stack_push(deck, cards[i]);//Copy array into stack
					show_debug_message("Adding cards to deck");
				}
				//Reset positions to pile properly
				yPos = 320;
				for(i = 0; i<ds_stack_size(deck); i++) {
					cards[i].y=yPos;
					cards[i].depth = -i;
					if(i % 3 == 0){
						yPos-=4;
					}
				}
				yPosDiscard = 320;
				reshuffleCount = 0;
				reshuffleYPos = 320;
			}
		}
		//show_debug_message("End Phase 2");
		break;
	/*case phases.dealing:
		switch(cards_dealt){
			case 0:
				var currentX = c1.x;
				var currentY = c1.y;
				var xx = lerp(currentX, ai_cardX, lerpPercent);
				var yy = lerp(currentY, ai_cardY, lerpPercent);
				//Move card
				c1.x = xx;
				c1.y = yy;
				if(int64(c1.y) ==ai_cardY){
					cards_dealt++;
					audio_play_sound(moveCard, 10, false);
				}
				//+96 between cards
				break;
			case 1:
				var currentX = c2.x;
				var currentY = c2.y;
				var xx = lerp(currentX, ai_cardX+96, lerpPercent);
				var yy = lerp(currentY, ai_cardY, lerpPercent);
				//Move card
				c2.x = xx;
				c2.y = yy;
				if(int64(c2.y) ==ai_cardY){
					cards_dealt++;
					audio_play_sound(moveCard, 10, false);
				}
				break;
			case 2:
				var currentX = c3.x;
				var currentY = c3.y;
				var xx = lerp(currentX, ai_cardX+192, lerpPercent);
				var yy = lerp(currentY, ai_cardY, lerpPercent);
				//Move card
				c3.x = xx;
				c3.y = yy;
				if(int64(c3.y) ==ai_cardY){
					cards_dealt++;
					audio_play_sound(moveCard, 10, false);
				}
				break;
			case 3:
				var currentX = c4.x;
				var currentY = c4.y;
				var xx = lerp(currentX, player_cardX, lerpPercent);
				var yy = lerp(currentY, player_cardY, lerpPercent);
				//Move card
				c4.x = xx;
				c4.y = yy;
				c4.faceUp = true;
				if(int64(c4.y)+1 ==player_cardY){
					cards_dealt++;
					audio_play_sound(moveCard, 10, false);
				}
				break;
			case 4:
				var currentX = c5.x;
				var currentY = c5.y;
				var xx = lerp(currentX, player_cardX+96, lerpPercent);
				var yy = lerp(currentY, player_cardY, lerpPercent);
				//Move card
				c5.x = xx;
				c5.y = yy;
				c5.faceUp = true;
				if(int64(c5.y)+1 ==player_cardY){
					cards_dealt++;
					audio_play_sound(moveCard, 10, false);
				}
				break;
			case 5:
				var currentX = c6.x;
				var currentY = c6.y;
				var xx = lerp(currentX, player_cardX+192, lerpPercent);
				var yy = lerp(currentY, player_cardY, lerpPercent);
				//Move card
				c6.x = xx;
				c6.y = yy;
				c6.faceUp = true;
				if(int64(c6.y)+1 ==player_cardY){
					cards_dealt = 0;
					audio_play_sound(moveCard, 10, false);
					current_phase = phases.play;
					show_debug_message("End Phase 3");
				}
				break;
		}
		break;
	case phases.play:
		switch(ai_turn){
			case true:
				var currentX = c2.x;
				var currentY = c2.y;
				var xx = lerp(currentX, ai_cardX+96, lerpPercent);
				var yy = lerp(currentY, 208, lerpPercent);
				//Move card
				c2.x = xx;
				c2.y = yy;
				if(int64(c2.y)+1 ==208){
					ai_turn = false;
					audio_play_sound(moveCard, 10, false);
				}
				//show_debug_message(ai_turn)
				//ai_card+96,176 
				break;
			case false:
				//Move forward on hover
				//Card 1 pos: 127, 192
				if(mouse_x>=127 && mouse_x<=192 && mouse_y>=368 && mouse_y<=463 && mouse_check_button_pressed(mb_left)){
				//Save card to move
					chosenCard = c4;
				//Move to next phase
					current_phase = phases.resolve;
					show_debug_message("C4 selected");
					audio_play_sound(moveCard, 10, false);
					c2.faceUp = true;
					cardIndex = ds_list_find_index(activeList, chosenCard);
				}
				else if(mouse_x>=127 && mouse_x<=192 && mouse_y>=368 && mouse_y<=463)//Card 4
				{
					c4.y = player_cardY - 16;
				}
				
				else{
					c4.y = player_cardY;
				}
				if(mouse_x>=223 && mouse_x<=288 && mouse_y>=368 && mouse_y<=463 && mouse_check_button_pressed(mb_left)){
				//Save card to move
					chosenCard = c5;
				//Move to next phase
					current_phase = phases.resolve;
					show_debug_message("C5 selected");
					audio_play_sound(moveCard, 10, false);
					c2.faceUp = true;
					cardIndex = ds_list_find_index(activeList, chosenCard);
				}
				else if(mouse_x>=223 && mouse_x<=288 && mouse_y>=368 && mouse_y<=463)//Card 5
				{
					c5.y = player_cardY - 16;
				}
				
				else{
					c5.y = player_cardY;
				}
				//Card 3 pos: 319, 384
				if(mouse_x>=319 && mouse_x<=384 && mouse_y>=368 && mouse_y<=463 && mouse_check_button_pressed(mb_left)){
				//Save card to move
					chosenCard = c6;
				//Move to next phase
					current_phase = phases.resolve;
					c2.faceUp = true;
					show_debug_message("C6 selected");
					audio_play_sound(moveCard, 10, false);
					cardIndex = ds_list_find_index(activeList, chosenCard);
				}
				else if(mouse_x>=319 && mouse_x<=384 && mouse_y>=368 && mouse_y<=463)//Card 6
				{
					c6.y = player_cardY - 16;
				}
				else{
					c6.y = player_cardY;
				}
				//player_card+96, 304   112 diff
				break;
		}
		break;
	case phases.resolve:
		//Move chosen card, then compare values
		if(int64(chosenCard.y) != 312){
			var currentX = chosenCard.x;
			var currentY = chosenCard.y;
			var xx = lerp(currentX, player_cardX+96, lerpPercent);
			var yy = lerp(currentY, 312, lerpPercent);
			//Move card
			chosenCard.x = xx;
			chosenCard.y = yy;
		}
		else if(int64(chosenCard.y) == 312){//If card has reached position start checking for score
			audio_play_sound(moveCard, 10, false);
			//Comparisons
			if(c2.cType == chosenCard.cType){//Draw, move to cleanup
				current_phase = phases.cleanup;
			}
			else if(c2.cType == 0 && chosenCard.cType == 1){//AI Paper player rock
				aiScore++;
				audio_play_sound(losePoint, 15, false);
				current_phase = phases.cleanup;
			}
			else if(c2.cType == 0 && chosenCard.cType == 2){//AI Paper player scissors
				plScore++;
				audio_play_sound(getPoint, 15, false);
				current_phase = phases.cleanup;
			}
			else if(c2.cType == 1 && chosenCard.cType == 0){//AI rock player paper
				plScore++;
				audio_play_sound(getPoint, 15, false);
				current_phase = phases.cleanup;
			}
			else if(c2.cType == 1 && chosenCard.cType == 2){//AI rock player scissors
				aiScore++;
				audio_play_sound(losePoint, 15, false);
				current_phase = phases.cleanup;
			}
			else if(c2.cType == 2 && chosenCard.cType == 0){//AI scissors player paper
				aiScore++;
				audio_play_sound(losePoint, 15, false);
				current_phase = phases.cleanup;
			}
			else if(c2.cType == 2 && chosenCard.cType == 1){//AI scissors player rock
				plScore++;
				audio_play_sound(getPoint, 15, false);
				current_phase = phases.cleanup;
			}
		}
		break;
	case phases.cleanup://448 320
		//if(ds_stack_size(discard)%3 == 0){
		//	yPosDiscard -=4;
		//}
		show_debug_message("Discard Y Val");
		show_debug_message(yPosDiscard);
			switch(lerped){
				case 0:
					if(int64(c2.x)+1 != 448){
						var currentX = c2.x;
						var currentY = c2.y;
						var xx = lerp(currentX, 448, lerpPercent);
						var yy = lerp(currentY, yPosDiscard, lerpPercent);
						//Move card
						c2.x = xx;
						c2.y = yy;
					}
					else if(int64(c2.x)+1 == 448){//AI card arrives at designated location
						ds_stack_push(discard, c2);
						audio_play_sound(moveCard, 10, false);
						lerped++;
						c2.depth = depthCount;
						depthCount--;
						ds_list_delete(activeList, ds_list_find_index(activeList, c2));
						show_debug_message("AI Card Delisted");
						if(ds_stack_size(discard)%3 == 0){
							yPosDiscard -=4;
						}
						
					}
					break;
				case 1://Move player card
					if(int64(chosenCard.x)+1 != 448){
						var currentX = chosenCard.x;
						var currentY = chosenCard.y;
						var xx = lerp(currentX, 448, lerpPercent);
						var yy = lerp(currentY, yPosDiscard, lerpPercent);
						//Move card
						chosenCard.x = xx;
						chosenCard.y = yy;
					}
					else if(int64(chosenCard.x)+1 == 448){//Player card arrives at designated location
						ds_stack_push(discard, chosenCard);
						audio_play_sound(moveCard, 10, false);
						lerped++;
						chosenCard.depth = depthCount;
						depthCount--;
						show_debug_message("Player Card Delisted");
						ds_list_delete(activeList, ds_list_find_index(activeList,chosenCard));
						show_debug_message(ds_list_size(activeList));
						if(ds_stack_size(discard)%3 == 0){
							yPosDiscard -=4;
						}
					}
					break;
				case 2:
					if(int64(activeList[| 0].x)+1 != 448){
						activeList[| 0].faceUp = true;
						var currentX = activeList[| 0].x;
						var currentY = activeList[| 0].y;
						var xx = lerp(currentX, 448, lerpPercent);
						var yy = lerp(currentY, yPosDiscard, lerpPercent);
						//Move card
						activeList[| 0].x = xx;
						activeList[| 0].y = yy;
					}
					else if(int64(activeList[| 0].x)+1 == 448){//AI card arrives at designated location
						ds_stack_push(discard, activeList[| 0]);
						audio_play_sound(moveCard, 10, false);
						lerped++;
						activeList[| 0].depth = depthCount;

						depthCount--;
						show_debug_message("Card Delisted");
						ds_list_delete(activeList, 0);
						show_debug_message(ds_list_size(activeList));
						if(ds_stack_size(discard)%3 == 0){
							yPosDiscard -=4;
						}
					}
					break;
				case 3:
					if(int64(activeList[| 0].x)+1 != 448){
						activeList[| 0].faceUp = true;
						var currentX = activeList[| 0].x;
						var currentY = activeList[| 0].y;
						var xx = lerp(currentX, 448, lerpPercent);
						var yy = lerp(currentY, yPosDiscard, lerpPercent);
						//Move card
						activeList[| 0].x = xx;
						activeList[| 0].y = yy;
					}
					else if(int64(activeList[| 0].x)+1 == 448){//AI card arrives at designated location
						ds_stack_push(discard, activeList[| 0]);
						audio_play_sound(moveCard, 10, false);
						lerped++;
						activeList[| 0].depth = depthCount;
						activeList[| 0].faceUp = true;
						depthCount--;
						show_debug_message("Card Delisted");
						ds_list_delete(activeList, 0);
						show_debug_message(ds_list_size(activeList));
						if(ds_stack_size(discard)%3 == 0){
							yPosDiscard -=4;
						}
						
					}
					break;
				case 4:
					if(int64(activeList[| 0].x)+1 != 448){
						activeList[| 0].faceUp = true;
						var currentX = activeList[| 0].x;
						var currentY = activeList[| 0].y;
						var xx = lerp(currentX, 448, lerpPercent);
						var yy = lerp(currentY, yPosDiscard, lerpPercent);
						//Move card
						activeList[| 0].x = xx;
						activeList[| 0].y = yy;
					}
					else if(int64(activeList[| 0].x)+1 == 448){//AI card arrives at designated location
						ds_stack_push(discard, activeList[| 0]);
						audio_play_sound(moveCard, 10, false);
						lerped++;
						activeList[| 0].depth = depthCount;
						activeList[| 0].faceUp = true;
						depthCount--;
						show_debug_message("Card Delisted");
						ds_list_delete(activeList, 0);
						show_debug_message(ds_list_size(activeList));
						if(ds_stack_size(discard)%3 == 0){
							yPosDiscard -=4;
						}
					}
					break;
				case 5:
					if(int64(activeList[| 0].x)+1 != 448){
						activeList[| 0].faceUp = true;
						var currentX = activeList[| 0].x;
						var currentY = activeList[| 0].y;
						var xx = lerp(currentX, 448, lerpPercent);
						var yy = lerp(currentY, yPosDiscard, lerpPercent);
						//Move card
						activeList[| 0].x = xx;
						activeList[| 0].y = yy;
					}
					else if(int64(activeList[| 0].x)+1 == 448){//AI card arrives at designated location
						ds_stack_push(discard, activeList[| 0]);
						audio_play_sound(moveCard, 10, false);
						lerped++;
						activeList[| 0].depth = depthCount;
						activeList[| 0].faceUp = true;
						depthCount--;
						show_debug_message("Card Delisted");
						if(ds_stack_size(discard)%3 == 0){
							yPosDiscard -=4;
						}
						show_debug_message("Cleanup complete");
						ds_list_delete(activeList, 0);
						show_debug_message(ds_list_size(activeList));
						show_debug_message("Discard Pile Size");
						show_debug_message(ds_stack_size(discard));
						show_debug_message("Deck Size");
						show_debug_message(ds_stack_size(deck));
						current_phase = phases.deal;
						ai_turn = true;
						lerped = 0;
						shuffleTime = true;
					}
					break;
			}*/
		break;
	default:
}