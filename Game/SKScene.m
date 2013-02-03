//
//  SKScene.m
//  Game
//
//  Created by Ilija Tovilo on 2/3/13.
//  Copyright 2013 Ilija Tovilo. All rights reserved.
//

#import "SKScene.h"
#import "SKLayer.h"

@implementation SKScene

- (void)onEnter {
    [super onEnter];
    
    for (SKLayer *layer in [self children]) {
        if ([layer respondsToSelector:@selector(sceneWasAdded:)]) {
            [layer sceneWasAdded:self];
        }
    }
}

- (void)onExit {
    [super onExit];
    
    for (SKLayer *layer in [self children]) {
        if ([layer respondsToSelector:@selector(sceneWasRemoved:)]) {
            [layer sceneWasRemoved:self];
        }
    }
}

@end
