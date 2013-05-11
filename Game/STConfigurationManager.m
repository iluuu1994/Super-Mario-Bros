//
//  STConfigurationManager.m
//  Game
//
//  Created by Lukas Seglias on 28.04.13.
//  Copyright (c) 2013 Ilija Tovilo. All rights reserved.
//

#import "STConfigurationManager.h"
#import "STSoundManager.h"

@implementation STConfigurationManager
{}

#pragma mark -
#pragma mark Initialise

ITSingletonImplementation

#pragma mark - 
#pragma mark Properties

- (void)setMusicOn:(BOOL)musicOn {
    [[STSoundManager sharedInstance] setBackgroundMusicEnabled:musicOn];
}

- (BOOL)isMusicOn {
    return [[STSoundManager sharedInstance] isBackgroundMusicEnabled];
}

- (void)setToneOn:(BOOL)toneOn {
    [[STSoundManager sharedInstance] setSoundEnabled:toneOn];
}

- (BOOL)isToneOn {
    return [[STSoundManager sharedInstance] isSoundEnabled];
}

@end
