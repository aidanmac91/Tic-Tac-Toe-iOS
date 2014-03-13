//
//  TicTacToeViewController.m
//  Tic Tac Toe
//
//  Created by Aidan on 26/02/2014.
//  Copyright (c) 2014 Aidan. All rights reserved.
//

#import "TicTacToeViewController.h"

@interface TicTacToeViewController ()

@end

@implementation TicTacToeViewController

/**
 handles the setup
 */
- (void)viewDidLoad
{
    [super viewDidLoad];
    
	// Do any additional setup after loading the view, typically from a nib.
    NSLog(@"Init method");
	computerPlayer = NO;
	
	p1 = [[Player alloc] initWithName:@"Player 1"
								piece:@"X"];
	p2 = [[Player alloc] initWithName:@"Player 2"
								piece:@"O"];
    //NSString *pewPewPath = [[NSBundle mainBundle] pathForResource:@"pew-pew-lei" ofType:@"caf"];
	//NSURL *pewPewURL = [NSURL fileURLWithPath:pewPewPath];
	//AudioServicesCreateSystemSoundID((CFURLRef)pewPewURL, &_pewPewSound);
    
    mute=YES;//mutes app on setup
    [self gameResetOptions];//resets board
    NSString *path=[[NSBundle mainBundle]pathForResource:@"background" ofType:@"mp3"];//init the background sounds location
    background= [[AVAudioPlayer alloc]initWithContentsOfURL:[NSURL fileURLWithPath:path]error:NULL];//assigns the avplayer the sound
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@synthesize window;

/*
 This method will run when the application starts up without problems
 */
- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
	[self gameResetOptions];
} // applicationDidFinishLaunching

/*
 This method will run when the program ends
 */
- (void) dealloc
{
	[p1 release];
	[p2 release];
	[board release];
	[super dealloc];
} // dealloc

/*
 Enables playAGame and computerPlayer checkbox. Disables the gameBoard
 */
- (void) gameResetOptions
{
	NSLog(@"Allowing user to reset game ... enabling options again.");
	//disables every button
    [gameBoardButton1 setEnabled:NO];
	[gameBoardButton2 setEnabled:NO];
	[gameBoardButton3 setEnabled:NO];
	[gameBoardButton4 setEnabled:NO];
	[gameBoardButton5 setEnabled:NO];
	[gameBoardButton6 setEnabled:NO];
	[gameBoardButton7 setEnabled:NO];
	[gameBoardButton8 setEnabled:NO];
	[gameBoardButton9 setEnabled:NO];
    
    [playAGame setEnabled:YES];//play button enabled
	[computerPlayerToggle setEnabled:YES];//computer toggle enabled
	
	NSString *s = [NSString stringWithFormat:@"Would you like to play a game?"];
    [playerMessage setText:s];//sets textfield to s
	[self displayMessage:s];
} // gameResetOptions

/*
 Sets up a new game, based on options (Computer PLayer or Human Player)
 */
- (IBAction) setUpGame:(id)sender
{
    
	move = 0;
	//return self;
    
	NSLog(@"Setting up new game");
	move = 0;
	currentPlayer = p1;
	winner = NO;
	
	board = [[Board alloc] init];
	computerPlayer = computerPlayerToggle.on;//sets toggle to on by default
	
	if(computerPlayer == YES){
		[p2 release];
		p2 = [[ComputerPlayer alloc] init];
	}
	else{
		[p2 release];
		p2 = [[Player alloc] initWithName:@"Player 2"
									piece:@"O"];
	}
	
	[playerMessageWinner setHidden:YES];
    //renables buttons
    [gameBoardButton1 setEnabled:YES];
	[gameBoardButton2 setEnabled:YES];
	[gameBoardButton3 setEnabled:YES];
	[gameBoardButton4 setEnabled:YES];
	[gameBoardButton5 setEnabled:YES];
	[gameBoardButton6 setEnabled:YES];
	[gameBoardButton7 setEnabled:YES];
	[gameBoardButton8 setEnabled:YES];
	[gameBoardButton9 setEnabled:YES];
    
	NSString *s = [NSString stringWithFormat:@"Make your move %@ ...", [currentPlayer name]];
	
	[self displayMessage:s];
    [playerMessage setText:s];//set textfield to s
	[self drawBoard:self];
	[playAGame setEnabled:NO];//disables play button
	[computerPlayerToggle setEnabled:NO];//disables toggle for computer
} // setUpGame

/*
 * Mutes all sounds depending on mute variable
 * also play/stops background sound
 */
-(IBAction)muteSounds:(id)sender
{
    
    if(muteSwitch.on)//sound toggle active
    {
        [background play];//plays
        background.numberOfLoops=-1;//infinite
        NSLog(@"Sound");
        mute=NO;//mutes all sound
    }
    else{//soung toggle disabled
        [background stop];//stops background
        NSLog(@"mute");
        mute=YES;//mutes all sound
    }
}
/*
 Displays the appropriate message for a winning game
 */
