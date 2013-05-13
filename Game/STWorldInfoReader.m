//
//  STWorldInfoReader.m
//  Game
//
//  Created by Lukas Seglias on 09.05.13.
//  Copyright (c) 2013 Ilija Tovilo. All rights reserved.
//

#import "STWorldInfoReader.h"
#import "NSBundle+Resources.h"
#import "STWorldsConstants.h"

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

- (int) indexOfWorldID:(unsigned short)worldID {
    NSArray *worlds = [[self root] valueForKey:kWorldsKey];
    
    for(int i = 0; i < [worlds count]; i++) {
        if([[[worlds objectAtIndex:i] valueForKey:kWorldIDKey] integerValue] == worldID) {
            return i;
        }
    }
    return -1;
}

- (int) indexOfWorldID:(unsigned short)worldID levelID:(unsigned short)levelID {
    NSDictionary *world = [self worldWithID:worldID];
    NSArray *levels = [world valueForKey:kLevelsKey];
    
    for(int i = 0; i < [levels count]; i++) {
        if([[[levels objectAtIndex:i] valueForKey:kLevelIDKey] integerValue] == levelID) {
            return i;
        }
    }
    return -1;
}

- (id) isLastLevel:(unsigned short)levelID fromWorld:(unsigned short)worldID {
    int indexOfLevel = [self indexOfWorldID:worldID levelID:levelID];
    NSDictionary *world = [self worldWithID:worldID];
    if (indexOfLevel - 1 == [[world valueForKey:kLevelsKey] count]) {
        
    }
}

- (id) nextWorldFromWorldID:(unsigned short)worldID {
    NSArray *worlds = [[self root] valueForKey:kWorldsKey];

    int nextWorldIndex = [self indexOfWorldID:worldID] + 1;
    
    if(nextWorldIndex != 0) {
        // Is there a world with the new index?
        if(nextWorldIndex < [worlds count]) {
            return [worlds objectAtIndex:nextWorldIndex];
        }
    }
    return nil;
}

- (id) nextLevelFromWorldID:(unsigned short)worldID levelID:(unsigned short)levelID {
    NSDictionary *world = [self worldWithID:worldID];
    NSArray *levels = [world valueForKey:kLevelsKey];
    
    int nextLevelIndex = [self indexOfWorldID:worldID levelID:levelID] + 1;
    
    if(nextLevelIndex != 0) {
        // Is there a world with the new index?
        if(nextLevelIndex < [levels count]) {
            return [levels objectAtIndex:nextLevelIndex];
        }
    }
    return nil;
}

- (void) unlockWorldID:(unsigned short)worldID {
    [self unlockWorldID:worldID levelID:0];
}

- (BOOL) isUnlockedWorldID:(unsigned short)worldID {
    return [self isUnlockedWorldID:worldID levelID:0];
}

- (void) unlockWorldID:(unsigned short)worldID levelID:(unsigned short)levelID {
    [[NSUserDefaults standardUserDefaults] setBool:YES
                                            forKey:[NSString stringWithFormat:[self namingConvention],
                                                    worldID, levelID]];
}

- (BOOL) isUnlockedWorldID:(unsigned short)worldID levelID:(unsigned short)levelID {
    return [[NSUserDefaults standardUserDefaults] boolForKey:[NSString stringWithFormat:
                                                              [self namingConvention], worldID, levelID]];
}


@end


