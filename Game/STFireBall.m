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

- (STGameObjectBodyType)bodyType {
    return STGameObjectBodyTypeDynamic;
}

- (void)collisionWithGameObject:(STGameObject *)gameObject edge:(STRectEdge)edge {
    
//    if(self.velocity.y <= 0) {
//        self.velocity = ccpAdd(self.velocity, ccp(0, kSpeed));
//    }
//    
    // Make the FireBall jump after jumping on a gameObject
//    if (edge == STRectEdgeMaxY) {
//        NSLog(@"x: %f, y: %f", self.velocity.x, self.velocity.y);
//        self.velocity = ccpAdd(self.velocity, ccp(0, kSpeed));
//    }
    
    // Only kills creatures except for the player.
    if([[gameObject class] isSubclassOfClass:[STCreature class]]
       && ![[gameObject class] isSubclassOfClass:[STPlayer class]]) {
        [gameObject setDead:YES];
    }
}

@end
