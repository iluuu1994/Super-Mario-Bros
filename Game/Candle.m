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
    
    [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"Candle.plist"];
    
    if (self = [super initWithSpriteFrameName:@"Candle_1.png"]) {
        
        NSMutableArray *animationFrames = [NSMutableArray array];
        
        for(int i = 1; i <= 4; ++i) {
            [animationFrames addObject:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:[NSString stringWithFormat:@"Candle_%d.png", i]]];
        }
        
        CCAnimation *animation = [CCAnimation animationWithSpriteFrames:animationFrames delay:0.1f];
        CGSize winSize = [CCDirector sharedDirector].winSize;
        
        self.position = ccp(winSize.width/2, winSize.height/2);
        CCAction *candleAction = [CCRepeatForever actionWithAction:[CCAnimate actionWithAnimation:animation]];
        [self runAction:candleAction];
        
    }
    return self;
}

@end
