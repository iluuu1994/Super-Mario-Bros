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


#pragma mark -
#pragma mark Constants

#define kScore 100



#pragma mark -
#pragma mark STFlower Implementation

@implementation STFlower



#pragma mark -
#pragma mark Initialization

- (id)init
{
    if (self = [super initWithPlistFile:@"Flower.plist"]) {
        [self runAnimationWithName:@"glare" endless:YES];
    }
    return self;
}

- (void)onEnter {
    [super onEnter];
    
    [[STSoundManager sharedInstance] playEffect:kSoundPowerUpAppears];
}




#pragma mark -
#pragma mark Methods

- (void)awardPlayer:(STPlayer *)player {
    [super awardPlayer:player];
    
    if (player.playerState != STPlayerStateFire) {
        player.playerState = STPlayerStateFire;
    }
    
    player.score += kScore;
}

@end
