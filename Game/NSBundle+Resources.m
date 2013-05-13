//
//  NSBundle+Resources.m
//  Game
//
//  Created by Ilija Tovilo on 3/26/13.
//  Copyright (c) 2013 Ilija Tovilo. All rights reserved.
//

#import "NSBundle+Resources.h"


#pragma mark -
#pragma mark NSBundle (Resources) Implementation

@implementation NSBundle (Resources)


#pragma mark -
#pragma mark Resources

+ (id)pathForResource:(NSString *)resourceName {
    return [[self mainBundle] pathForResource:resourceName ofType:@""];
}

@end
