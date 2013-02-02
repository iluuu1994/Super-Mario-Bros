//
//  SKAnimationSprite.m
//  Game
//
//  Created by Ilija Tovilo on 2/2/13.
//  Copyright (c) 2013 Ilija Tovilo. All rights reserved.
//

#import "SKAnimationSprite.h"

@implementation SKAnimationSprite

-(id)initWithDefaultSpriteFrameName:(NSString *)defaultSpriteFrameName
                          plistFile:(NSString *)plistFile
        spriteFrameNamingConvention:(NSString *)spriteFrameNamingConvention {
    
    [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:plistFile];
    
    if (self = [super initWithSpriteFrameName:defaultSpriteFrameName]) {
        
        NSMutableArray *animationFrames = [NSMutableArray array];
        
        BOOL continueLoop = YES;
        
        int i = 1;
        while (continueLoop) {
            id object = [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:[NSString stringWithFormat:spriteFrameNamingConvention, i]];
            
            if (!object) {
                continueLoop = NO;
            } else {
                [animationFrames addObject:object];
            }
            
            i++;
        }
        
        CCAnimation *animation = [CCAnimation animationWithSpriteFrames:animationFrames delay:0.1f];
        CCAction *candleAction = [CCRepeatForever actionWithAction:[CCAnimate actionWithAnimation:animation]];
        [self runAction:candleAction];
        
    }
    return self;
}

+ (id)spriteWithDefaultSpriteFrameName:(NSString *)defaultSpriteFrameName
                             plistFile:(NSString *)plistFile
           spriteFrameNamingConvention:(NSString *)spriteFrameNamingConvention {
    
    return [[self alloc] initWithDefaultSpriteFrameName:defaultSpriteFrameName
                                       plistFile:plistFile
                     spriteFrameNamingConvention:spriteFrameNamingConvention];
}

@end
