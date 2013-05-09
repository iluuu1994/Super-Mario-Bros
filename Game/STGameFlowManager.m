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
    // Pause the Game
    [[CCDirector sharedDirector] pause];
    _isPaused = YES;
    
    // Pause music
    [[STSoundManager sharedInstance] stopBackgroundMusic];
}

- (void)resume {
    [self resumeWithMusicOn:[[STConfigurationManager sharedInstance] isMusicOn]];
}

- (void)resumeWithMusicOn:(BOOL)musicOn {
    // Resume the Game
    [[CCDirector sharedDirector] resume];
    _isPaused = NO;
    
    if(musicOn) {
        // Resume music
        [[STSoundManager sharedInstance] resumeBackgroundMusic];
    }
}

@end
