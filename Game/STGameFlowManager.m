//
//  STGameFlowManager.m
//  Game
//
//  Created by Lukas Seglias on 05.05.13.
//  Copyright (c) 2013 Ilija Tovilo. All rights reserved.
//

#import "STGameFlowManager.h"

@implementation STGameFlowManager
{}

#pragma mark -
#pragma mark Init

ITSingletonImplementation

#pragma mark -
#pragma mark Gameflow Manipulation Methods

- (void)pause {
    [[STSoundManager sharedInstance] setSoundEnabled:NO];
    [[CCDirector sharedDirector] pause];
    _isPaused = YES;
}

- (void)resume {
    [[STSoundManager sharedInstance] setSoundEnabled:YES];
    [[CCDirector sharedDirector] resume];
    _isPaused = NO;
}

@end
