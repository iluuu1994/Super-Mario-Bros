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
    /*
    CGSize winSize = [CCDirector sharedDirector].winSize;
    
    CCLayerColor* colorLayer = [CCLayerColor layerWithColor:ccc4(255, 255, 255, 255)];
    [self addChild:colorLayer z:0];
    
    Candle *candle = [Candle node];
    [candle setPosition:ccp(winSize.width / 3 * 2, winSize.height / 2)];
    [self addChild:candle];
    
    
    Frei *man = [Frei node];
    [man setPosition:ccp(winSize.width / 3, winSize.height / 2)];
    [self addChild:man];*/
    
    STTiledMapLayer *map = [STTiledMapLayer layerWithTiledMap:@"temple.tmx"];
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
