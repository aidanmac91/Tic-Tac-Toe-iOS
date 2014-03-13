//
//  Board.m
//  Tic Tac Toe
//
//  Created by Aidan on 26/02/2014.
//  Copyright (c) 2014 Aidan. All rights reserved.
//

#import "Board.h"

@implementation Board
- (id) init
{
	if(self = [super init]){
		size = 3;
		board = [[NSMutableArray alloc] init];
		
		int i = 0;
		int j = 1;
		
		for(i=0;i<size;i++){
			NSNumber *num1,*num2,*num3;
			num1 = [[NSNumber alloc] initWithInt: j++];
			num2 = [[NSNumber alloc] initWithInt: j++];
			num3 = [[NSNumber alloc] initWithInt: j++];
			
			[board insertObject: [[NSMutableArray alloc]initWithObjects: [num1 stringValue], [num2 stringValue], [num3 stringValue], nil] atIndex: i];
			
			//[num1 release];
			//[num2 release];
			//[num3 release];
		}
		
	}
	return self;
}
- (void) dealloc
{
	[board release];
	[super dealloc];
}
- (unsigned int) size
{
	return size;
}
/* Start auto-generated code */
- (NSMutableArray *)board {
    if (!board) {
        board = [[NSMutableArray alloc] init];
    }
    return [[board retain] autorelease];
}
- (unsigned)countOfBoard {
    if (!board) {
        board = [[NSMutableArray alloc] init];
    }
    return [board count];
}
- (id)objectInBoardAtIndex:(unsigned)theIndex {
    if (!board) {
        board = [[NSMutableArray alloc] init];
    }
    return [board objectAtIndex:theIndex];
}
- (void)getBoard:(id *)objsPtr range:(NSRange)range {
    if (!board) {
        board = [[NSMutableArray alloc] init];
    }
    [board getObjects:objsPtr range:range];
}
- (void)insertObject:(id)obj inBoardAtIndex:(unsigned)theIndex {
    if (!board) {
        board = [[NSMutableArray alloc] init];
    }
    [board insertObject:obj atIndex:theIndex];
}
- (void)removeObjectFromBoardAtIndex:(unsigned)theIndex {
    if (!board) {
        board = [[NSMutableArray alloc] init];
    }
    [board removeObjectAtIndex:theIndex];
}
- (void)replaceObjectInBoardAtIndex:(unsigned)theIndex withObject:(id)obj {
    if (!board) {
        board = [[NSMutableArray alloc] init];
    }
    [board replaceObjectAtIndex:theIndex withObject:obj];
}
/* End Auto Generated code */
- (NSString *) objectAtX:(unsigned int) x
					   Y:(unsigned int) y
{
	if((x < [self size]) && (y < [self size]))
		return [[[[board objectAtIndex: x] objectAtIndex:y] retain] autorelease];
	else
		return nil;
}
- (void) updateBoard:(NSString*)piece
			   place:(unsigned int)position
{
	NSLog(@"Update element %d with a %@", position, piece);
	
	//int row = position/3;	// Gets row index of place
    int row = --position/3;
	int column = position%3;	// Gets column index of place
	NSLog(@"Row: %d Col: %d", row, column);
	[[board objectAtIndex: row] replaceObjectAtIndex:column withObject: piece];
}
-(NSString *) objectInBoardAtPosition:(unsigned int)position
{
	NSString *piece;
	id p;
	
	int row = --position/3;
	int column = position%3;
	
	p = [[board objectAtIndex: row] objectAtIndex:column];
	
	if ([p isKindOfClass:[NSNumber class]])
		piece = [p stringValue];
	else
		piece = p;
	
	return piece;
}
-(BOOL)emptyPosition:(unsigned int)position
{
	NSString *piece;
	id p;
	
	int row = --position/3;
	int column = position%3;
	
	p = [[board objectAtIndex: row] objectAtIndex:column];
	
	if ([p isKindOfClass:[NSNumber class]])
		piece = [p stringValue];
	else
		piece = p;
    
	// maybe I should create a piece class?
	
	if([piece isEqualToString:@"X"])
		return NO;
	else if ([piece isEqualToString:@"O"])
		return NO;
	else
		return YES;
}
-(BOOL)winner
{
	BOOL winner = NO;
	int row = 0;
	
	NSString *s1;
	NSString *s2;
	NSString *s3;
	
	/*
	 Winning lines
	 
	 // diagonals
	 00 11 22
	 02 11 20
	 
	 // verticals and horizontals
	 00 01 02
	 00 10 20
	 
	 10 11 12
	 01 11 21
	 
	 20 21 22
	 02 12 22
	 */
	
	/* check for diagonals first */
	/* Using extensions of 'line' in case we want to increase from the 3 x 3 size later on */
	
	// Diagonal tl to br
	
	while((row ==0) && (!winner)){
		s1 = [self objectAtX:row
						   Y:row];
		s2 = [self objectAtX:row+1
						   Y:row+1];
		s3 = [self objectAtX:row+2
						   Y:row+2];
		
		//NSLog(@"Comparing %@ with %@ and %@.", s1, s2, s3);
		if(([s1 isEqualToString: s2]) && ([s1 isEqualToString:s3])){
			winner = YES;
			break;
		} // end if
		
		// Diagnoal tr to br
		
		s1 = [self objectAtX:row
						   Y:row+2];
		s2 = [self objectAtX:row+1
						   Y:row+1];
		s3 = [self objectAtX:row+2
						   Y:row];
		
		//NSLog(@"Comparing %@ with %@ and %@.", s1, s2, s3);
		if(([s1 isEqualToString: s2]) && ([s1 isEqualToString:s3])){
			winner = YES;
			break;
		} // end if
		
		// Verticals and Horizontals
		/*
		 00 01 02
		 00 10 20
		 
		 10 11 12
		 01 11 21
		 
		 20 21 22
		 02 12 22
		 */
		for (row=0;row<[self size];row++){
			int zero = 0;
			int col = row;
			
			s1 = [self objectAtX:row
							   Y:zero];
			s2 = [self objectAtX:row
							   Y:zero+1];
			s3 = [self objectAtX:row
							   Y:zero+2];
			
			//NSLog(@"Comparing %@ with %@ and %@.", s1, s2, s3);
			if(([s1 isEqualToString: s2]) && ([s1 isEqualToString:s3])){
				winner = YES;
				break;
			}
			
			s1 = [self objectAtX:zero
							   Y:col];
			s2 = [self objectAtX:zero+1
							   Y:col];
			s3 = [self objectAtX:zero+2
							   Y:col];
			
			//NSLog(@"Comparing %@ with %@ and %@.", s1, s2, s3);
			
			if(([s1 isEqualToString: s2]) && ([s1 isEqualToString:s3])){
				winner = YES;
				break;
			}
		}
	}
	return winner;
}
@end

