//
//  STPlayer.m
//  Game
//
//  Created by Ilija Tovilo on 5/2/13.
//  Copyright (c) 2013 Ilija Tovilo. All rights reserved.
//

#import "STPlayer.h"
#import "STItem.h"
#import "STSoundManager.h"
#import "STMushroom.h"

#define kJumpVelocity 250

@interface STPlayer () {
    NSString *_cachedAnimation;
}
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

- (void)collisionWithGameObject:(STGameObject *)gameObject
                           edge:(STRectEdge)edge {
    
}

- (void)jump {
    if(self.velocity.y == 0) {
        self.velocity = ccp(0, kJumpVelocity);
        [[STSoundManager sharedInstance] playEffect:@"jump.wav"];
    }
}

- (void)move:(CGPoint)deltaPoint {
    if ([self.delegate player:self shouldMoveToPoint:ccpAdd(self.position, self.velocity)]) {
        [super move:deltaPoint];
        [self.delegate player:self didMoveToPoint:self.position];
    }
}

- (void)runAnimationWithName:(NSString *)animName endless:(BOOL)endlessFlag {
    _cachedAnimation = animName;
    
    if (self.playerState == STPlayerStateSmall) {
        animName = [@"small-" stringByAppendingString:animName];
    } else if (self.playerState == STPlayerStateFire) {
        animName = [@"fire-" stringByAppendingString:animName];
    }
    
    [super runAnimationWithName:animName endless:endlessFlag];
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
    
    [super setVelocity:velocity];
}

- (void)setPlayerState:(STPlayerState)playerState {
    _playerState = playerState;
    
    [self runAnimationWithName:_cachedAnimation endless:YES];
}

- (void)setDead:(BOOL)isDead {
    
    NSLog(@"local: %s", isDead ? "true" : "false");
    NSLog(@"%u", self.playerState);
    NSLog(@"%u", STPlayerStateSmall);
    
    if (isDead && self.playerState != STPlayerStateSmall) {
        [self setPlayerState:STPlayerStateSmall];
        [super setDead:NO];
    } else {
        [super setDead:isDead];
        NSLog(@"%s", self.isDead ? "true" : "false");
    }
}

@end
