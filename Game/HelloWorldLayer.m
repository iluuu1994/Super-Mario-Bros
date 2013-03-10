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

#import "STTiledMapLayer.h"

#pragma mark - HelloWorldLayer


@implementation HelloWorldLayer


- (void)setUp {
    [super setUp];
        
    [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"Candle.plist"];
    [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"Frei.plist"];

    
    STTiledMapLayer *map = [STTiledMapLayer layerWithTiledMap:@"Level1.tmx"];
    [self addChild:map];
}

- (void)tearDown {
    [super tearDown];
    
    [[CCSpriteFrameCache sharedSpriteFrameCache] removeSpriteFramesFromFile:@"Candle.plist"];
    [[CCSpriteFrameCache sharedSpriteFrameCache] removeSpriteFramesFromFile:@"Frei.plist"];
}

- (void)sceneWasAdded:(STScene *)scene {
}

- (void)sceneWasRemoved:(STScene *)scene {
}

@end