- (void) displayWinner
{
	NSString *s;
    [gameBoardButton1 setEnabled:NO];
	[gameBoardButton2 setEnabled:NO];
	[gameBoardButton3 setEnabled:NO];
	[gameBoardButton4 setEnabled:NO];
	[gameBoardButton5 setEnabled:NO];
	[gameBoardButton6 setEnabled:NO];
	[gameBoardButton7 setEnabled:NO];
	[gameBoardButton8 setEnabled:NO];
	[gameBoardButton9 setEnabled:NO];
	
	if((computerPlayer) && (currentPlayer == p2))//player 1 loses
    {
		s = [NSString stringWithFormat:@"The Computer beat you"];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"YOU LOST!!!!!" message:NSLocalizedString(@"COMPUTER_WON", @"Message") delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];//COMPUTER_WON is a localised string
        [self tweetResult:s];//calls tweet result which posts to twitter
        [alert show];//shows pop
    }
    
       	else//player 1 wins
    {
		s = [NSString stringWithFormat:@"Congratulations! %@ is the winner!", [currentPlayer name]];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"YOU WON" message:s delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [self tweetResult:s];//tweets result
        [alert show];
    }
    
	[playerMessageWinner setHidden:NO];//shows
	[playerMessageWinner setText:s];//display
    
    [self gameResetOptions];//disables all buttons besides playgame and toggles
} //displayWinner

/*
 Displays appropriate messages for a draw game
 */
- (void) displayDraw
{
    [gameBoardButton1 setEnabled:NO];
	[gameBoardButton2 setEnabled:NO];
	[gameBoardButton3 setEnabled:NO];
	[gameBoardButton4 setEnabled:NO];
	[gameBoardButton5 setEnabled:NO];
	[gameBoardButton6 setEnabled:NO];
	[gameBoardButton7 setEnabled:NO];
	[gameBoardButton8 setEnabled:NO];
	[gameBoardButton9 setEnabled:NO];
	
	NSString *s = [NSString stringWithFormat:@"How boring! It is a draw"];
    s = [NSString stringWithFormat:@"YOU HAVE DRAWN with an randon number generator"];
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:s message:s delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    
    [alert show];
    [self tweetResult:s];
	[playerMessageWinner setText:s];
	[playerMessageWinner setHidden:NO];
} // displayDraw


/*
 Processes the next move. In a two human player game, this checks for a winner and (assuming there's no winner)
 alternates the currentPlayer to the next player. If playing against the computer, it gets the computer's move.
 */
- (void) nextMove
{
	if(move < 9 && !winner){
		if([board winner]){
			winner = YES;
		}
		
		else{
			[self drawBoard:self];
			
			if(currentPlayer == p1)
				currentPlayer = p2;
			else
				currentPlayer = p1;
			
			NSString *s = [NSString stringWithFormat:@"Make your move %@ ...", [currentPlayer name]];
			[self displayMessage:s];
			move++;
		}
	}
	
	// Get Computer Move
	if((computerPlayer) && (currentPlayer == p2) && (move < 9)){
		NSString *s = [NSString stringWithFormat:@"%@ is thinking ...", [currentPlayer name]];
		[self displayMessage:s];
		
		[self playComputerMove];
		
		if([board winner]){
			winner = YES;
		}
		else{
			currentPlayer = p1;
			
			s = [NSString stringWithFormat:@"Make your move %@ ...", [currentPlayer name]];
			[self displayMessage:s];
		}
        
		move++;
	}
	
	if(winner){
		[self displayWinner];
		[self gameResetOptions];
	}
	else if(move == 9 && !winner){
		[self displayDraw];
		[self gameResetOptions];
	}
} // nextMove

/*
 This method does its work with the various IB components (progressIndicator) and gets the computer's move
 //DIDNT CHANGE
 */
- (void) playComputerMove
{
	NSLog(@"Processing computer move ....");
	
	[computerThinking setHidden:NO];
	[computerThinking startAnimation:self];
	
	int position = [currentPlayer getComputerMove: board];
    
	NSLog(@"%@ is placing %@ in position %d.", [currentPlayer name], [currentPlayer piece], position);
	
    [board updateBoard:[currentPlayer piece] place: position];
	
	[self drawBoard:self];
	
	[computerThinking stopAnimation:self];
	[computerThinking setHidden:YES];
	
} // playComputerMove

/*
 This method is the target action for when a piece is played on the board
 (i.e. this method is called whenever a button is pressed on the game board)
 */
- (IBAction) piecePlayed:(id)sender
{
	NSLog(@"Piece played ....");
	
    UIButton *b = (UIButton *) sender;//gets sender
    
    int position = [b tag];//gets position (row,col) of b
    NSLog(@"this is %d",position);
    
	[board updateBoard:[currentPlayer piece] place: position];
    
	[b setTitle: [board objectInBoardAtPosition:position]forState:UIControlStateNormal];//x or o
	[b setEnabled: NO];//disables
    [self Sound];//activates sound
	
	[self drawBoard:self];
	[self nextMove];
    
} // piecePlayed

/*
 This is a safe method for printing to the playerMessage text field
 */
- (void) displayMessage:(NSString*)message
{
	if(message != nil){
		//[playerMessage setStringValue:message];
		//[playerMessage display];
	}
    
} //displayMessage

