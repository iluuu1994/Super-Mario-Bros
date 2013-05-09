//
//  STWorldInfoReader.h
//  Game
//
//  Created by Lukas Seglias on 09.05.13.
//  Copyright (c) 2013 Ilija Tovilo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "STWorldsConstants.h"
#import "ITSingleton.h"

@interface STWorldInfoReader : NSObject

ITSingletonInterface

#pragma mark -
#pragma mark Properties
@property (strong, readonly) NSArray *root;

#pragma mark -
#pragma mark Methods
- (id) namingConvention;
- (id) worlds;
- (id) worldWithID:(unsigned short)worldID;
- (id) levelWithWorldID:(unsigned short)worldID levelID:(unsigned short)levelID;

@end
