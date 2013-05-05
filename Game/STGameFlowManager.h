//
//  STGameFlowManager.h
//  Game
//
//  Created by Lukas Seglias on 05.05.13.
//  Copyright (c) 2013 Ilija Tovilo. All rights reserved.
//

#import "ITSingleton.h"
#import "CCDirector+Transitions.h"
#import "STSoundManager.h"
#import "STConfigurationManager.h"

@interface STGameFlowManager : NSObject

ITSingletonInterface

#pragma mark -
#pragma mark Properties
@property (nonatomic, readonly) BOOL isPaused;

#pragma mark -
#pragma mark Methods

- (void)pause;
- (void)resume;
- (void)resumeWithMusicOn:(BOOL)musicOn;

@end
