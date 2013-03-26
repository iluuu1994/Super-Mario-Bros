//
//  Candle.m
//  Game
//
//  Created by Lukas Seglias on 02.02.13.
//  Copyright 2013 Ilija Tovilo. All rights reserved.
//

#import "Candle.h"

@implementation Candle

#pragma mark -
#pragma mark Initialise
- (id)init
{
    if (self = [super initWithPlistFile:@"Candle.plist"]) {
        [self runAction:[CCRepeatForever actionWithAction:[CCAnimate actionWithAnimation:self.animations[@"burn"]]]];
    }
    return self;
}

@end
