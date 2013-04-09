//
//  STStartLayer.m
//  Game
//
//  Created by Lukas Seglias on 26.03.13.
//  Copyright 2013 Ilija Tovilo. All rights reserved.
//

#import "STStartLayer.h"
#import "CCDirector+Transitions.h"
#import "CCControlExtension.h"

#define kScreenPadding 10

@implementation STStartLayer
{}

#pragma mark -
#pragma mark Initialise
- (void)setUp {
    [super setUp];
    
    // Menu
    CCMenuItemImage *title = [CCMenuItemImage itemWithNormalImage:@"Title.png" selectedImage:@"Title.png"];
    title.scale = 0.8f;
    CCMenu *menu = [CCMenu menuWithItems:
                    title,
                    [CCMenuItemFont itemWithString:@"Play!" target:self selector:@selector(start:)],
                    nil];
    [menu alignItemsVerticallyWithPadding:20];
    [self addChild:menu];
    
    CCControlButton *settings = [CCControlButton buttonWithBackgroundSprite:[CCScale9Sprite spriteWithFile:@"preferences.png"]];
    settings.position = ccp([CCDirector sharedDirector].winSize.width - settings.contentSize.width,
                            settings.contentSize.width + kScreenPadding);
    settings.adjustBackgroundImage = NO;
    [self addChild:settings];
}

- (IBAction)start:(id)sender {
    [[CCDirector sharedDirector] replaceScene:[STChooseWorldLayer scene]
                          withTransitionClass:[CCTransitionFade class]
                                     duration:0.5];
}

@end
