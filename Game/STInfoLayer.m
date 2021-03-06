//
//  STInfoLayer.m
//  Game
//
//  Created by Lukas Seglias on 26.03.13.
//  Copyright 2013 Ilija Tovilo. All rights reserved.
//

#import "STInfoLayer.h"
#import "CCDirector+Transitions.h"
#import "NSBundle+Resources.h"
#import "CCControlExtension.h"
#import "STAboutConstants.h"
#import "STLayoutConstants.h"
#import "STStartLayer.h"

@implementation STInfoLayer
{}

#pragma mark -
#pragma mark Initialise

- (void)setUp {
    [super setUp];
    
    CGSize winSize = [[CCDirector sharedDirector] winSize];
    
    NSArray *root = [NSDictionary dictionaryWithContentsOfFile:[NSBundle pathForResource:kAboutPlistFile]];
    
    // Scene Title
    CCMenuItemImage *title = [CCMenuItemImage itemWithNormalImage:kTitleImageName selectedImage:kTitleImageName];
    title.scale = 0.8f;
    title.position = ccp(winSize.width / 2, winSize.height - title.contentSize.height - kPadding);
    [self addChild:title];
    
    // Developer Information
    NSMutableString *developers = [[NSMutableString alloc] initWithString:@"by\n"];
    for(NSString *developer in [root valueForKey:kDeveloperKey]) {
        [developers appendString:developer];
        [developers appendString:@"\n"];
    }
    CCLabelTTF *developerLabel = [CCLabelTTF labelWithString:developers fontName:kTextFontName fontSize:kTextFontSize];
    [developerLabel setColor:kTextColor];
    developerLabel.position = ccp(winSize.width / 2, winSize.height / 2);
    [self addChild:developerLabel];
    
    // Menu Button
    CCLabelTTF *menuLabel = [CCLabelTTF labelWithString:@"Menu" fontName:kButtonFontName fontSize:kButtonFontSize];
    [menuLabel setColor:kButtonTextColor];
    CCControlButton *menuButton = [CCControlButton buttonWithLabel:menuLabel
                                                  backgroundSprite:[CCScale9Sprite spriteWithFile:kButtonImageName]];
    [menuButton addTarget:self action:@selector(menu:) forControlEvents:CCControlEventTouchUpInside];
    menuButton.position = ccp(winSize.width / 2, menuButton.contentSize.height / 2 + kPadding);
    [self addChild:menuButton];
    
    int counter = 0;
    
    // Social Media Buttons
    for(NSDictionary *socialMedia in [root valueForKey:kSocialMediaKey]) {
        NSString *iconFileName = [socialMedia valueForKey:kSocialMediaIconKey];
        NSString *url = [socialMedia valueForKey:kSocialMediaUrlKey];
        
        CCControlButton *socialMediaButton = [CCControlButton buttonWithBackgroundSprite:[CCScale9Sprite spriteWithFile:iconFileName]];
        socialMediaButton.adjustBackgroundImage = NO;
        [socialMediaButton addTarget:self action:@selector(socialMedia:) forControlEvents:CCControlEventTouchUpInside];
        CGSize imageSize = socialMediaButton.contentSize;
        socialMediaButton.position = ccp(winSize.width - imageSize.width / 2 - kPadding,
                                         imageSize.height / 2 + kPadding + counter * (imageSize.height + kPadding));
        [socialMediaButton setUserObject:url];

        counter++;
        
        [self addChild:socialMediaButton];
    }
}

#pragma mark -
#pragma mark Switch Scene

/**
 * When the user wants to go back to the main-menu this message is called. Switches to the main-menu.
 * @param sender - the sender of this message. The STInfoLayer.
 * @return an IBAction.
 */
- (IBAction)menu:(id)sender {
    [[CCDirector sharedDirector] replaceScene:[STStartLayer scene]
                          withTransitionClass:[CCTransitionFade class]
                                     duration:0.5];
}

#pragma mark -
#pragma mark Social Media Button

/**
 * When the user presses on a social media icon this message is called. Opens the url of
 * the associated social media website in a webbrowser. 
 * @param sender - the sender of this message. The STInfoLayer.
 * @return an IBAction.
 */
- (IBAction)socialMedia:(id)sender {
    NSURL *url = [[NSURL alloc] initWithString:[sender userObject]];
    [[UIApplication sharedApplication] openURL:url];
}

@end
