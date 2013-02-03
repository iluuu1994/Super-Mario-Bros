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

#pragma mark - HelloWorldLayer


@implementation HelloWorldLayer

-(id) init
{
	if(self = [super init]) {
        CGSize winSize = [CCDirector sharedDirector].winSize;
        
        CCLayerColor* colorLayer = [CCLayerColor layerWithColor:ccc4(255, 255, 255, 255)];
        [self addChild:colorLayer z:0];
        
        Candle *candle = [Candle node];
        [candle setPosition:ccp(winSize.width / 3 * 2, winSize.height / 2)];
        [self addChild:candle];

        
        Frei *man = [Frei node];
        [man setPosition:ccp(winSize.width / 3, winSize.height / 2)];
        [self addChild:man];

	}
	return self;
}

- (void)setUp {
    [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"Candle.plist"];
    [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"Frei.plist"];
}

- (void)tearDown {
    [[CCSpriteFrameCache sharedSpriteFrameCache] removeSpriteFramesFromFile:@"Candle.plist"];
    [[CCSpriteFrameCache sharedSpriteFrameCache] removeSpriteFramesFromFile:@"Frei.plist"];
}

- (void)sceneWasAdded:(SKScene *)scene {
}

- (void)sceneWasRemoved:(SKScene *)scene {
}

@end
