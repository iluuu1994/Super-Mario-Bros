//
//  STChooseLevelLayer.h
//  Game
//
//  Created by Lukas Seglias on 01.04.13.
//  Copyright 2013 Ilija Tovilo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "STLayer.h"

@interface STChooseLevelLayer : STLayer {
    
}
#pragma mark -
#pragma mark Initialise

/**
 * Init a level selection layer with the levels of the given worlds id
 * @param worldId - the id of the world whose levels will be displayed
 * @return id - The initialised object
 */
-(id)initWithWorldId:(unsigned int)worldId;

/**
 * Returns a level selection layer with the levels of the given worlds id
 * @param worldId - the id of the world whose levels will be displayed
 * @return id - The initialised object
 */
+(id)layerWithWorldId:(unsigned int)worldId;

/**
 * Returns a scene with a level selection layer (as a child) with the levels of the given worlds id
 * @param worldId - the id of the world whose levels will be displayed
 * @return id - The initialised object
 */
+(id)sceneWithWorldId:(unsigned int)worldId;

/**
 * Is called when the layer is initialised
 */
- (void)setUpWithWorldId:(unsigned int)worldId;

@end
