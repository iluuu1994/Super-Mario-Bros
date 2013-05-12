//
//  STMushroom.m
//  Game
//
//  Created by Ilija Tovilo on 5/10/13.
//  Copyright (c) 2013 Ilija Tovilo. All rights reserved.
//

#import "STMushroom.h"
#import "STPlayer.h"
#import "STSoundManager.h"

#define kScore 50

@implementation STMushroom

- (id)init
{
    if (self = [super initWithPlistFile:@"Mushroom.plist"]) {
        [self runAnimationWithName:@"default" endless:YES];
    }
    return self;
}

- (void)awardPlayer:(STPlayer *)player {
    [super awardPlayer:player];
    
    if (player.playerState == STPlayerStateSmall) {
        player.playerState = STPlayerStateLarge;
    }
    
    player.score += kScore;
}

- (void)onEnter {
    [super onEnter];
    
    [[STSoundManager sharedInstance] playEffect:@"powerup-appears.mp3"];
}

@end
