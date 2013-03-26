//
//  HelloWorldLayer.m
//  Game
//
//  Created by Ilija Tovilo on 1/26/13.
//  Copyright Ilija Tovilo 2013. All rights reserved.
//


#import "HelloWorldLayer.h"
#import "AppDelegate.h"
#import "Candle.h"
#import "Frei.h"

#import "STLevelLayer.h"

#pragma mark - HelloWorldLayer


@implementation HelloWorldLayer
{}

#pragma mark -
#pragma mark Initialise
- (void)setUp {
    [super setUp];
    
    //[[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"Candle.plist"];
    [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"Frei.plist"];
    
    STLevelLayer *map = [STLevelLayer layerWithWorldID:1 levelID:1];
    [self addChild:map];
}

#pragma mark -
#pragma mark Dealloc
- (void)tearDown {
    [super tearDown];
    
    //[[CCSpriteFrameCache sharedSpriteFrameCache] removeSpriteFramesFromFile:@"Candle.plist"];
    [[CCSpriteFrameCache sharedSpriteFrameCache] removeSpriteFramesFromFile:@"Frei.plist"];
}

@end
