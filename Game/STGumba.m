//
//  STGumba.m
//  Game
//
//  Created by Ilija Tovilo on 5/7/13.
//  Copyright (c) 2013 Ilija Tovilo. All rights reserved.
//

#import "STGumba.h"

@implementation STGumba

- (id)init
{
    if (self = [super initWithPlistFile:@"Gumba.plist"]) {
        [self runAnimationWithName:@"walk" endless:YES];
    }
    return self;
}

@end
