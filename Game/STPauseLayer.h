//
//  STPauseLayer.h
//  Game
//
//  Created by Lukas Seglias on 30.04.13.
//  Copyright (c) 2013 Ilija Tovilo. All rights reserved.
//

#import "STLayer.h"

/**
 * Delegate which will be informed if a button on this layer was pressed. 
 * Defines the methods used by the STPauseLayer to communicate with the delegate. 
 */
@protocol STPauseDelegate <NSObject>

#pragma mark -
#pragma mark Buttons

/**
 * When the user wants to resume the game this message is sent to the delegate.
 * @param sender - the sender of this message. The STPauseLayer.
 * @return an IBAction.
 */
- (IBAction)play:(id)sender;

/**
 * When the user wants to retrx the current level this message is sent to the delegate.
 * @param sender - the sender of this message. The STPauseLayer.
 * @return an IBAction.
 */
- (IBAction)retryLevel:(id)sender;

@end

/**
 * A layer which is shown when the game is paused. Displays the number of the 
 * current world and level. Provides buttons to retry the current level, 
 * go to the level selection screen or resume the game. 
 */
@interface STPauseLayer : STLayer
{}

#pragma mark -
#pragma mark Properties

/**
 * The ID of the current world.
 */
@property unsigned short worldID;

/**
 * The ID of the current level.
 */
@property unsigned short levelID;

/**
 * The delegate which receives messages when pressing a button on this layer.
 */
@property (unsafe_unretained) id <STPauseDelegate> delegate;

#pragma mark -
#pragma mark Initialise

/**
 * Init a pause layer with given  world id and level id.
 * @param delegate the delegate which receives messages when pressing a button on this layer.
 * @param worldID - the id of the world containing the played level
 * @param levelID - the id of the played level inside the specified world
 * @return id - The initialised object.
 */
-(id)initWithDelegate:(id <STPauseDelegate>)delegate
              worldID:(unsigned short)worldID
              levelID:(unsigned short)levelID;

/**
 * Returns a pause layer with given  world id and level id.
 * @param delegate the delegate which receives messages when pressing a button on this layer.
 * @param worldID - the id of the world containing the played level
 * @param levelID - the id of the played level inside the specified world
 * @return id - The initialised object.
 */
+(id)layerWithDelegate:(id <STPauseDelegate>)delegate
               worldID:(unsigned short)worldID
               levelID:(unsigned short)levelID;

/**
 * Is called when the layer is initialised.
 */
- (void)setUpWithDelegate:(id <STPauseDelegate>)delegate
                  worldID:(unsigned short)worldID
                  levelID:(unsigned short)levelID;

@end
