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
            animationConfigurations:(NSArray *)animationConfigurations {
        
    if (self = [super initWithSpriteFrameName:defaultSpriteFrameName]) {
        self.animations = [NSMutableDictionary dictionary];
        
        for (SKAnimationConfiguration *config in animationConfigurations) {
            self.animations[config.name] = [config animation];
        }
    }
    return self;
}

+(id)spriteWithDefaultSpriteFrameName:(NSString *)defaultSpriteFrameName
              animationConfigurations:(NSArray *)animationConfigurations {
    
    return [[self alloc] initWithDefaultSpriteFrameName:defaultSpriteFrameName
                                animationConfigurations:animationConfigurations];
}

@end
