
//
//  STSettingsLayer.m
//  Game
//
//  Created by Lukas Seglias on 23.04.13.
//  Copyright 2013 Ilija Tovilo. All rights reserved.
//

#import "STSettingsLayer.h"
#import "CCDirector+Transitions.h"
#import "CCControlExtension.h"
#import "STStartLayer.h"

@implementation STSettingsLayer
{}

#pragma mark -
#pragma mark Initialise
- (void)setUp {
    [super setUp];
    
    CCMenuItemImage *title = [CCMenuItemImage itemWithNormalImage:@"Title.png" selectedImage:@"Title.png"];
    title.scale = 0.8f;
    
    CCControlSwitch *music = [CCControlSwitch switchWithMaskSprite:[CCSprite spriteWithFile:@"about.png"] onSprite:[CCSprite spriteWithFile:@"twitter.png"] offSprite:[CCSprite spriteWithFile:@"facebook.png"] thumbSprite:[CCSprite spriteWithFile:@"about.png"]];
    music.position = ccp(100, 150);
    [music addTarget:self action:@selector(musicOnOff:) forControlEvents:CCControlEventTouchUpInside];
    
    CCMenu *menu = [CCMenu menuWithItems:
                    title,
                    nil];
    
    [self addChild:music];
    
    [menu alignItemsVerticallyWithPadding:20];
    
    [self addChild:menu];
    
    // Menu
    //CCControlButton *menuButton = [CCControlButton buttonWithTitle:@"Menu" fontName:@"Helvetica" fontSize:20];
    //[menuButton setAdjustBackgroundImage:NO];
    //[menuButton addTarget:self action:@selector(menu:) forControlEvents:CCControlEventTouchUpInside];
    //menuButton.position = ccp([[CCDirector sharedDirector] winSize].width / 2, 10);
    //[self addChild:menuButton];
}

#pragma mark -
#pragma mark Switch Scene
- (IBAction)menu:(id)sender {
    [[CCDirector sharedDirector] replaceScene:[STStartLayer scene]
                          withTransitionClass:[CCTransitionFade class]
                                     duration:0.5];
}

#pragma mark -
#pragma mark Switch Settings
- (IBAction)musicOnOff:(id)sender {
    NSLog(@"test");
}

@end
