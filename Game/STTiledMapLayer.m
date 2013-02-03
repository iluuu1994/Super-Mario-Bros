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
        self.objectGroup = [self.map objectGroupNamed:@"objects"];
        
        [self addChild:self.map];
        
        for (NSDictionary *object in self.objectGroup.objects) {
            Class objectClass = NSClassFromString(object[@"type"]);
            CCNode *node = [objectClass node];
            [node setPosition:ccp([object[@"x"] intValue], [object[@"y"] intValue])];
            
            [self addChild:node];
        }
    }
    return self;
}

- (void)setUp {
    
}

+ (id)layerWithTiledMap:(NSString *)tiledMap {
    return [[self alloc] initWithTiledMap:tiledMap];
}

@end
