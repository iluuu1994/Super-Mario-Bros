//
//  STTiledMapScene.m
//  Game
//
//  Created by Ilija Tovilo on 2/3/13.
//  Copyright (c) 2013 Ilija Tovilo. All rights reserved.
//

#import "STTiledMapLayer.h"

@implementation STTiledMapLayer

- (id)initWithTiledMap:(NSString *)tiledMap
{
    self = [super init];
    if (self) {
        self.map = [CCTMXTiledMap tiledMapWithTMXFile:tiledMap];
        
        // TODO: Use Constants for the strings!!!!!
        self.objectGroup = [self.map objectGroupNamed:kEventsLayerKey];
        self.objectLayer = [self.map layerNamed:kObjectLayerKey];
        
        [self addChild:self.map];
        
        for (int x = 1; x < self.objectLayer.layerSize.width; x++) {
            for (int y = 1; y < self.objectLayer.layerSize.height; y++) {
                CCSprite *tile = [self.objectLayer tileAt:ccp(x, y)];
                NSDictionary *props = [self.map propertiesForGID:[self.objectLayer tileGIDAt:ccp(x, y)]];
                NSString *type = props[kTypeKey];
                if (type.length) {
                    Class objectClass = NSClassFromString(type);
                    CCNode *node = [objectClass node];
                    [node setPosition:tile.position];
                    
                    [self addChild:node];
                }
            }
        }
        
        /*
        NSDictionary *properties = [self.objectGroup objectNamed:kPlayerSpawnPointKey];
        NSLog(@"%@", properties);
        NSLog(@"%@ %@", properties[@"x"], properties[@"y"]);
         */
        
        /*
        NSDictionary *dict = [NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Worlds" ofType:@"plist"]];
        NSLog(@"%@", dict);
         */
        
        [self.objectLayer setVisible:NO];
    }
    return self;
}

- (void)setUp {
    
}

+ (id)layerWithTiledMap:(NSString *)tiledMap {
    return [[self alloc] initWithTiledMap:tiledMap];
}

@end
