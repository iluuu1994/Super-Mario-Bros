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
    
    // If we need touch notifications, we register as a delegate of the touch dispatcher
    if (self.needsTouchNotifications) {
        [[[CCDirector sharedDirector] touchDispatcher] addStandardDelegate:self priority:0];
    }
}

- (void)onExit {
    [super onExit];
    
    // If we needed touch notifications, we resign ourselves as the delegate of the touch dispatcher
    if (self.needsTouchNotifications) {
        [[[CCDirector sharedDirector] touchDispatcher] removeDelegate:self];
    }
}

#pragma mark -
#pragma mark Methods

- (void)move:(CGPoint)deltaPoint {
    // Add the delta point to the position
    self.position = ccpAdd(self.position, deltaPoint);
}

/** 
 * Empty implementation of the collisions
 * This can be overridden if needed in subclasses
 */
- (void)collisionWithGameObject:(STGameObject *)gameObject
                           edge:(STRectEdge)edge {
    
}

/**
 * Per default, we don't differentiate appearances
 */
- (BOOL)differenciatesAppearance {
    return NO;
}

- (void)displayFrameWithName:(NSString *)spriteFrameName {
    [super displayFrameWithName:[self appearanceNameForString:spriteFrameName]];
}

- (void)runAnimationWithName:(NSString *)animName endless:(BOOL)endlessFlag {
    [super runAnimationWithName:[self appearanceNameForString:animName] endless:endlessFlag];
}

- (void)runAnimationWithName:(NSString *)animName callbackBlock:(void (^)())block {
    [super runAnimationWithName:[self appearanceNameForString:animName] callbackBlock:block];
}

- (NSString *)appearanceNameForString:(NSString *)name {
    if (self.differenciatesAppearance) {
        if (self.appearanceType == STAppearanceTypeDark) {
            name = [@"dark" stringByAppendingString:name];
        } else if (self.appearanceType == STAppearanceTypeCastle) {
            name = [@"castle" stringByAppendingString:name];
        }
    }
    
    return name;
}

#pragma mark -
#pragma Targeted Delegate

- (BOOL)needsTouchNotifications {
    return NO;
}

@end
