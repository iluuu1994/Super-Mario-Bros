//
//  STInformationLayer.h
//  Game
//
//  Created by Lukas Seglias on 10.05.13.
//  Copyright (c) 2013 by Lukas Seglias & Ilija Tovilo. All rights reserved.
//

#import "STLayer.h"
#import "STPlayer.h"

/**
 * Delegate which will be informed if the given time elapsed. 
 * Defines the methods used by the STInformationLayer to communicate with the delegate.
 */
@protocol STInformationDelegate <NSObject>

#pragma mark -
#pragma mark Time is over
/**
 * When the time (given in the constructor) has elapsed this method is called. 
 * @param sender - the sender of this message. The STInformationLayer.
 * @return an IBAction.
 */
- (IBAction)timeElapsed:(id)sender;

@end

/**
 * A layer which displays information of the user (score, collected coins) and 
 * the remaining time. The start time is padded through the constructor.
 * The layer will count down from this start value.
 * The layer refreshes all the displayed data every second. You can force a 
 * reload by calling "updateInformation".
 */
@interface STInformationLayer : STLayer
{}

#pragma mark -
#pragma mark Properties

/**
 * The player whose information are displayed.
 */
@property (strong, readonly) STPlayer *player;

/**
 * The current amount of seconds left. Is being decreased every second by one. 
 */
@property (readonly) unsigned short time;

/**
 * The delegate receiving a message when the time has elapsed. 
 */
@property (unsafe_unretained) id <STInformationDelegate> delegate;

#pragma mark -
#pragma mark Initialise

/**
 * Init an information layer with the information of the player. 
 * Start counting down the time from the given start time in seconds. 
 * @param delegate - the delegate receiving a message when the time is over.
 * @param player - the player whose information will be displayed (score, lifes, coins).
 * @param time - amount of seconds until this layer sends a message (time is over) to the delegate. 
 * @return The initialised object
 */
-(id)initWithDelegate:(id <STInformationDelegate>)delegate
               player:(STPlayer *)player
                 time:(unsigned short)time;

/**
 * Returns an information layer with the information of the player.
 * Start counting down the time from the given start time in seconds.
 * @param delegate - the delegate receiving a message when the time is over.
 * @param player - the player whose information will be displayed (score, lifes, coins).
 * @param time - amount of seconds until this layer sends a message (time is over) to the delegate.
 * @return The initialised object
 */
+(id)layerWithDelegate:(id <STInformationDelegate>)delegate
                player:(STPlayer *)player
                  time:(unsigned short)time;

/**
 * Is called when the layer is initialised.
 */
- (void)setUpWithDelegate:(id <STInformationDelegate>)delegate
                   player:(STPlayer *)player
                     time:(unsigned short)time;

#pragma mark -
#pragma mark Update Layer

/**
 * Force the layer to reload and redisplay the player information and time. 
 */
- (void)updateInformation;

@end
