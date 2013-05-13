//
//  STLevelLayer.h
//  Game
//
//  Created by Ilija Tovilo on 3/12/13.
//  Copyright (c) 2013 by Lukas Seglias & Ilija Tovilo. All rights reserved.
//

#import "STTiledMapLayer.h"
#import "STInformationLayer.h"
#import "STControlsLayer.h"
#import "STPauseLayer.h"
#import "STPlayer.h"
#import "STItemBlock.h"
#import "STLakitu.h"


/**
 * The level is the main class of the game.
 * It's a subclass of STTiledMapLayer.
 *
 * It holds the map of the current level, as well as all of the game objects.
 * It handles the phyics, and notifies the game object about all of the collisions.
 * It's the delegate of every game object.
 */
@interface STLevelLayer : STTiledMapLayer <STControlsDelegate,
                                           STPauseDelegate,
                                           STPlayerDelegate,
                                           STInformationDelegate,
                                           STLakituDelegate>
{}




#pragma mark -
#pragma mark Properties

/**
 * The world id of the current level.
 */
@property (readonly) unsigned short worldID;

/**
 * The level id of the current level.
 */
@property (readonly) unsigned short levelID;

/**
 * The dictionary that holds the information about the current level.
 */
@property (strong, readonly) NSDictionary *levelInfo;

/**
 * The layer that is added as a child of the level layer.
 * This is either a `STControlsLAyer` or a `STPauseLayer`.
 */
@property (strong) STLayer *uiLayer;

/**
 * The information layer displays information about the level and the player:
 * - Time left
 * - Player score
 * - Collected Coins
 */
@property (strong) STInformationLayer *infoLayer;

/**
 * The player that is playing the level.
 * This is either Mario, or Luigi.
 */
@property (strong) STPlayer *player;




#pragma mark -
#pragma mark Initialise

/**
 * Init a level layer initialized with the given level (identified by worldID + levelID).
 * @param worldID - the id of the world whose level will be started.
 * @param levelID - the id of the level we want to start.
 * @return The initialised object.
 */
- (id)initWithWorldID:(unsigned short)worldID levelID:(unsigned short)levelID;

/**
 * Returns a level layer initialized with the given level (identified by worldID + levelID).
 * @param worldID - the id of the world whose level will be started.
 * @param levelID - the id of the level we want to start.
 * @return The initialised object.
 */
+ (id)layerWithWorldID:(unsigned short)worldID levelID:(unsigned short)levelID;

@end
