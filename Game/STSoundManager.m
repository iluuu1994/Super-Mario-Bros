//
//  STSoundManager.m
//  Game
//
//  Created by Ilija Tovilo on 5/2/13.
//  Copyright (c) 2013 Ilija Tovilo. All rights reserved.
//

#import "STSoundManager.h"
#import "SimpleAudioEngine.h"

@implementation STSoundManager

ITSingletonImplementation

- (void)playEffect:(NSString *)effectFile {
    [[SimpleAudioEngine sharedEngine] playEffect:effectFile];
}

- (void)playBackgroundMusic:(NSString *)backgroundMusicFile {
    [[SimpleAudioEngine sharedEngine] playBackgroundMusic:backgroundMusicFile];
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
