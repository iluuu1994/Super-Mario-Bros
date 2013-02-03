//
//  SKAnimationSprite.m
//  Game
//
//  Created by Ilija Tovilo on 2/2/13.
//  Copyright (c) 2013 Ilija Tovilo. All rights reserved.
//

#import "SKAnimationSprite.h"
#import "SKAnimationConfiguration.h"

@implementation SKAnimationSprite

-(id)initWithDefaultSpriteFrameName:(NSString *)defaultSpriteFrameName
                          plistFile:(NSString *)plistFile
            animationConfigurations:(NSArray *)animationConfigurations {
    
    [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:plistFile];
    
    if (self = [super initWithSpriteFrameName:defaultSpriteFrameName]) {
        self.animations = [NSMutableDictionary dictionary];
        
        for (SKAnimationConfiguration *config in animationConfigurations) {
            NSMutableArray *animationFrames = [NSMutableArray array];
            
            BOOL continueLoop = YES;
            
            int i = 1;
            while (continueLoop) {
                id object = [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:[NSString stringWithFormat:config.frameNamePattern, i]];
                
                if (!object) {
                    continueLoop = NO;
                } else {
                    [animationFrames addObject:object];
                }
                
                i++;
            }
            
            CCAnimation *animation = [CCAnimation animationWithSpriteFrames:animationFrames delay:0.1f];
            self.animations[config.name] = animation;
        }
    }
    return self;
}

+(id)spriteWithDefaultSpriteFrameName:(NSString *)defaultSpriteFrameName
                            plistFile:(NSString *)plistFile
              animationConfigurations:(NSArray *)animationConfigurations {
    
    return [[self alloc] initWithDefaultSpriteFrameName:defaultSpriteFrameName
                                              plistFile:plistFile
                                animationConfigurations:animationConfigurations];
}

@end
