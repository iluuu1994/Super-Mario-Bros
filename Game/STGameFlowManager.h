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

@interface STGameFlowManager : NSObject

ITSingletonInterface

@property (nonatomic, readonly) BOOL isPaused;

- (void)pause;
- (void)resume;

@end
