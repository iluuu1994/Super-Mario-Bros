//
//  STSoundManager.h
//  Game
//
//  Created by Ilija Tovilo on 5/2/13.
//  Copyright (c) 2013 Ilija Tovilo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ITSingleton.h"

// Sound files
#define kSoundDeath @"die.mp3"
#define kSoundKick @"kick.mp3"
#define kSoundStomp @"stomp.mp3"
#define kSoundPipe @"pipe.mp3" // TODO: use or delete
#define kSoundCoin @"coin.mp3"
#define kSoundBreakBlock @"break_block.mp3"
#define kSoundStageClear @"stage_clear.mp3" // TODO: use
#define kSoundTimeWarning @"time_warning.mp3" // TODO: use or delete
#define kSoundTheme @"theme.mp3"

/**
 * Utility class for doing everything about sound. Provides methods to play,
 * stop, resume, enable, disable sound. 
 */
@interface STSoundManager : NSObject

#pragma mark -
#pragma mark Initialise

ITSingletonInterface

#pragma mark -
#pragma mark Methods

/**
 * Plays an effect from the given audio file. 
 * @param effectFile - the audio file you want to play.
 */
- (void)playEffect:(NSString *)effectFile;

/**
 * Plays the given audio file in the background. 
 * @param backgroundMusicFile - the audio file you want to play.
 */
- (void)playBackgroundMusic:(NSString *)backgroundMusicFile;

/**
 * Plays the given audio file in the background.
 * @param backgroundMusicFile - the audio file you want to play.
 * @param loop - TRUE if you want to loop the given audio file. NO if not.
 */
- (void)playBackgroundMusic:(NSString *)backgroundMusicFile loop:(BOOL)loop;

/**
 * Stop playing the backgroundmusic. 
 */
- (void)stopBackgroundMusic;

/**
 * Resume playing the backgroundmusic.
 */
- (void)resumeBackgroundMusic;

#pragma mark -
#pragma mark Properties

/**
 * Determines whether the sound is enabled (whether sound can be played).
 */
@property (nonatomic, setter = setSoundEnabled:) BOOL isSoundEnabled;

/**
 * Determines whether the backgroundmusic is enabled (whether backgroundmusic can be played).
 */
@property (nonatomic, setter = setBackgroundMusicEnabled:) BOOL isBackgroundMusicEnabled;

@end
