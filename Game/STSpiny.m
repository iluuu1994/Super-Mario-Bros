//
//  STSpiny.m
//  Game
//
//  Created by Ilija Tovilo on 5/9/13.
//  Copyright (c) 2013 Ilija Tovilo. All rights reserved.
//

#import "STSpiny.h"

@implementation STSpiny

- (id)init
{
    if (self = [super initWithPlistFile:@"Spiny.plist"]) {
        [self runAnimationWithName:@"walk" endless:YES];
    }
    return self;
}

@end
