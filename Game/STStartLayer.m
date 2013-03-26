//
//  STStartLayer.m
//  Game
//
//  Created by Lukas Seglias on 26.03.13.
//  Copyright 2013 Ilija Tovilo. All rights reserved.
//

#import "STStartLayer.h"


@implementation STStartLayer
{}

#pragma mark -
#pragma mark Initialise
- (void)setUp {
    [super setUp];
    
    CCMenuItemImage *title = [CCMenuItemImage itemWithNormalImage:@"Title.png" selectedImage:@"Title.png"];
    title.scale = 0.8f;
    
    CCMenu *menu = [CCMenu menuWithItems:
                    title,
                    [CCMenuItemFont itemWithString:@"Play!" target:self selector:@selector(start:)],
                    nil];
    
    // TODO: add settings-menuitem
    // TODO: add info-menuitem
    
    [menu alignItemsVerticallyWithPadding:20];
    
    [self addChild:menu];
}

- (IBAction)start:(id)sender {
    // TODO: transition
    [[CCDirector sharedDirector] replaceScene:[STChooseWorldLayer scene]];
}

@end
