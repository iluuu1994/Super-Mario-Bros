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

#define kScreenPadding 5

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
    settings.position = ccp(settings.contentSize.width * 2 + kScreenPadding,
                            settings.contentSize.width * 2 + kScreenPadding);
    settings.adjustBackgroundImage = NO;
    [self addChild:settings];
    
    CCControlButton *about = [CCControlButton buttonWithBackgroundSprite:[CCScale9Sprite spriteWithFile:@"about.png"]];
    about.position = ccp([[CCDirector sharedDirector] winSize].width - settings.contentSize.width - kScreenPadding,
                            settings.contentSize.width / 2 + kScreenPadding);
    about.adjustBackgroundImage = NO;
    [self addChild:about];
}

- (IBAction)start:(id)sender {
    
    [[CCDirector sharedDirector] replaceScene:[STInfoLayer scene]
                          withTransitionClass:[CCTransitionFade class]
                                     duration:0.5];
    
    //STLevelResultLayer *resultLayer = [STLevelResultLayer layerWithWorldId:0 levelId:0 time:[NSDate date] score:234 success:YES];
    
    //[[CCDirector sharedDirector] replaceScene: [resultLayer scene]];
}

@end
