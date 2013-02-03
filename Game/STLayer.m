//
//  SKLayer.m
//  Game
//
//  Created by Ilija Tovilo on 2/3/13.
//  Copyright 2013 Ilija Tovilo. All rights reserved.
//

#import "STLayer.h"


@implementation STLayer
static Class _sceneClass;

+ (STScene *)scene {
    STScene *scene = [self node];
    
    STLayer *layer = [self node];
    [scene addChild: layer];
    
    // return the scene
    return scene;
}

- (id)init
{
    self = [super init];
    if (self) {
        [self setUp];
    }
    return self;
}

- (void)dealloc {
    [self tearDown];
}

- (void)setUp {

}

- (void)tearDown {

}

- (void)sceneWasAdded:(STScene *)scene {}
- (void)sceneWasRemoved:(STScene *)scene {}

+ (void)setSceneClass:(Class)sceneClass {
    if (sceneClass) {
        _sceneClass = sceneClass;
    }
}

+ (Class)sceneClass {
    if (!_sceneClass) {
        return [STScene class];
    }
    
    return _sceneClass;
}

@end
