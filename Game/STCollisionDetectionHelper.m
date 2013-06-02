//
//  STCollisionDetectionHelper.m
//  Game
//
//  Created by Ilija Tovilo on 4/30/13.
//  Copyright (c) 2013 by Lukas Seglias & Ilija Tovilo. All rights reserved.
//

#import "STCollisionDetectionHelper.h"

BOOL STRectIntersect(CGRect rect1, CGRect rect2) {
    return STXIntersect(rect1, rect2) && STYIntersect(rect1, rect2);
}

BOOL STXIntersect(CGRect rect1, CGRect rect2) {
    if (rect1.origin.x >= rect2.origin.x + rect2.size.width) return NO;
    if (rect1.origin.x + rect1.size.width <= rect2.origin.x) return NO;
    
    return YES;
}

BOOL STYIntersect(CGRect rect1, CGRect rect2) {
    if (rect1.origin.y >= rect2.origin.y + rect2.size.height) return NO;
    if (rect1.origin.y + rect1.size.height <= rect2.origin.y) return NO;
    
    return YES;
}