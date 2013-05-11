//
//  STConfigurationManager.h
//  Game
//
//  Created by Lukas Seglias on 28.04.13.
//  Copyright (c) 2013 Ilija Tovilo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ITSingleton.h"

/**
 * Utility class to configure the settings of this game. Provides methods to
 * get and set the curren configuration. It is recommended to exclusively use
 * this class to change the settings. Do not cache them. 
 */
@interface STConfigurationManager : NSObject

#pragma mark -
#pragma mark Initialise

ITSingletonInterface

#pragma mark -
#pragma mark Properties

/**
 * Determines whether the music is enabled (whether music can be played).
 */
@property (nonatomic, setter = setMusicOn:) BOOL isMusicOn;

/**
 * Determines whether the tone is enabled (whether sound can be played).
 */
@property (nonatomic, setter = setToneOn:) BOOL isToneOn;

@end
