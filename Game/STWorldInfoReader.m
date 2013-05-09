//
//  STWorldInfoReader.m
//  Game
//
//  Created by Lukas Seglias on 09.05.13.
//  Copyright (c) 2013 Ilija Tovilo. All rights reserved.
//

#import "STWorldInfoReader.h"
#import "NSBundle+Resources.h"

@implementation STWorldInfoReader

#pragma mark -
#pragma mark Initialise

ITSingletonImplementation

- (id)init
{
    self = [super init];
    if (self) {
        _root = [NSDictionary dictionaryWithContentsOfFile:[NSBundle pathForResource:kWorldsFile]];
    }
    return self;
}

#pragma mark -
#pragma mark Methods
- (id) namingConvention {
    return [_root valueForKey:kWorldsNamingConvention];
}

- (id) worlds {
    return [_root valueForKey:kWorldsKey];
}

- (id) worldWithID:(unsigned short)worldID {
    for(NSDictionary *world in [self worlds]) {
        if(worldID == [[world objectForKey:kWorldIDKey] integerValue]) {
            return world;
        }
    }
    return nil;
}

- (id) levelWithWorldID:(unsigned short)worldID levelID:(unsigned short)levelID {
    for(NSDictionary *level in [[self worldWithID:worldID] valueForKey:kLevelsKey]) {
        if(levelID == [[level objectForKey:kLevelIDKey] integerValue]) {
            return level;
        }
    }
    return nil;
}

@end


