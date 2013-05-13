//
//  STCreature.m
//  Game
//
//  Created by Ilija Tovilo on 5/2/13.
//  Copyright (c) 2013 Ilija Tovilo. All rights reserved.
//

#import "STCreature.h"

@implementation STCreature
{}

#pragma mark Properties

// The default body type of a creature id dynamic
- (STGameObjectBodyType)bodyType {
    return STGameObjectBodyTypeDynamic;
}

// We flip the creature horizontally, if it has a velocity that is smaller than 0
- (void)setVelocity:(CGPoint)velocity {
    if (velocity.x > 0) {
        self.flipX = NO;
    } else if (velocity.x < 0) {
        self.flipX = YES;
    }
    
    [super setVelocity:velocity];
}

@end
