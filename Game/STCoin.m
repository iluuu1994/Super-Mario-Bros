//
//  STCoin.m
//  Game
//
//  Created by Ilija Tovilo on 5/7/13.
//  Copyright (c) 2013 by Lukas Seglias & Ilija Tovilo. All rights reserved.
//

#import "STCoin.h"
#import "STPlayer.h"
#import "STSoundManager.h"


#pragma mark -
#pragma mark STCoin Implementation

@implementation STCoin


#pragma mark -
#pragma mark Initialization

- (id)init
{
    if (self = [super initWithPlistFile:@"Coin.plist"]) {
        [self runAnimationWithName:@"spin" endless:YES];
    }
    return self;
}


#pragma mark -
#pragma mark Methods

- (void)awardPlayer:(STPlayer *)player {
    [super awardPlayer:player];
    [[STSoundManager sharedInstance] playEffect:kSoundCoin];
    
    player.score += 10;
    player.coins += 1;
}

@end
