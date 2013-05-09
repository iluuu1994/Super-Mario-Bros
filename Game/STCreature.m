//
//  STCreature.m
//  Game
//
//  Created by Ilija Tovilo on 5/2/13.
//  Copyright (c) 2013 Ilija Tovilo. All rights reserved.
//

#import "STCreature.h"

@implementation STCreature

- (STGameObjectBodyType)bodyType {
    return STGameObjectBodyTypeDynamic;
}

- (void)setVelocity:(CGPoint)velocity {
    if (velocity.x > 0) {
        self.flipX = NO;
    } else if (velocity.x < 0) {
        self.flipX = YES;
    }
    
    [super setVelocity:velocity];
}

@end
