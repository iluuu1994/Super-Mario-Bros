//
//  SKAnimationConfiguration.m
//  Game
//
//  Created by Ilija Tovilo on 2/3/13.
//  Copyright (c) 2013 Ilija Tovilo. All rights reserved.
//

#import "SKAnimationConfiguration.h"

@implementation SKAnimationConfiguration

- (id)initWithName:(NSString *)name
  frameNamePattern:(NSString *)frameNamePattern
             delay:(NSTimeInterval)delay {
    
    if (self = [super init]) {
        self.name = name;
        self.frameNamePattern = frameNamePattern;
        self.delay = delay;
    }
    
    return self;
}

+ (id)configurationWithName:(NSString *)name
  frameNamePattern:(NSString *)frameNamePattern
             delay:(NSTimeInterval)delay; {


    return [[self alloc] initWithName:name
                              frameNamePattern:frameNamePattern
                                delay:delay];
}

- (CCAnimation *)animation {
    NSMutableArray *animationFrames = [NSMutableArray array];
    
    BOOL continueLoop = YES;
    
    int i = 1;
    while (continueLoop) {
        id object = [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:[NSString stringWithFormat:self.frameNamePattern, i]];
        
        if (!object) {
            continueLoop = NO;
        } else {
            [animationFrames addObject:object];
        }
        
        i++;
    }
    
    return [CCAnimation animationWithSpriteFrames:animationFrames delay:self.delay];
}

@end
