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
#import "STNPC.h"

#define kJumpVelocity 300
#define kInvinibilityDuration 1
#define kBlinkingSpeed 0.1

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
    // Kill all NPCs when in "instant kill"-mode
    if (self.killsInstantly && [[gameObject class] isSubclassOfClass:[STNPC class]]) {
        [gameObject setDead:YES];
    }
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
    
    if (!self.isInvincible) {
        
        if (isDead && self.playerState != STPlayerStateSmall) {
            [self setPlayerState:STPlayerStateSmall];
            [self setInvincible:YES forTime:kInvinibilityDuration];
            [super setDead:NO];
        } else {
            [super setDead:isDead];
            [self.delegate playerDied:self];
        }
    }
}

- (void)setInvincible:(BOOL)isInvincible forTime:(ccTime)time {
    // Start being invincible
    [self setInvincible:YES];
    [self schedule:@selector(invincibilityCallback) interval:time];
    
    // TODO: Start playing invincibility-effect
    
    // Start blinking
    [self schedule:@selector(blink) interval:kBlinkingSpeed];
}

- (void)invincibilityCallback {
    // Stop being invincible
    [self setInvincible:!self.isInvincible];
    [self unschedule:@selector(invincibilityCallback)];
    
    // TODO: Stop playing invincibility-effect
    
    // Stop blinking
    [self unschedule:@selector(blink)];
    [self setVisible:YES];
}

- (void)setKillsInstantly:(BOOL)killsInstantly forTime:(ccTime)time {
    // Start "instant kill"-mode
    [self setKillsInstantly:YES];
    [self schedule:@selector(instantKillCallback) interval:time];
}

- (void)instantKillCallback {
    // Stop "instant kill"-mode
    [self setKillsInstantly:!self.killsInstantly];
    [self unschedule:@selector(instantKillCallback)];
}

-(void)blink {
    [self setVisible:!self.visible];
}

@end
