//
//  ComputerPlayer.h
//  Tic Tac Toe
//
//  Created by Aidan on 26/02/2014.
//  Copyright (c) 2014 Aidan. All rights reserved.
//

#import "Player.h"
#import "Board.h"

typedef enum{
	kEasy,
	kNormal,
	kHard
} DifficultyLevel;

@interface ComputerPlayer : Player {
	DifficultyLevel difficultyLevel;
}

- (id)initWithPiece:(NSString *)piece;

- (int) getComputerMove:(Board *)board;

@end
