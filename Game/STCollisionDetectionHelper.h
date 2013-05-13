//
//  STCollisionDetectionHelper.h
//  Game
//
//  Created by Ilija Tovilo on 4/30/13.
//  Copyright (c) 2013 Ilija Tovilo. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 * A simple helper file to detect intersections
 */


/**
 * Check whether the given two rectangles intersect.
 * @param rect1 - the first rectangle. Check whether this rectangle intersects with the second rectangle.
 * @param rect2 - the second rectangle. Check whether this rectangle intersects with the first rectangle.
 * @return YES if the given rectables intersect. NO if not.
 */
BOOL STRectIntersect(CGRect rect1, CGRect rect2);