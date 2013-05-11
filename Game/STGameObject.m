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
