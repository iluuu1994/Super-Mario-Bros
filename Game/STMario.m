//
//  STMario.m
//  Game
//
//  Created by Ilija Tovilo on 4/9/13.
//  Copyright (c) 2013 Ilija Tovilo. All rights reserved.
//

#import "STMario.h"

@implementation STMario

#pragma mark -
#pragma mark Initialise
- (id)init
{
    if (self = [super initWithPlistFile:@"Mario.plist"]) {
        [self runAction:[CCRepeatForever actionWithAction:[CCAnimate actionWithAnimation:self.animations[@"walk"]]]];
    }
    return self;
}

@end
