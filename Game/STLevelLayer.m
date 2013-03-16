//
//  STLevelLayer.m
//  Game
//
//  Created by Ilija Tovilo on 3/12/13.
//  Copyright (c) 2013 Ilija Tovilo. All rights reserved.
//

#import "STLevelLayer.h"

@implementation STLevelLayer
{}

#pragma mark -
#pragma mark Initialise
- (id)initWithWorldID:(unsigned short)worldID levelID:(unsigned short)levelID {
    // TODO: Fetch Naming Convention from Worlds.plist
    if (self = [super initWithTiledMap:[NSString stringWithFormat:@"world_%d_level_%d.tmx", worldID, levelID]]) {
        
    }
    
    return self;
}

+ (id)layerWithWorldID:(unsigned short)worldID levelID:(unsigned short)levelID {
    return [[self alloc] initWithWorldID:worldID levelID:levelID];
}

@end
