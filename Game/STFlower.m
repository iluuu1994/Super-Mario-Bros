//
//  STFlower.m
//  Game
//
//  Created by Ilija Tovilo on 5/11/13.
//  Copyright (c) 2013 Ilija Tovilo. All rights reserved.
//

#import "STFlower.h"
#import "STPlayer.h"
#import "STSoundManager.h"

#define kScore 100

@implementation STFlower

- (id)init
{
    if (self = [super initWithPlistFile:@"Flower.plist"]) {
        [self runAnimationWithName:@"glare" endless:YES];
    }
    return self;
}

- (void)awardPlayer:(STPlayer *)player {
    [super awardPlayer:player];
    
    if (player.playerState != STPlayerStateFire) {
        player.playerState = STPlayerStateFire;
    }
    
    player.score += kScore;
}

- (void)onEnter {
    [super onEnter];
    
    [[STSoundManager sharedInstance] playEffect:@"powerup-appears.mp3"];
}

@end