/*
 This method draws the board on the interface
 */
- (IBAction) drawBoard: (id)sender
{
	NSLog(@"Drawing the board ....");
    //button 1=tag 1
    //diables buttons is pressed
	
    [gameBoardButton1 setTitle:[board objectInBoardAtPosition:1]forState:UIControlStateNormal];
    if(([[gameBoardButton1 currentTitle ]isEqualToString:@"X"]) || ([[gameBoardButton1 currentTitle] isEqualToString:@"O"])){
        [gameBoardButton1 setEnabled:NO];
    }
    
    [gameBoardButton2 setTitle:[board objectInBoardAtPosition:2]forState:UIControlStateNormal];
    if(([[gameBoardButton2 currentTitle ]isEqualToString:@"X"]) || ([[gameBoardButton2 currentTitle] isEqualToString:@"O"])){
        [gameBoardButton2 setEnabled:NO];
    }
    
    [gameBoardButton3 setTitle:[board objectInBoardAtPosition:3]forState:UIControlStateNormal];
    if(([[gameBoardButton3 currentTitle ]isEqualToString:@"X"]) || ([[gameBoardButton3 currentTitle] isEqualToString:@"O"])){
        [gameBoardButton3 setEnabled:NO];
    }
    
    [gameBoardButton4 setTitle:[board objectInBoardAtPosition:4]forState:UIControlStateNormal];
    if(([[gameBoardButton4 currentTitle ]isEqualToString:@"X"]) || ([[gameBoardButton4 currentTitle] isEqualToString:@"O"])){
        [gameBoardButton4 setEnabled:NO];
    }
    
    [gameBoardButton5 setTitle:[board objectInBoardAtPosition:5]forState:UIControlStateNormal];
    if(([[gameBoardButton5 currentTitle ]isEqualToString:@"X"]) || ([[gameBoardButton5 currentTitle] isEqualToString:@"O"])){
        [gameBoardButton5 setEnabled:NO];
    }
    
    [gameBoardButton6 setTitle:[board objectInBoardAtPosition:6]forState:UIControlStateNormal];
    if(([[gameBoardButton6 currentTitle ]isEqualToString:@"X"]) || ([[gameBoardButton6 currentTitle] isEqualToString:@"O"])){
        [gameBoardButton6 setEnabled:NO];
    }
    
    [gameBoardButton7 setTitle:[board objectInBoardAtPosition:7]forState:UIControlStateNormal];
    if(([[gameBoardButton7 currentTitle ]isEqualToString:@"X"]) || ([[gameBoardButton7 currentTitle] isEqualToString:@"O"])){
        [gameBoardButton7 setEnabled:NO];
    }
    
    [gameBoardButton8 setTitle:[board objectInBoardAtPosition:8]forState:UIControlStateNormal];
    if(([[gameBoardButton8 currentTitle ]isEqualToString:@"X"]) || ([[gameBoardButton8 currentTitle] isEqualToString:@"O"])){
        [gameBoardButton8 setEnabled:NO];
    }
    
    [gameBoardButton9 setTitle:[board objectInBoardAtPosition:9]forState:UIControlStateNormal];
    if(([[gameBoardButton9 currentTitle ]isEqualToString:@"X"]) || ([[gameBoardButton9 currentTitle] isEqualToString:@"O"])){
        [gameBoardButton9 setEnabled:NO];
    }
    
} // drawBoard

/*
 * Plays sound depending on which player presses the button
 */
-(void)Sound
{
    if (!mute) {//while sound is active
        if (currentPlayer == p1) {//player 1
            NSString *path=[[NSBundle mainBundle]pathForResource:@"x" ofType:@"wav"];//init
            AVAudioPlayer * theAudio= [[AVAudioPlayer alloc]initWithContentsOfURL:[NSURL fileURLWithPath:path]error:NULL];//asssign
            [theAudio play];//play
        }
        else{//player 2/computer
            NSString *path=[[NSBundle mainBundle]pathForResource:@"o" ofType:@"aiff"];//init
            AVAudioPlayer * theAudio= [[AVAudioPlayer alloc]initWithContentsOfURL:[NSURL fileURLWithPath:path]error:NULL];//assign
            [theAudio play];//plays
        }
    }
}

/*
 * Using the twitter and social framework the app asks you if you would like to tweet
 * Does not work on sim
 * Used tutorial raywenderlich.com
 */
-(void)tweetResult:(NSString *)string
{
    if ([SLComposeViewController isAvailableForServiceType:SLServiceTypeTwitter])//account && internet
    {
        SLComposeViewController *tweetSheet = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeTwitter];//display post to be posted
        [tweetSheet setInitialText:string];
        [self presentViewController:tweetSheet animated:YES completion:nil];
    }
    else//no account||internet
    {
        UIAlertView *alertView = [[UIAlertView alloc]
                                  initWithTitle:@"Sorry"
                                  message:NSLocalizedString(@"NO_TWITTER", @"Message")//NO_TWITTER is a localised string
                                  delegate:self
                                  cancelButtonTitle:@"OK"
                                  otherButtonTitles:nil];
        [alertView show];
    }
    
}


@end
