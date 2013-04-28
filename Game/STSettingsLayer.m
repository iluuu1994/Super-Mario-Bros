
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
    
    CGSize winSize = [[CCDirector sharedDirector] winSize];
    
    // Scene Title
    CCMenuItemImage *title = [CCMenuItemImage itemWithNormalImage:@"Title.png" selectedImage:@"Title.png"];
    title.scale = 0.8f;
    title.position = ccp(winSize.width / 2, winSize.height - title.contentSize.height - kScreenPadding);
    [self addChild:title];
    
    // Music Switch
    CCControlSwitch *music = [CCControlSwitch switchWithMaskSprite:[CCSprite spriteWithFile:kSwitchMaskImg]
                                                          onSprite:[CCSprite spriteWithFile:kSwitchOnImg]
                                                         offSprite:[CCSprite spriteWithFile:kSwitchOffImg]
                                                       thumbSprite:[CCSprite spriteWithFile:kSwitchThumbImg]];
    [music addTarget:self action:@selector(musicOnOff:) forControlEvents:CCControlEventValueChanged];
    [music setOn:[[STConfigurationManager sharedInstance] musicOn]];
    music.position = ccp(winSize.width / 2 + music.contentSize.width / 2 + kLabelSwitchPadding,
                         winSize.height / 2);
    [self addChild:music];
    
    // Music Label
    CCLabelTTF *musicLabel = [CCLabelTTF labelWithString:@"Music" fontName:@"Helvetica" fontSize:20];
    NSLog(@"%f", musicLabel.contentSize.width);
    NSLog(@"%f", musicLabel.contentSize.height);
    musicLabel.position = ccp(winSize.width / 2 - musicLabel.contentSize.width / 2 - kLabelSwitchPadding,
                              winSize.height / 2);
    [self addChild:musicLabel];
    
    // Tone Switch
    CCControlSwitch *tone = [CCControlSwitch switchWithMaskSprite:[CCSprite spriteWithFile:kSwitchMaskImg]
                                                          onSprite:[CCSprite spriteWithFile:kSwitchOnImg]
                                                         offSprite:[CCSprite spriteWithFile:kSwitchOffImg]
                                                       thumbSprite:[CCSprite spriteWithFile:kSwitchThumbImg]];
    [tone addTarget:self action:@selector(toneOnOff:) forControlEvents:CCControlEventValueChanged];
    [tone setOn:[[STConfigurationManager sharedInstance] toneOn]];
    tone.position = ccp(winSize.width / 2 + music.contentSize.width / 2 + kLabelSwitchPadding,
                        winSize.height / 2 - tone.contentSize.height - kLabelSwitchPadding);
    [self addChild:tone];
    
    // Tone Label
    CCLabelTTF *toneLabel = [CCLabelTTF labelWithString:@"Tone" fontName:@"Helvetica" fontSize:20];
    toneLabel.position = ccp(winSize.width / 2 - musicLabel.contentSize.width / 2 - kLabelSwitchPadding,
                             winSize.height / 2 - tone.contentSize.height - kLabelSwitchPadding);
    [self addChild:toneLabel];
    
    // Menu Button
    CCControlButton *menuButton = [CCControlButton buttonWithTitle:@"Menu" fontName:@"Helvetica" fontSize:30];
    [menuButton setAdjustBackgroundImage:NO];
    [menuButton addTarget:self action:@selector(menu:) forControlEvents:CCControlEventTouchUpInside];
    menuButton.position = ccp([[CCDirector sharedDirector] winSize].width / 2, menuButton.contentSize.height / 2 + kScreenPadding);
    [self addChild:menuButton];
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
    [[STConfigurationManager sharedInstance] setMusicOn:![[STConfigurationManager sharedInstance] musicOn]];
}

- (IBAction)toneOnOff:(id)sender {
    [[STConfigurationManager sharedInstance] setToneOn:![[STConfigurationManager sharedInstance] toneOn]];
}

@end
