//
//  STInfoLayer.m
//  Game
//
//  Created by Lukas Seglias on 26.03.13.
//  Copyright 2013 Ilija Tovilo. All rights reserved.
//

#import "STInfoLayer.h"
#import "STStartLayer.h"
#import "CCDirector+Transitions.h"
#import "CCControlExtension.h"

#define kScreenPadding 10

@implementation STInfoLayer
{}

#pragma mark -
#pragma mark Initialise
- (void)setUp {
    [super setUp];
    
    NSDictionary *root = [NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle] pathForResource:kAboutPlistFile ofType:@""]];
        
    NSMutableString *developers = [[NSMutableString alloc] initWithString:@"by\n"];
    for(NSString *developer in [root valueForKey:kDeveloperKey]) {
        [developers appendString:developer];
        [developers appendString:@"\n"];
    }
    
    CCMenuItemImage *title = [CCMenuItemImage itemWithNormalImage:@"Title.png" selectedImage:@"Title.png"];
    title.scale = 0.8f;
    
    CCMenu *menu = [CCMenu menuWithItems:
                    title,
                    [CCMenuItemFont itemWithString:developers],
                    nil];
    
    [menu alignItemsVerticallyWithPadding:20];
    
    [self addChild:menu];
    
    // Menu
    CCControlButton *menuButton = [CCControlButton buttonWithTitle:@"Menu" fontName:@"Helvetica" fontSize:20];
    [menuButton setAdjustBackgroundImage:NO];
    [menuButton addTarget:self action:@selector(menu:) forControlEvents:CCControlEventTouchUpInside];
    menuButton.position = ccp([[CCDirector sharedDirector] winSize].width / 2, kScreenPadding);
    [self addChild:menuButton];
    
    // TODO: add menu-menuitem
    // TODO: add social media menuitems
}

#pragma mark -
#pragma mark Switch Scene
- (IBAction)menu:(id)sender {
    [[CCDirector sharedDirector] replaceScene:[STStartLayer scene]
                          withTransitionClass:[CCTransitionFade class]
                                     duration:0.5];
}

@end
