//
//  STChooseLevelLayer.m
//  Game
//
//  Created by Lukas Seglias on 01.04.13.
//  Copyright 2013 Ilija Tovilo. All rights reserved.
//

#import "STChooseLevelLayer.h"
#import "WorldsConstrants.h"

#define kLevelSelectionRowNumber 3
#define kLevelSelectionColumnNumber 5


@implementation STChooseLevelLayer

#pragma mark -
#pragma mark Initialise
- (id)initWithWorldId:(unsigned int)worldId
{
    self = [super init];
    if (self) {
        [self setUpWithWorldId:worldId];
    }
    return self;
}

+(id)sceneWithWorldId:(unsigned int)worldId {
    
    STChooseLevelLayer *layer = [[STChooseLevelLayer alloc] initWithWorldId:worldId];
    STScene *scene = [STScene node];
    [scene addChild:layer];
    return scene;
}

+(id)layerWithWorldId:(unsigned int)worldId {
    return [[self alloc] initWithWorldId:worldId];
}

- (void)setUpWithWorldId:(unsigned int)worldId {
    [super setUp];
    
    NSDictionary *root = [[NSDictionary alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:kWorldsFile ofType:@""]];

    // Retrieve the world with the given id
    NSDictionary *selectedWorld;
    for(NSDictionary *world in [root objectForKey:kWorldsKey]) {
        if(worldId == [[world objectForKey:kWorldIDKey] integerValue]) {
            selectedWorld = world;
        }
    }
    
    NSArray *levels = [selectedWorld objectForKey:kLevelsKey];
    NSMutableArray *levelItems = [[NSMutableArray alloc] init];

    // TODO: finish implementation
}

@end
