//
//  STFireBall.m
//  Game
//
//  Created by Ilija Tovilo on 5/12/13.
//  Copyright (c) 2013 Ilija Tovilo. All rights reserved.
//

#import "STFireBall.h"

@implementation STFireBall

- (id)init
{
    self = [super initWithPlistFile:@"FireBall.plist"];
    if (self) {
        [self runAnimationWithName:@"spin" endless:YES];
    }
    return self;
}

@end
