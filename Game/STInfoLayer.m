//
//  STInfoLayer.m
//  Game
//
//  Created by Lukas Seglias on 26.03.13.
//  Copyright 2013 Ilija Tovilo. All rights reserved.
//

#import "STInfoLayer.h"

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
    
    // TODO: add menu-menuitem
    // TODO: add social media menuitems
    
    [menu alignItemsVerticallyWithPadding:20];
    
    [self addChild:menu];
}

@end
