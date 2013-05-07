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

@implementation STStartLayer
{}

#pragma mark -
#pragma mark Initialise
- (void)setUp {
    [super setUp];
    
    CGSize winSize = [[CCDirector sharedDirector] winSize];
    
    // TODO: static names of image
    // Scene Title
    CCMenuItemImage *title = [CCMenuItemImage itemWithNormalImage:kTitleImageName selectedImage:kTitleImageName];
    title.scale = 0.8f;
    title.position = ccp(winSize.width / 2, winSize.height - title.contentSize.height - kPadding);
    [self addChild:title];
    
    // Play
    CCControlButton *start = [CCControlButton buttonWithLabel:
                              [CCLabelTTF labelWithString:@"Play!" fontName:kButtonFontName fontSize:kButtonFontSize] backgroundSprite:[CCScale9Sprite spriteWithFile:kButtonImageName]];
    [start addTarget:self action:@selector(start:) forControlEvents:CCControlEventTouchUpInside];
    start.position = ccp(winSize.width / 2, winSize.height / 2);
    [self addChild:start];
    
    // Settings
    CCControlButton *settings = [CCControlButton buttonWithBackgroundSprite:[CCScale9Sprite spriteWithFile:@"preferences.png"]];
    settings.adjustBackgroundImage = NO;
    [settings addTarget:self action:@selector(preferences:) forControlEvents:CCControlEventTouchUpInside];
    settings.position = ccp(settings.contentSize.width / 2 + kPadding,
                            settings.contentSize.height / 2 + kPadding);
    [self addChild:settings];

    // About
    CCControlButton *about = [CCControlButton buttonWithBackgroundSprite:[CCScale9Sprite spriteWithFile:@"about.png"]];
    about.adjustBackgroundImage = NO;
    [about addTarget:self action:@selector(info:) forControlEvents:CCControlEventTouchUpInside];
    about.position = ccp(winSize.width - about.contentSize.width / 2 - kPadding, about.contentSize.height / 2 + kPadding);
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
