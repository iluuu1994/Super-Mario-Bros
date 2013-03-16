//
//  SKAnimationSprite.m
//  Game
//
//  Created by Ilija Tovilo on 2/2/13.
//  Copyright (c) 2013 Ilija Tovilo. All rights reserved.
//

#import "STAnimationSprite.h"
#import "STAnimationConfiguration.h"

@implementation STAnimationSprite
{}

#pragma mark -
#pragma mark Initialise
-(id)initWithDefaultSpriteFrameName:(NSString *)defaultSpriteFrameName
            animationConfigurations:(NSArray *)animationConfigurations {
        
    if (self = [super initWithSpriteFrameName:defaultSpriteFrameName]) {
        // Animations
        self.animations = [NSMutableDictionary dictionary];
        for (STAnimationConfiguration *config in animationConfigurations) {
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

#pragma mark -
#pragma mark Properties
- (BOOL)needsUpdate {
    return NO;
}

#pragma mark -
#pragma mark Methods
- (void)onEnter {
    [super onEnter];
    
    // Needs Update
    if ([self needsUpdate]) {
        [self scheduleUpdate];
    }
}

- (void)onExit {
    [super onEnter];
    
    // Needs Update
    if ([self needsUpdate]) {
        [self unscheduleUpdate];
    }
}

- (void)update:(ccTime)delta {

}

@end
