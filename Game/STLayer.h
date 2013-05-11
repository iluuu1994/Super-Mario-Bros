//
//  SKLayer.h
//  Game
//
//  Created by Ilija Tovilo on 2/3/13.
//  Copyright 2013 Ilija Tovilo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "STScene.h"

@interface STLayer : CCLayer
{}

#pragma mark -
#pragma mark Scene

/**
 * Creates new scene with new layer.
 */
+ (STScene *)scene;

/**
 * Embedds the layer in a scene.
 */
- (STScene *)scene;

/**
 * The scene class that should be used.
 */
+ (Class)sceneClass;

#pragma mark -
#pragma mark Initialise

/**
 * Is called when the layer is initialised.
 */
- (void)setUp;

#pragma mark -
#pragma mark Update

@property (nonatomic, readonly) BOOL needsUpdate;

#pragma mark -
#pragma mark Dealloc

/**
 * Is called when the layer is deallocated
 */
- (void)tearDown;

@end
