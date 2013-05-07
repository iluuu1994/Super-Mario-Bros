//
//  STKoopa.m
//  Game
//
//  Created by Ilija Tovilo on 5/7/13.
//  Copyright (c) 2013 Ilija Tovilo. All rights reserved.
//

#import "STKoopa.h"

@implementation STKoopa

- (id)init
{
    if (self = [super initWithPlistFile:@"Koopa.plist"]) {
        [self runAnimationWithName:@"walk" endless:YES];
    }
    return self;
}

@end
