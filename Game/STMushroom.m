//
//  STMushroom.m
//  Game
//
//  Created by Ilija Tovilo on 5/10/13.
//  Copyright (c) 2013 by Lukas Seglias & Ilija Tovilo. All rights reserved.
//

#import "STMushroom.h"
#import "STPlayer.h"
#import "STSoundManager.h"

#pragma mark -
#pragma mark Constants

#define kScore 50
#define kSpeed 50


#pragma mark -
#pragma mark STMushroom Implementation

@implementation STMushroom


#pragma mark -
#pragma mark Initialization

- (id)init
{
    if (self = [super initWithPlistFile:@"Mushroom.plist"]) {
        [self runAnimationWithName:@"default" endless:YES];
        self.velocity = ccp(kSpeed, 0);
    }
    return self;
}

- (void)onEnter {
    [super onEnter];
    
    [[STSoundManager sharedInstance] playEffect:kSoundPowerUpAppears];
}


#pragma mark -
#pragma mark Methods

- (STGameObjectBodyType)bodyType {
    return STGameObjectBodyTypeDynamic;
}

- (void)collisionWithGameObject:(STGameObject *)gameObject edge:(STRectEdge)edge {
    [super collisionWithGameObject:gameObject edge:edge];
    
    if (edge == STRectEdgeMaxX) {
        self.velocity = ccp(-kSpeed, 0);
    } else if (edge == STRectEdgeMinX) {
        self.velocity = ccp(kSpeed, 0);
    }
}

- (void)awardPlayer:(STPlayer *)player {
    [super awardPlayer:player];
    
    if (player.playerState == STPlayerStateSmall) {
        player.playerState = STPlayerStateLarge;
    }
    
    player.score += kScore;
}

@end
