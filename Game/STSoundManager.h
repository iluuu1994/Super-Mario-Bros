//
//  STSoundManager.h
//  Game
//
//  Created by Ilija Tovilo on 5/2/13.
//  Copyright (c) 2013 Ilija Tovilo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ITSingleton.h"

#define kSoundDeath @"die.mp3"
#define kSoundKick @"kick.mp3"
#define kSoundStomp @"stomp.mp3"
#define kSoundPipe @"pipe.mp3"
#define kSoundCoin @"coin.mp3"
#define kSoundBreakBlock @"break_block.mp3"
#define kSoundStageClear @"stage_clear.mp3"
#define kSoundTimeWarning @"time_warning.mp3"
#define kSoundTheme @"theme.mp3"

@interface STSoundManager : NSObject

ITSingletonInterface

#pragma mark -
#pragma mark Methods
- (void)playEffect:(NSString *)effectFile;
- (void)playBackgroundMusic:(NSString *)backgroundMusicFile;
- (void)playBackgroundMusic:(NSString *)backgroundMusicFile loop:(BOOL)loop;
- (void)stopBackgroundMusic;
- (void)resumeBackgroundMusic;

#pragma mark -
#pragma mark Properties
@property (nonatomic, setter = setSoundEnabled:) BOOL isSoundEnabled;
@property (nonatomic, setter = setBackgroundMusicEnabled:) BOOL isBackgroundMusicEnabled;

@end
