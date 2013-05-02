//
//  STCollisionDetectionHelper.m
//  Game
//
//  Created by Ilija Tovilo on 4/30/13.
//  Copyright (c) 2013 Ilija Tovilo. All rights reserved.
//

#import "STCollisionDetectionHelper.h"

BOOL STRectIntersect(CGRect rect1, CGRect rect2) {    
    if (rect1.origin.x >= rect2.origin.x + rect2.size.width) return NO;
    if (rect1.origin.x + rect1.size.width <= rect2.origin.x) return NO;
    if (rect1.origin.y >= rect2.origin.y + rect2.size.height) return NO;
    if (rect1.origin.y + rect1.size.height <= rect2.origin.y) return NO;
    
    return YES;
}