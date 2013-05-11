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
        [self runAnimationWithName:@"stand" endless:NO];
    }
    return self;
}

- (void) setPlayerState:(STPlayerState)playerState {
    [super setPlayerState:playerState];
        
    if(playerState == STPlayerStateLarge) {
        [self runAnimationWithName:@"grow" endless:NO];
        
    }
}

@end
