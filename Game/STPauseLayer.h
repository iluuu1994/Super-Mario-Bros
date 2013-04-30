//
//  STPauseLayer.h
//  Game
//
//  Created by Lukas Seglias on 30.04.13.
//  Copyright (c) 2013 Ilija Tovilo. All rights reserved.
//

#import "STLayer.h"

@interface STPauseLayer : STLayer

#pragma mark -
#pragma mark Properties
@property unsigned short worldID;
@property unsigned short levelID;

#pragma mark -
#pragma mark Initialise
/**
 * Init a pause layer with given  world id and level id.
 * @param worldID - the id of the world containing the played level
 * @param levelID - the id of the played level inside the specified world
 * @return id - The initialised object
 */
-(id)initWithWorldID:(unsigned short)worldID
             levelID:(unsigned short)levelID;

/**
 * Returns a pause layer with given  world id and level id.
 * @param worldID - the id of the world containing the played level
 * @param levelID - the id of the played level inside the specified world
 * @return id - The initialised object
 */
+(id)layerWithWorldID:(unsigned short)worldID
              levelID:(unsigned short)levelID;

/**
 * Is called when the layer is initialised
 */
- (void)setUpWithWorldID:(unsigned short)worldID
                 levelID:(unsigned short)levelID;

@end
