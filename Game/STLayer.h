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
+ (STScene *)scene;
@property (nonatomic, strong) Class sceneClass;

#pragma mark -
#pragma mark Initialise
- (void)setUp;

#pragma mark -
#pragma mark Dealloc
- (void)tearDown;

@end
