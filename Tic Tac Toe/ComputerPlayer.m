//
//  ComputerPlayer.m
//  Tic Tac Toe
//
//  Created by Aidan on 26/02/2014.
//  Copyright (c) 2014 Aidan. All rights reserved.
//

#import "ComputerPlayer.h"

@implementation ComputerPlayer

- (id) init
{
	// setting difficultyLevel by default to kEasy for the time being
	// If we wish to add in more advanced AI capabilities later, we can reset this
	difficultyLevel = kEasy;
	
	[super initWithName:@"Computer Player" piece:@"O"];
	
	return self;
}


- (id) initWithPiece:(NSString *) p
{
	difficultyLevel = kEasy;
	
	[super initWithName:@"Computer Player"
				  piece:p];
	
	return self;
}

- (int)getComputerMove:(Board *)board
{
	/* Calling this an AI would be extremely kind, but we might add to this later */
	int move;
	
	if(difficultyLevel == kEasy){
		
		// Computer will try to take the centre piece, if that is unavailable
		// select random number between 1 - 9
		// check if empty
		// if empty, return num, else go again
		
		unsigned int rnd = 5;
		
		while(![board emptyPosition:rnd]){
			srandom(time(NULL));
			rnd = (random() % 9) + 1;
		}
        
		
		move = rnd;
	}
	
	return move;
}

@end
