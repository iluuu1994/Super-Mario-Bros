//
//  NSBundle+Resources.h
//  Game
//
//  Created by Ilija Tovilo on 3/26/13.
//  Copyright (c) 2013 Ilija Tovilo. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 * Helper for Bundle. Get resources easier.
 */
@interface NSBundle (Resources)
{}

#pragma mark -
#pragma mark Resources
/**
 * Gets a file from the resources via name.
 * @param resourceName - The file name of the resource
 */
+ (id)pathForResource:(NSString *)resourceName;

@end
