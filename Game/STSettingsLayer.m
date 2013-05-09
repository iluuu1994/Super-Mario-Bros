
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
    CCLabelTTF *title = [CCLabelTTF labelWithString:@"Settings" fontName:kTitleFontName fontSize:kTitleFontSize];
    [title setColor:kTitleTextColor];
    title.position = ccp(winSize.width / 2, winSize.height - title.contentSize.height - kPadding);
    [self addChild:title];
    
    // Music Switch
    CCControlSwitch *music = [CCControlSwitch switchWithMaskSprite:[CCSprite spriteWithFile:kSwitchMaskImg]
                                                          onSprite:[CCSprite spriteWithFile:kSwitchOnImg]
                                                         offSprite:[CCSprite spriteWithFile:kSwitchOffImg]
                                                       thumbSprite:[CCSprite spriteWithFile:kSwitchThumbImg]];
    [music addTarget:self action:@selector(musicOnOff:) forControlEvents:CCControlEventValueChanged];
    [music setOn:[[STConfigurationManager sharedInstance] isMusicOn]];
    music.position = ccp(winSize.width / 2 + music.contentSize.width / 2 + kPadding,
                         winSize.height / 2);
    [self addChild:music];
    
    // Music Label
    CCLabelTTF *musicLabel = [CCLabelTTF labelWithString:@"Music" fontName:kTextFontName fontSize:kTextFontSize];
    [musicLabel setColor:kTextColor];
    musicLabel.position = ccp(winSize.width / 2 - musicLabel.contentSize.width / 2 - kPadding,
                              winSize.height / 2);
    [self addChild:musicLabel];
    
    // Tone Switch
    CCControlSwitch *tone = [CCControlSwitch switchWithMaskSprite:[CCSprite spriteWithFile:kSwitchMaskImg]
                                                          onSprite:[CCSprite spriteWithFile:kSwitchOnImg]
                                                         offSprite:[CCSprite spriteWithFile:kSwitchOffImg]
                                                       thumbSprite:[CCSprite spriteWithFile:kSwitchThumbImg]];
    [tone addTarget:self action:@selector(toneOnOff:) forControlEvents:CCControlEventValueChanged];
    [tone setOn:[[STConfigurationManager sharedInstance] isToneOn]];
    tone.position = ccp(winSize.width / 2 + music.contentSize.width / 2 + kPadding,
                        winSize.height / 2 - tone.contentSize.height - kPadding);
    [self addChild:tone];
    
    // Tone Label
    CCLabelTTF *toneLabel = [CCLabelTTF labelWithString:@"Tone" fontName:kTextFontName fontSize:kTextFontSize];
    [toneLabel setColor:kTextColor];
    toneLabel.position = ccp(winSize.width / 2 - musicLabel.contentSize.width / 2 - kPadding,
                             winSize.height / 2 - tone.contentSize.height - kPadding);
    [self addChild:toneLabel];
    
    // Menu Button
    CCLabelTTF *menuLabel = [CCLabelTTF labelWithString:@"Menu" fontName:kButtonFontName fontSize:kButtonFontSize];
    [menuLabel setColor:kButtonTextColor];
    CCControlButton *menuButton = [CCControlButton buttonWithLabel:menuLabel
                                                  backgroundSprite:[CCScale9Sprite spriteWithFile:kButtonImageName]];
    [menuButton addTarget:self action:@selector(menu:) forControlEvents:CCControlEventTouchUpInside];
    menuButton.position = ccp(winSize.width / 2, menuButton.contentSize.height / 2 + kPadding);
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
    [[STConfigurationManager sharedInstance] setMusicOn:[(CCControlSwitch *)sender isOn]];
}

- (IBAction)toneOnOff:(id)sender {
    [[STConfigurationManager sharedInstance] setToneOn:[(CCControlSwitch *)sender isOn]];
}

@end
