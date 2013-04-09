//
//  STLevelLayer.m
//  Game
//
//  Created by Ilija Tovilo on 3/12/13.
//  Copyright (c) 2013 Ilija Tovilo. All rights reserved.
//

#import "STLevelLayer.h"
#import "WorldsConstrants.h"
#import "NSBundle+Resources.h"

@implementation STLevelLayer
{}

#pragma mark -
#pragma mark Initialise
- (id)initWithWorldID:(unsigned short)worldID levelID:(unsigned short)levelID {
    NSDictionary *worldsInfo = [NSDictionary dictionaryWithContentsOfFile:[NSBundle pathForResource:kWorldsFile]];
    _levelInfo = worldsInfo[kWorldsKey][worldID][kLevelsKey][levelID];
    [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"Frei.plist"];
    for (id spriteCacheName in [self.levelInfo objectForKey:kLevelSpriteCacheKey]) {
        [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:spriteCacheName];
    }
    
    if (self = [super initWithTiledMap:[NSString stringWithFormat:worldsInfo[kWorldsNamingConvention], worldID, levelID]]) {
        _worldID = worldID;
        _levelID = levelID;
    }
    
    return self;
}

- (void)tearDown {
    [super tearDown];
    
    for (id spriteCacheName in [self.levelInfo objectForKey:kLevelSpriteCacheKey]) {
        [[CCSpriteFrameCache sharedSpriteFrameCache] removeSpriteFramesFromFile:spriteCacheName];
    }
}

+ (id)layerWithWorldID:(unsigned short)worldID levelID:(unsigned short)levelID {
    return [[self alloc] initWithWorldID:worldID levelID:levelID];
}

@end
