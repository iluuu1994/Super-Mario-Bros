
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
#import "STConfigurationManager.h"
#import "STStartLayer.h"
#import "STLayoutConstants.h"

// Switch Images
#define kSwitchMaskImg @"switch-mask.png"
#define kSwitchOnImg @"switch-on.png"
#define kSwitchOffImg @"switch-off.png"
#define kSwitchThumbImg @"switch-thumb.png"

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

/**
 * Called when the user pressed the menu-button to return to the main menu.
 * @param sender - the sender of this message. The STSettingsLayer.
 * @return an IBAction.
 */
- (IBAction)menu:(id)sender {
    [[CCDirector sharedDirector] replaceScene:[STStartLayer scene]
                          withTransitionClass:[CCTransitionFade class]
                                     duration:0.5];
}

#pragma mark -
#pragma mark Switch Settings

/**
 * When the user wants to switch on/off the music this message is called.
 * @param sender - the sender of this message. The STSettingsLayer.
 * @return an IBAction.
 */
- (IBAction)musicOnOff:(id)sender {
    [[STConfigurationManager sharedInstance] setMusicOn:[(CCControlSwitch *)sender isOn]];
}

/**
 * When the user wants to switch on/off the tone this message is called.
 * @param sender - the sender of this message. The STSettingsLayer.
 * @return an IBAction.
 */
- (IBAction)toneOnOff:(id)sender {
    [[STConfigurationManager sharedInstance] setToneOn:[(CCControlSwitch *)sender isOn]];
}

@end
