//
//  STStar.m
//  Game
//
//  Created by Ilija Tovilo on 5/11/13.
//  Copyright (c) 2013 Ilija Tovilo. All rights reserved.
//

#import "STStar.h"
#import "STPlayer.h"

#pragma mark -
#pragma mark Constants

#define kDuration 7




#pragma mark -
#pragma mark STStar Implementation

@implementation STStar


#pragma mark -
#pragma mark Initialization

- (id)init
{
    if (self = [super initWithPlistFile:@"Star.plist"]) {
        [self runAnimationWithName:@"glare" endless:YES];
    }
    return self;
}



#pragma mark -
#pragma mark Methods

- (void)awardPlayer:(STPlayer *)player {
    [super awardPlayer:player];
    [player setInvincible:YES forTime:kDuration playingInvincibleSong:YES];
    [player setKillsInstantly:YES forTime:kDuration];
}

@end
