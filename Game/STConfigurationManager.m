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
#pragma mark Init

ITSingletonImplementation

#pragma mark - 
#pragma mark Properties

- (void)setMusicOn:(BOOL)musicOn {
    NSLog(@"%d", musicOn);
    [[STSoundManager sharedInstance] setBackgroundMusicEnabled:musicOn];
}

- (BOOL)isMusicOn {
    return [[STSoundManager sharedInstance] isBackgroundMusicEnabled];
}

- (void)setToneOn:(BOOL)toneOn {
    NSLog(@"%d", toneOn);
    [[STSoundManager sharedInstance] setSoundEnabled:toneOn];
}

- (BOOL)isToneOn {
    return [[STSoundManager sharedInstance] isSoundEnabled];
}

@end
