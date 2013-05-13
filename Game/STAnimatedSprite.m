//
//  SKAnimationSprite.m
//  Game
//
//  Created by Ilija Tovilo on 2/2/13.
//  Copyright (c) 2013 by Lukas Seglias & Ilija Tovilo. All rights reserved.
//

#import "STAnimatedSprite.h"

@implementation STAnimatedSprite
{}

#pragma mark -
#pragma mark Initialise

-(id)initWithPlistFile:(NSString *)plistFile {
    if (self = [super init]) {
        self.animationDictionary = [NSDictionary dictionaryWithContentsOfFile:[NSBundle pathForResource:plistFile]];
        [self initAnimations];
    }
    return self;
}

- (void)initAnimations {
    NSArray *plistAnimations = [self.animationDictionary objectForKey:kAnimationPlistAnimationsKey];
    self.animations = [NSMutableDictionary dictionary];

    for (id animationKey in plistAnimations) {
        NSDictionary *animationValue = [plistAnimations valueForKey:animationKey];
        float delay = [[animationValue objectForKey:kAnimationPlistDelayKey] floatValue];
        
        NSArray *plistAnimationFrames = [animationValue objectForKey:kAnimationPlistAnimationFramesKey];
        
        NSMutableArray *animationFrames = [NSMutableArray array];
        for (NSString *animationFrameName in plistAnimationFrames) {
            id animationFrame = [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:animationFrameName];
            [animationFrames addObject:animationFrame];
        }
        
        self.animations[animationKey] = [CCAnimation animationWithSpriteFrames:animationFrames delay:delay];
    }
}

+(id)spriteWithPlistFile:(NSString *)plistFile {
    return [[self alloc] initWithPlistFile:plistFile];
}

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

#pragma mark -
#pragma mark Properties

- (BOOL)needsUpdate {
    return NO;
}

#pragma mark -
#pragma mark Methods

- (void) displayFrameWithName:(NSString *)spriteFrameName {
    [self setDisplayFrame:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:spriteFrameName]];
}

/**
 * Empty placeholder
 */
- (void)update:(ccTime)delta {

}

- (void)runAnimationWithName:(NSString *)animName endless:(BOOL)endlessFlag {
    [self stopAllActions];
    
    CCAnimation *animationFromCache = self.animations[animName];
    if (animationFromCache) {
        CCAnimate *animate = [CCAnimate actionWithAnimation:animationFromCache];
        if (animate) {
            if (endlessFlag) {
                animate = [CCRepeatForever actionWithAction:animate];
            }
            
            [self runAction:animate];
        }
    }
}

- (void)runAnimationWithName:(NSString *)animName callbackBlock:(void(^)())block {
    CCAction *callback = [CCCallBlock actionWithBlock:block];
    [self runAction:[CCSequence actionWithArray:@[ [CCAnimate actionWithAnimation:self.animations[animName]], callback ]]];
}

@end
