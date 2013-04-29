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
#import "CCScrollLayer.h"
#import "STStartLayer.h"
#import "STLevelLayer.h"

#define kDictionaryWorldKey @"world"
#define kDictionaryLevelKey @"level"

@interface STChooseLevelLayer : STLayer {
    
}
#pragma mark -
#pragma mark Initialise

/**
 * Init a level selection layer with the levels of the given worlds id
 * @param worldID - the id of the world whose levels will be displayed
 * @return The initialised object
 */
-(id)initWithWorldID:(unsigned short)worldID;

/**
 * Returns a level selection layer with the levels of the given worlds id
 * @param worldID - the id of the world whose levels will be displayed
 * @return The initialised object
 */
+(id)layerWithWorldID:(unsigned short)worldID;

/**
 * Returns a scene with a level selection layer (as a child) with the levels of the given worlds id
 * @param worldID - the id of the world whose levels will be displayed
 * @return id - The initialised object
 */
+(id)sceneWithWorldID:(unsigned short)worldID;

/**
 * Is called when the layer is initialised
 */
- (void)setUpWithWorldID:(unsigned short)worldID;

@end
