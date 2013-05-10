//
//  STInformationLayer.h
//  Game
//
//  Created by Lukas Seglias on 10.05.13.
//  Copyright (c) 2013 Ilija Tovilo. All rights reserved.
//

#import "STLayer.h"
#import "STPlayer.h"
#import "STLayoutConstants.h"

@protocol STInformationDelegate <NSObject>

#pragma mark -
#pragma mark Time is over
- (IBAction)timeElapsed:(id)sender;

@end

@interface STInformationLayer : STLayer
{}

#pragma mark -
#pragma mark Properties
@property (strong, readonly) STPlayer *player;
@property unsigned short time;
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
 * Is called when the layer is initialised
 */
- (void)setUpWithDelegate:(id <STInformationDelegate>)delegate
                   player:(STPlayer *)player
                     time:(unsigned short)time;

/**
 * Force the layer to reload and redisplay the displayed information. 
 */
- (void)updateInformation;

@end
