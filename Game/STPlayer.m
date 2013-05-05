//
//  STPlayer.m
//  Game
//
//  Created by Ilija Tovilo on 5/2/13.
//  Copyright (c) 2013 Ilija Tovilo. All rights reserved.
//

#import "STPlayer.h"

#define kJumpVelocity 250

@interface STPlayer ()
@property BOOL isAnimating;
@end

@implementation STPlayer
{}

#pragma mark -
#pragma mark Properties
- (NSMutableArray *)bonusItems {
    if (!_bonusItems) {
        _bonusItems = [NSMutableArray array];
    }
    
    return _bonusItems;
}

- (void)collisionWithGameObject:(STGameObject *)gameObject {
    
}

- (void)jump {
    if(self.velocity.y == 0) {
        self.velocity = ccp(0, kJumpVelocity);
    }
}

- (void)move:(CGPoint)deltaPoint {
    if ([self.delegate player:self shouldMoveToPoint:ccpAdd(self.position, self.velocity)]) {
        [super move:deltaPoint];
        [self.delegate player:self didMoveToPoint:self.position];
    }
}

- (void)setVelocity:(CGPoint)velocity {
    if (self.isAnimating != (velocity.x > 0 || velocity.x < 0)) {
        if (velocity.x != 0) {
            self.isAnimating = YES;
            [self runAnimationWithName:@"walk" endless:YES];
        } else {
            self.isAnimating = NO;
            [self runAnimationWithName:@"stand" endless:NO];
        }
    }
    
    if (velocity.x != 0) {
        if (
            (velocity.x > 0 && self.scaleX < 0)
            ||
            (velocity.x < 0 && self.scaleX > 0)
        ) {
            self.scaleX *= -1;
        }
    }
    
    [super setVelocity:velocity];
}

@end
