//
//  SKScene.m
//  Game
//
//  Created by Ilija Tovilo on 2/3/13.
//  Copyright 2013 Ilija Tovilo. All rights reserved.
//

#import "STScene.h"
#import "STLayer.h"

@implementation STScene

- (void)onEnter {
    [super onEnter];
    
    for (STLayer *layer in [self children]) {
        if ([layer respondsToSelector:@selector(sceneWasAdded:)]) {
            [layer sceneWasAdded:self];
        }
    }
}

- (void)onExit {
    [super onExit];
    
    for (STLayer *layer in [self children]) {
        if ([layer respondsToSelector:@selector(sceneWasRemoved:)]) {
            [layer sceneWasRemoved:self];
        }
    }
}

@end
