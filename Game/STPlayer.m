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
#import "STFireBall.h"
#import "STBlock.h"

#define kJumpVelocity 300
#define kInvinibilityDuration 1
#define kBlinkingSpeed 0.1


#pragma mark -
#pragma mark Private Interface

@interface STPlayer () {
    NSString *_cachedAnimation;
    BOOL _stopBackgroundMusic;
}
@property BOOL isAnimating;
@end



#pragma mark -
#pragma mark Implementation

@implementation STPlayer
{}

#pragma mark -
#pragma mark Methods

- (void)collisionWithGameObject:(STGameObject *)gameObject
                           edge:(STRectEdge)edge {
    // Kill all NPCs when in "instant kill"-mode
    if (self.killsInstantly && [[gameObject class] isSubclassOfClass:[STNPC class]]) {
        [gameObject die];
    }
    
    if(edge == STRectEdgeMinY && [[gameObject class] isSubclassOfClass:[STBlock class]] && self.isJumping) {
        if ([_cachedAnimation hasSuffix:@"walk"]) {
            [self runAnimationWithName:_cachedAnimation endless:YES];
        } else {
            [self runAnimationWithName:_cachedAnimation endless:NO];
        }
        self.isJumping = NO;
    }
}

- (void)jump {
    if(self.velocity.y == 0) {
        self.velocity = ccp(0, kJumpVelocity);
        [[STSoundManager sharedInstance] playEffect:@"jump.wav"];
        [self runAnimationWithName:@"jump" endless:NO];
        self.isJumping = YES;
    }
}

- (void)spitFireball {
    if (self.playerState == STPlayerStateFire) {
        STFireBall *fireball = [[STFireBall alloc] init];
        
        if (!self.flipX) {
            fireball.velocity = ccp(200, 0);
            fireball.position = ccpAdd(self.position, ccp(self.boundingBox.size.width + (fireball.boundingBox.size.width / 2), 0));
        } else {
            fireball.velocity = ccp(-200, 0);
            fireball.position = ccpAdd(self.position, ccp(-self.boundingBox.size.width - (fireball.boundingBox.size.width / 2), 0));
        }
        
        [self.delegate addGameObjectToMap:fireball toPosition:fireball.position];
    }
}

- (void)move:(CGPoint)deltaPoint {
    if ([self.delegate player:self shouldMoveToPoint:ccpAdd(self.position, self.velocity)]) {
        [super move:deltaPoint];
        [self.delegate player:self didMoveToPoint:self.position];
    }
}

- (void)runAnimationWithName:(NSString *)animName endless:(BOOL)endlessFlag {
    if(![animName isEqualToString:@"jump"]) {
        _cachedAnimation = animName;
    }
    
    if (self.playerState == STPlayerStateSmall) {
        animName = [@"small-" stringByAppendingString:animName];
    } else if (self.playerState == STPlayerStateFire) {
        animName = [@"fire-" stringByAppendingString:animName];
    }
    
    [super runAnimationWithName:animName endless:endlessFlag];
}

- (void)setVelocity:(CGPoint)velocity {
    if (self.isAnimating != (velocity.x > 0 || velocity.x < 0)) {
        if (velocity.x != 0 && !self.isJumping) {
            self.isAnimating = YES;
            [self runAnimationWithName:@"walk" endless:YES];
        } else if (!self.isJumping) {
            self.isAnimating = NO;
            [self runAnimationWithName:@"stand" endless:NO];
        }
    }
    
    [super setVelocity:velocity];
}

- (void)setPlayerState:(STPlayerState)playerState {
    if (playerState >= _playerState) {
        [[STSoundManager sharedInstance] playEffect:kSoundPowerUp];
    }
    
    _playerState = playerState;
    [self runAnimationWithName:_cachedAnimation endless:YES];
}

- (void)die {
    if (self.playerState != STPlayerStateSmall) {
        [[STSoundManager sharedInstance] playEffect:kSoundPipe];
    }
    
    [super die];
}

- (void)setDead:(BOOL)isDead {
    
    if (!self.isInvincible) {
        
        if (isDead && self.playerState != STPlayerStateSmall) {
            [self setPlayerState:STPlayerStateSmall];
            [self setInvincible:YES forTime:kInvinibilityDuration playingInvincibleSong:NO];
            [super setDead:NO];
        } else {
            [super setDead:isDead];
            [self.delegate playerDied:self];
        }
    }
}

- (void)setInvincible:(BOOL)isInvincible forTime:(ccTime)time playingInvincibleSong:(BOOL)invincibleSong {
    // Start being invincible
    [self setInvincible:YES];
    [self schedule:@selector(invincibilityCallback) interval:time];
    
    _stopBackgroundMusic = invincibleSong;
    if (invincibleSong) {
        [[STSoundManager sharedInstance] playBackgroundMusic:@"invincible.m4a"];
    }
    
    // Start blinking
    [self schedule:@selector(blink) interval:kBlinkingSpeed];
}

- (void)invincibilityCallback {
    // Stop being invincible
    [self setInvincible:!self.isInvincible];
    [self unschedule:@selector(invincibilityCallback)];
    
    if (_stopBackgroundMusic) {
        [[STSoundManager sharedInstance] stopBackgroundMusic];
        [self.delegate playerStopsPlayingInvincibleSong:self];
    }
    
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

#pragma mark -
#pragma mark Player Delegate

- (void)setDelegate:(id<STPlayerDelegate>)delegate {
    [super setDelegate:delegate];
}
- (id<STPlayerDelegate>)delegate {
    return (id<STPlayerDelegate>)[super delegate];
}

@end
