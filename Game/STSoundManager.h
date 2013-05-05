//
//  STSoundManager.h
//  Game
//
//  Created by Ilija Tovilo on 5/2/13.
//  Copyright (c) 2013 Ilija Tovilo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ITSingleton.h"

@interface STSoundManager : NSObject

ITSingletonInterface

#pragma mark -
#pragma mark Methods
- (void)playEffect:(NSString *)effectFile;
- (void)playBackgroundMusic:(NSString *)backgroundMusicFile;
- (void)stopBackgroundMusic;
- (void)resumeBackgroundMusic;

#pragma mark -
#pragma mark Properties
@property (nonatomic, setter = setSoundEnabled:) BOOL isSoundEnabled;
@property (nonatomic, setter = setBackgroundMusicEnabled:) BOOL isBackgroundMusicEnabled;

@end
