//
//  STCoin.m
//  Game
//
//  Created by Ilija Tovilo on 5/7/13.
//  Copyright (c) 2013 Ilija Tovilo. All rights reserved.
//

#import "STCoin.h"

@implementation STCoin

- (id)init
{
    if (self = [super initWithPlistFile:@"Coin.plist"]) {
        [self runAnimationWithName:@"blink" endless:YES];
    }
    return self;
}

@end
