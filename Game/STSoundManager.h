//
//  STSoundManager.h
//  Game
//
//  Created by Ilija Tovilo on 5/2/13.
//  Copyright (c) 2013 by Lukas Seglias & Ilija Tovilo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ITSingleton.h"


#pragma mark -
#pragma mark Constants

// Sound files
#define kSoundDeath @"die.wav"
#define kSoundKick @"kick.mp3"
#define kSoundStomp @"stomp.mp3"
#define kSoundPipe @"pipe.mp3"
#define kSoundCoin @"coin.mp3"
#define kSoundBreakBlock @"break_block.mp3"
#define kSoundStageClear @"stage_clear.wav"
#define kSoundTheme @"theme.mp3"
#define kSoundFireball @"fireball.mp3"
#define kSoundPowerUp @"powerup.mp3"
#define kSoundPowerUpAppears @"powerup-appears.mp3"



#pragma mark -
#pragma mark STSoundManager Implementation

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
