//
//  Board.h
//  Tic Tac Toe
//
//  Created by Aidan on 26/02/2014.
//  Copyright (c) 2014 Aidan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Board : NSObject {
	unsigned int size;
	NSMutableArray *board;
}

/* Generated via the Scripting tool */
- (NSMutableArray *)board;
- (unsigned)countOfBoard;
- (id)objectInBoardAtIndex:(unsigned)theIndex;
- (void)getBoard:(id *)objsPtr range:(NSRange)range;
- (void)insertObject:(id)obj inBoardAtIndex:(unsigned)theIndex;
- (void)removeObjectFromBoardAtIndex:(unsigned)theIndex;
- (void)replaceObjectInBoardAtIndex:(unsigned)theIndex withObject:(id)obj;
// end auto-generated

// Will you need autogenerated NSMutableArray methods in your iOS solution? Hmmm ...

- (unsigned int) size;

- (void)updateBoard:(NSString*)piece
              place:(unsigned int)position;

- (NSString *) objectAtX:(unsigned int) x
					   Y:(unsigned int) y;
- (NSString *) objectInBoardAtPosition:(unsigned int)position;

- (BOOL)emptyPosition:(unsigned int)position;

- (BOOL)winner;

@end