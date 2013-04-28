//
//  STConfigurationManager.h
//  Game
//
//  Created by Lukas Seglias on 28.04.13.
//  Copyright (c) 2013 Ilija Tovilo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface STConfigurationManager : NSObject

+(id)sharedInstance;

@property (atomic) BOOL musicOn;
@property (atomic) BOOL toneOn;

@end
