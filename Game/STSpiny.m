//
//  STSpiny.m
//  Game
//
//  Created by Ilija Tovilo on 5/9/13.
//  Copyright (c) 2013 Ilija Tovilo. All rights reserved.
//

#import "STSpiny.h"
#import "STPlayer.h"

#pragma mark - 
#pragma mark Constants

#define kSpeed 10



#pragma mark - 
#pragma mark STSpiny Implementation

@implementation STSpiny



#pragma mark - 
#pragma mark Initialization

- (id)init
{
    if (self = [super initWithPlistFile:@"Spiny.plist"]) {
        [self runAnimationWithName:@"walk" endless:YES];
    }
    return self;
}



#pragma mark Collision

- (void)collisionWithGameObject:(STGameObject *)gameObject edge:(STRectEdge)edge {
    if (edge == STRectEdgeMinX && self.velocity.x < 0) {
        self.velocity = ccp(kSpeed, self.velocity.y);
    } else if (edge == STRectEdgeMaxX && self.velocity.x > 0) {
        self.velocity = ccp(-kSpeed, self.velocity.y);
    }
    
    if(edge != STRectEdgeMaxY && [[gameObject class] isSubclassOfClass:[STPlayer class]]) {
        
        if(edge == STRectEdgeMaxY) {
            // Make the other GameObject jump after jumping on this
            gameObject.velocity = ccpAdd(gameObject.velocity, ccp(0, 100));
        }
        
        [gameObject setDead:YES];
    }
}

@end
