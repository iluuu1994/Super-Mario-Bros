//
//  STLevelLayer.h
//  Game
//
//  Created by Ilija Tovilo on 3/12/13.
//  Copyright (c) 2013 Ilija Tovilo. All rights reserved.
//

#import "STTiledMapLayer.h"
#import "STControlsLayer.h"
#import "STPauseLayer.h"
#import "STPlayer.h"
#import "STGameFlowManager.h"

@interface STLevelLayer : STTiledMapLayer <STControlsDelegate, STPauseDelegate, STPlayerDelegate>
{}

#pragma mark -
#pragma mark Properties
@property (readonly) unsigned short worldID;
@property (readonly) unsigned short levelID;
@property (strong, readonly) NSDictionary *levelInfo;
@property (strong) STLayer *uiLayer;
@property (strong) STPlayer *player;

#pragma mark -
#pragma mark Initialise
/**
 * Init a level layer initialized with the given level (identified by worldID + levelID)
 * @param worldID - the id of the world whose level was started
 * @param levelID - the id of the level started
 * @return The initialised object
 */
- (id)initWithWorldID:(unsigned short)worldID levelID:(unsigned short)levelID;

/**
 * Returns a level layer initialized with the given level (identified by worldID + levelID)
 * @param worldID - the id of the world whose level was started
 * @param levelID - the id of the level started
 * @return The initialised object
 */
+ (id)layerWithWorldID:(unsigned short)worldID levelID:(unsigned short)levelID;

/**
 * Returns a scene with a level layer (as a child) initialized with the given level (identified by worldID + levelID)
 * @param worldID - the id of the world whose level was started
 * @param levelID - the id of the level started
 * @return The initialised object
 */
// TODO: remove?
+(id)sceneWithWorldID:(unsigned short)worldID levelID:(unsigned short)levelID;

@end
