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
#import "STLevelResultLayer.h"
#import "STInfoLayer.h"
#import "STSettingsLayer.h"

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
    
    // Settings
    CCControlButton *settings = [CCControlButton buttonWithBackgroundSprite:[CCScale9Sprite spriteWithFile:@"preferences.png"]];
    settings.adjustBackgroundImage = NO;
    [settings addTarget:self action:@selector(preferences:) forControlEvents:CCControlEventTouchUpInside];
    settings.position = ccp(settings.contentSize.width / 2 + kScreenPadding,
                            settings.contentSize.height / 2 + kScreenPadding);
    [self addChild:settings];

    // About
    CCControlButton *about = [CCControlButton buttonWithBackgroundSprite:[CCScale9Sprite spriteWithFile:@"about.png"]];
    about.adjustBackgroundImage = NO;
    [about addTarget:self action:@selector(info:) forControlEvents:CCControlEventTouchUpInside];
    about.position = ccp([[CCDirector sharedDirector] winSize].width - about.contentSize.width / 2 - kScreenPadding,
                            about.contentSize.height / 2 + kScreenPadding);
    [self addChild:about];
}

#pragma mark -
#pragma mark Switch Scene
- (IBAction)info:(id)sender {
    [[CCDirector sharedDirector] replaceScene:[STInfoLayer scene]
                          withTransitionClass:[CCTransitionFade class]
                                     duration:0.5];
}

- (IBAction)preferences:(id)sender {
    [[CCDirector sharedDirector] replaceScene:[STSettingsLayer scene]
                          withTransitionClass:[CCTransitionFade class]
                                     duration:0.5];
}

- (IBAction)start:(id)sender {
    [[CCDirector sharedDirector] replaceScene: [STChooseWorldLayer scene]
                          withTransitionClass:[CCTransitionFade class]
                                     duration:0.5];
}

@end
