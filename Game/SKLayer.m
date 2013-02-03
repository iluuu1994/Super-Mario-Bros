//
//  SKLayer.m
//  Game
//
//  Created by Ilija Tovilo on 2/3/13.
//  Copyright 2013 Ilija Tovilo. All rights reserved.
//

#import "SKLayer.h"


@implementation SKLayer

+ (SKScene *)scene {
    SKScene *scene = [SKScene node];
    
    SKLayer *layer = [self node];
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

@end
