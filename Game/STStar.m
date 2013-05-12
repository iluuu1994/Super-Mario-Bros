//
//  STStar.m
//  Game
//
//  Created by Ilija Tovilo on 5/11/13.
//  Copyright (c) 2013 Ilija Tovilo. All rights reserved.
//

#import "STStar.h"
#import "STPlayer.h"

#define kDuration 7

@implementation STStar

- (id)init
{
    if (self = [super initWithPlistFile:@"Star.plist"]) {
        [self runAnimationWithName:@"glare" endless:YES];
    }
    return self;
}

- (void)awardPlayer:(STPlayer *)player {
    [super awardPlayer:player];
    [player setInvincible:YES forTime:kDuration];
    [player setKillsInstantly:YES forTime:kDuration];
}

@end
