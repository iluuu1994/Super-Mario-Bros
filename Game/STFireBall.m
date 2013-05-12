//
//  STFireBall.m
//  Game
//
//  Created by Ilija Tovilo on 5/12/13.
//  Copyright (c) 2013 Ilija Tovilo. All rights reserved.
//

#import "STFireBall.h"
#import "STCreature.h"
#import "STPlayer.h"

#define kSpeed 50

@implementation STFireBall

- (id)init
{
    self = [super initWithPlistFile:@"FireBall.plist"];
    if (self) {
        [self runAnimationWithName:@"spin" endless:YES];
        self.velocity = ccp(kSpeed, 0);
    }
    return self;
}

- (void)collisionWithGameObject:(STGameObject *)gameObject edge:(STRectEdge)edge {
    
    // Make the FireBall jump after jumping on a gameObject
    self.velocity = ccpAdd(self.velocity, ccp(0, 100));
    
    // Only kills creatures except for the player.
    if([[gameObject class] isSubclassOfClass:[STCreature class]]
       && ![[gameObject class] isSubclassOfClass:[STPlayer class]]) {
        [gameObject setDead:YES];
    }
}

@end
