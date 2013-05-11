//
//  WorldsConstants.h
//  Game
//
//  Created by Ilija Tovilo on 4/9/13.
//  Copyright (c) 2013 Ilija Tovilo. All rights reserved.
//

#ifndef Game_WorldsConstants_h
#define Game_WorldsConstants_h

// Definitions of Constants for the Information about a world in
// Worlds.plist. These keys are used to get a worlds information.
#define kWorldsFile @"Worlds.plist"
#define kWorldsNamingConvention @"Naming Convention"
#define kWorldsKey @"Worlds"
#define kWorldIDKey @"ID"
#define kWorldNameKey @"Name"
#define kWorldShortNameKey @"Short Name"
#define kWorldIconKey @"Icon Name"
#define kWorldIsLockedKey @"Is Locked"

// Definitions of Constants for the Information about a level in
// Worlds.plist. These keys are used to get a levels information.
#define kLevelsKey @"Levels"
#define kLevelIDKey @"ID"
#define kLevelNameKey @"Name"
#define kLevelShortNameKey @"Short Name"
#define kLevelIconNameKey @"Icon Name"
#define kLevelIsLockedKey @"Is Locked"
#define kLevelSpriteCacheKey @"Sprite Cache"
#define kLevelTimeKey @"Time"

// If a world or level is locked this icon is displayed
// on top of the normal world or level icon.
#define kLockIcon @"lock.png"

#endif
