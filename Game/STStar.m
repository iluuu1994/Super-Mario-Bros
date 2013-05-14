//
//  STStar.m
//  Game
//
//  Created by Ilija Tovilo on 5/11/13.
//  Copyright (c) 2013 by Lukas Seglias & Ilija Tovilo. All rights reserved.
//

#import "STStar.h"
#import "STPlayer.h"

#pragma mark -
#pragma mark Constants

#define kDuration 7
#define kXVelocity 50
#define kYBounce 300




#pragma mark -
#pragma mark STStar Implementation

@implementation STStar


#pragma mark -
#pragma mark Initialization

- (id)init
{
    if (self = [super initWithPlistFile:@"Star.plist"]) {
        [self runAnimationWithName:@"glare" endless:YES];
        self.velocity = ccp(kXVelocity, kYBounce);
    }
    return self;
}



#pragma mark -
#pragma mark Methods

- (STGameObjectBodyType)bodyType {
    return STGameObjectBodyTypeDynamic;
}

- (void)collisionWithGameObject:(STGameObject *)gameObject
                           edge:(STRectEdge)edge {
    [super collisionWithGameObject:gameObject edge:edge];
    
    if (edge == STRectEdgeMinY) {
        self.velocity = ccpAdd(self.velocity, ccp(0, kYBounce));
    }
}

- (void)awardPlayer:(STPlayer *)player {
    [super awardPlayer:player];
    [player setInvincible:YES forTime:kDuration playingInvincibleSong:YES];
    [player setKillsInstantly:YES forTime:kDuration];
}

@end
