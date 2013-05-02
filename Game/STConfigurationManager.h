//
//  STConfigurationManager.h
//  Game
//
//  Created by Lukas Seglias on 28.04.13.
//  Copyright (c) 2013 Ilija Tovilo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ITSingleton.h"

@interface STConfigurationManager : NSObject

ITSingletonInterface

@property (nonatomic, setter = setMusicOn:) BOOL isMusicOn;
@property (nonatomic, setter = setToneOn:) BOOL isToneOn;

@end
