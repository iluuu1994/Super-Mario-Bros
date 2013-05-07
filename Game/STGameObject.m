//
//  STGameObject.m
//  Game
//
//  Created by Ilija Tovilo on 4/23/13.
//  Copyright (c) 2013 Ilija Tovilo. All rights reserved.
//

#import "STGameObject.h"

@implementation STGameObject
{}

#pragma mark -
#pragma mark Init
- (void)onEnter {
    [super onEnter];
    
    self.isCollidable = YES;
    if (self.needsTouchNotifications) {
        [[[CCDirector sharedDirector] touchDispatcher] addStandardDelegate:self priority:0];
    }
}

- (void)onExit {
    [super onExit];
    
    if (self.needsTouchNotifications) {
        [[[CCDirector sharedDirector] touchDispatcher] removeDelegate:self];
    }
}

- (void)move:(CGPoint)deltaPoint {
    self.position = ccpAdd(self.position, deltaPoint);
}

- (void)collisionWithGameObject:(STGameObject *)gameObject
                           edge:(STRectEdge)edge {
    
}

- (void)die:(id)sender {
    self.isDead = YES;
}

#pragma mark -
#pragma Targeted Delegate

- (BOOL)needsTouchNotifications {
    return NO;
}

@end
