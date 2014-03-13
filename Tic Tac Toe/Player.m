//
//  Player.m
//  Tic Tac Toe
//
//  Created by Aidan on 26/02/2014.
//  Copyright (c) 2014 Aidan. All rights reserved.
//

#import "Player.h"

@implementation Player

- (id) init
{
	[super init];
	name = [[NSString alloc] init];
	piece = [[NSString alloc] init];
	
	return self;
}

- (id) initWithName:(NSString*)n
              piece:(NSString*)p
{
	[super init];
	
	// Do I need to add some retains here?
	name = [n copy];
	piece = [p copy];
	
	return self;
}

- (void) dealloc
{
	[name release];
	[piece release];
	[super dealloc];
}

- (NSString *)name {
    return [[name retain] autorelease];
}

- (void)setName:(NSString *)value {
    if (name != value) {
        [name release];
        name = [value copy];
    }
}

- (NSString *)piece {
    return [[piece retain] autorelease];
}

- (void)setPiece:(NSString *)value {
    if (piece != value) {
        [piece release];
        piece = [value copy];
    }
}


@end
