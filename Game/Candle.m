//
//  Candle.m
//  Game
//
//  Created by Lukas Seglias on 02.02.13.
//  Copyright 2013 Ilija Tovilo. All rights reserved.
//

#import "Candle.h"


@implementation Candle

-(id)init {
    
    if (self = [super init]) {
    
        [self animate];
    }
    return self;
}

-(void) animate {
    [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"Candle.plist"];
    CCSpriteBatchNode *spriteSheet = [CCSpriteBatchNode batchNodeWithFile:@"Candle.png"];
    
    NSMutableArray *animationFrames = [NSMutableArray array];
    
    for(int i = 1; i <= 4; ++i) {
        [animationFrames addObject:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:[NSString stringWithFormat:@"Candle_%d.png", i]]];
    }
    
    CCAnimation *animation = [CCAnimation animationWithSpriteFrames:animationFrames delay:0.1f];
    
    CGSize winSize = [CCDirector sharedDirector].winSize;
    CCSprite *candle = [CCSprite spriteWithSpriteFrameName:@"Candle_1.png"];
    candle.position = ccp(winSize.width/2, winSize.height/2);
    CCAction *candleAction = [CCRepeatForever actionWithAction:[CCAnimate actionWithAnimation:animation]];
    [candle runAction:candleAction];
    
    [spriteSheet addChild:candle];
    [self addChild:spriteSheet];
}

@end
