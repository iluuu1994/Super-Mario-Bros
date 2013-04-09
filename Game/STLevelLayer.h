//
//  STLevelLayer.h
//  Game
//
//  Created by Ilija Tovilo on 3/12/13.
//  Copyright (c) 2013 Ilija Tovilo. All rights reserved.
//

#import "STTiledMapLayer.h"

@interface STLevelLayer : STTiledMapLayer
{}

#pragma mark -
#pragma mark Properties
@property (readonly) unsigned short worldID;
@property (readonly) unsigned short levelID;
@property (strong, readonly) NSDictionary *levelInfo;

#pragma mark -
#pragma mark Initialise
- (id)initWithWorldID:(unsigned short)worldID levelID:(unsigned short)levelID;
+ (id)layerWithWorldID:(unsigned short)worldID levelID:(unsigned short)levelID;

@end
