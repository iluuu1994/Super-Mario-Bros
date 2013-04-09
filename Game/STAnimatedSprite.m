//
//  SKAnimationSprite.m
//  Game
//
//  Created by Ilija Tovilo on 2/2/13.
//  Copyright (c) 2013 Ilija Tovilo. All rights reserved.
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
