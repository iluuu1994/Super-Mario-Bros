//
//  STGameFlowManager.h
//  Game
//
//  Created by Lukas Seglias on 05.05.13.
//  Copyright (c) 2013 Ilija Tovilo. All rights reserved.
//

#import "ITSingleton.h"

/**
 * Utility class for pausing and resuming the games flow. 
 */
@interface STGameFlowManager : NSObject

#pragma mark -
#pragma mark Initialise

ITSingletonInterface

#pragma mark -
#pragma mark Properties

/**
 * Determines whether the game is currently paused. 
 */
@property (nonatomic, readonly) BOOL isPaused;

#pragma mark -
#pragma mark Methods

/**
 * Pause the game and stop the backgroundmusic. 
 */
- (void)pause;

/**
 * Resume tha game. Start the backgroundmusic if the music is enabled in the settings.
 */
- (void)resume;

/**
 * Resume the game and specify whether the backgroundmusic should be started. 
 */
- (void)resumeWithMusicOn:(BOOL)musicOn;

@end
