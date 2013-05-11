//
//  STWorldInfoReader.h
//  Game
//
//  Created by Lukas Seglias on 09.05.13.
//  Copyright (c) 2013 Ilija Tovilo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ITSingleton.h"

/**
 * Utility class to read and modify the file Worlds.plist which contains 
 * information about the available playable levels grouped in worlds. 
 */
@interface STWorldInfoReader : NSObject

#pragma mark -
#pragma mark Initialise

ITSingletonInterface

#pragma mark -
#pragma mark Properties

/**
 * The root of all objects inside of Worlds.plist.
 */
@property (strong, readonly) NSArray *root;

#pragma mark -
#pragma mark Methods

/**
 * Returns the naming convention of the map files. These map files are used to start a level.
 * @return the naming convention as NSString. 
 */
- (id) namingConvention;

/**
 * Returns an array of all available worlds.
 * @return an NSArray with all worlds.
 */
- (id) worlds;

/**
 * Returns the information of the world identfied by the given world id.
 * @param worldID - the world whose information we want.
 * @return a NSDictionary with the information of the world identified by the given
 *         world id. nil if the identified world doesn't exist. 
 */
- (id) worldWithID:(unsigned short)worldID;

/**
 * Returns the information of the level identified by the given world id and level id.
 * @param worldID - the world containing the level we want to get.
 * @param levelID - the level whose information we want.
 * @return a NSDictionary with the information of the level identified by the given 
 *         world id and level id. nil if the identified level doesn't exist.
 */
- (id) levelWithWorldID:(unsigned short)worldID levelID:(unsigned short)levelID;

/**
 * Starts the level which is next to the level identified by the given world id and level id.
 * @param worldID - the world whose next level we want to unlock.
 * @param levelID - the level whose neighbout will be unlocked. 
 * @return a NSDictionary with the information of the next level. nil if the given level 
 *         is the last level of the given world.
 */
- (id) nextLevelFromWorldID:(unsigned short)worldID levelID:(unsigned short)levelID;

/**
 * Unlocks the world identified by the given world id.
 * @param worldID - the world we want to unlock.
 */
- (void) unlockWorldID:(unsigned short)worldID;

/**
 * Unlocks the level identified by the given world id and level id. 
 * @param worldID - the world containing the level we want to unlock.
 * @param levelID - the level we want to unlock. 
 */
- (void) unlockWorldID:(unsigned short)worldID levelID:(unsigned short)levelID;

@end
