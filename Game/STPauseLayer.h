//
//  STPauseLayer.h
//  Game
//
//  Created by Lukas Seglias on 30.04.13.
//  Copyright (c) 2013 Ilija Tovilo. All rights reserved.
//

#import "STLayer.h"
#import "STLevelLayer.h"
#import "STChooseLevelLayer.h"
#import "STUILayer.h"

@class STPauseLayer;
@protocol STPauseDelegate <NSObject>

#pragma mark -
#pragma mark Buttons
- (IBAction)play:(id)sender;

@end

@interface STPauseLayer : STLayer <STUILayer>
{}

#pragma mark -
#pragma mark Properties
@property unsigned short worldID;
@property unsigned short levelID;
@property (strong) id <STControlsDelegate> delegate;

#pragma mark -
#pragma mark Initialise
/**
 * Init a pause layer with given  world id and level id.
 * @param delegate the delegate which receives messages when pressing a button on this layer.
 * @param worldID - the id of the world containing the played level
 * @param levelID - the id of the played level inside the specified world
 * @return id - The initialised object
 */
-(id)initWithDelegate:(id <STPauseDelegate>)delegate
              worldID:(unsigned short)worldID
              levelID:(unsigned short)levelID;

/**
 * Returns a pause layer with given  world id and level id.
 * @param delegate the delegate which receives messages when pressing a button on this layer.
 * @param worldID - the id of the world containing the played level
 * @param levelID - the id of the played level inside the specified world
 * @return id - The initialised object
 */
+(id)layerWithDelegate:(id <STPauseDelegate>)delegate
               worldID:(unsigned short)worldID
               levelID:(unsigned short)levelID;

/**
 * Is called when the layer is initialised
 */
- (void)setUpWithDelegate:(id <STPauseDelegate>)delegate
                  worldID:(unsigned short)worldID
                  levelID:(unsigned short)levelID;

@end
