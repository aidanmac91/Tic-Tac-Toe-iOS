//
//  TicTacToeViewController.h
//  Tic Tac Toe
//
//  Created by Aidan on 26/02/2014.
//  Copyright (c) 2014 Aidan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Board.h"
#import "Player.h"
#import "ComputerPlayer.h"

#import <AVFoundation/AVFoundation.h>
#import <Social/Social.h>
#import <Twitter/Twitter.h>



@interface TicTacToeViewController : UIViewController <AVAudioPlayerDelegate>
{
    UIWindow *window;
	
    //IBOutlet NSMatrix *gameBoard;
    
    IBOutlet UIButton *gameBoardButton1;
    IBOutlet UIButton *gameBoardButton2;
    IBOutlet UIButton *gameBoardButton3;
    IBOutlet UIButton *gameBoardButton4;
    IBOutlet UIButton *gameBoardButton5;
    IBOutlet UIButton *gameBoardButton6;
    IBOutlet UIButton *gameBoardButton7;
    IBOutlet UIButton *gameBoardButton8;
    IBOutlet UIButton *gameBoardButton9;
    
	IBOutlet UITextField *playerMessage;
	IBOutlet UITextField *playerMessageWinner;
	IBOutlet UIButton *playAGame;
	IBOutlet UISwitch *computerPlayerToggle;
	IBOutlet UIActivityIndicatorView *computerThinking;
    IBOutlet UISwitch *muteSwitch;
	
	BOOL computerPlayer;
	Board *board;
	Player *p1;
	Player *p2;
	Player *currentPlayer;
    int move;
    BOOL winner;
    AVAudioPlayer *audioPlayer;//sounds when button presses
    bool mute;//is the sound active
    AVAudioPlayer *background;//background music
}

-(void)Sound;//plays sound according to what player is currentPlayer
-(IBAction)muteSounds:(id)sender;//mutes all sounds depending on toggle
-(void) tweetResult:(NSString*)string;

//robs methods
- (IBAction) piecePlayed:(id)sender;
- (IBAction) drawBoard: (id)sender;
- (IBAction) setUpGame:(id)sender;
- (void) gameResetOptions;
- (void) playComputerMove;
- (void) displayMessage:(NSString*)message;


@property (assign) IBOutlet UIWindow *window;

@end
