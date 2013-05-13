//
//  STMario.m
//  Game
//
//  Created by Ilija Tovilo on 4/9/13.
//  Copyright (c) 2013 by Lukas Seglias & Ilija Tovilo. All rights reserved.
//

#import "STMario.h"

@implementation STMario

#pragma mark -
#pragma mark Initialise

- (id)init
{
    if (self = [super initWithPlistFile:@"Mario.plist"]) {
        // Per default, we run the stand animation
        [self runAnimationWithName:@"stand" endless:NO];
        
    }
    return self;
}

@end
