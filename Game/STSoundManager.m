//
//  STSoundManager.m
//  Game
//
//  Created by Ilija Tovilo on 5/2/13.
//  Copyright (c) 2013 by Lukas Seglias & Ilija Tovilo. All rights reserved.
//

#import "STSoundManager.h"
#import "SimpleAudioEngine.h"

@implementation STSoundManager

#pragma mark -
#pragma mark Initialise

ITSingletonImplementation

#pragma mark -
#pragma mark Methods

+ (void)initialize {
    [SimpleAudioEngine sharedEngine];
}

- (void)playEffect:(NSString *)effectFile {
    [[SimpleAudioEngine sharedEngine] playEffect:effectFile];
}

- (void)playBackgroundMusic:(NSString *)backgroundMusicFile {
    [[SimpleAudioEngine sharedEngine] playBackgroundMusic:backgroundMusicFile];
}

- (void)playBackgroundMusic:(NSString *)backgroundMusicFile loop:(BOOL)loop {
    [[SimpleAudioEngine sharedEngine] playBackgroundMusic:backgroundMusicFile loop:loop];
}

- (void)stopBackgroundMusic {
    [[SimpleAudioEngine sharedEngine] pauseBackgroundMusic];
}

- (void)resumeBackgroundMusic {
    [[SimpleAudioEngine sharedEngine] resumeBackgroundMusic];
}

- (BOOL)isSoundEnabled {
    return ![CDAudioManager sharedManager].mute;
}

- (void)setSoundEnabled:(BOOL)isSoundEnabled {
    [CDAudioManager sharedManager].mute = !isSoundEnabled;
}

- (BOOL)isBackgroundMusicEnabled {
    return [CDAudioManager sharedManager].backgroundMusic.enabled;
}

- (void)setBackgroundMusicEnabled:(BOOL)isBackgroundMusicEnabled {
    [CDAudioManager sharedManager].backgroundMusic.enabled = isBackgroundMusicEnabled;
}

@end
