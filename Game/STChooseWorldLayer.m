//
//  STChooseWorldLayer.m
//  Game
//
//  Created by Lukas Seglias on 26.03.13.
//  Copyright 2013 Ilija Tovilo. All rights reserved.
//

#import "STChooseWorldLayer.h"
#import "NSBundle+Resources.h"
#import "CCDirector+Transitions.h"
#import "CCControlExtension.h"
#import "WorldsConstrants.h"
#import "LayerConstants.h"

@implementation STChooseWorldLayer
{}

#pragma mark -
#pragma mark Initialise
- (void)setUp {
    [super setUp];
    
    NSArray *root = [NSDictionary dictionaryWithContentsOfFile:[NSBundle pathForResource:kWorldsFile]];
    
    CGSize winSize = [[CCDirector sharedDirector] winSize];

    NSMutableArray *pages = [[NSMutableArray alloc] init];
    
    for(NSDictionary *world in [root valueForKey:kWorldsKey]) {
        CCLayer *page = [[CCLayer alloc] init];
        
        CCSprite *worldIcon = [CCSprite spriteWithFile:[world valueForKey:kWorldIconKey]];
        CCSprite *worldIconSelected = [CCSprite spriteWithFile:[world valueForKey:kWorldIconKey]];
        
        CCMenuItemSprite *worldItem = [CCMenuItemSprite itemWithNormalSprite:worldIcon
                                                          selectedSprite:worldIconSelected
                                                                  target:self
                                                                selector:@selector(world:)];
        [worldItem setUserObject:world];
        
        // World Title
        CCLabelTTF *tlabel = [CCLabelTTF labelWithString:[world valueForKey:kWorldNameKey] fontName:@"Helvetica" fontSize:20];
        CCMenuItemLabel *title = [CCMenuItemLabel itemWithLabel:tlabel target:self selector:@selector(world:)];
        [title setUserObject:world];
        
        // World Item Menu
        CCMenu *menu = [CCMenu menuWithItems: worldItem, title, nil];
        [menu alignItemsVerticallyWithPadding:20];
        menu.position = ccp(winSize.width / 2, winSize.height / 2);
        
        if([[world valueForKey:kWorldIsLockedKey] boolValue]) {
            // Locked Icon
            CCMenuItemSprite *lock = [CCMenuItemSprite itemWithNormalSprite:[CCSprite spriteWithFile:kLockIcon]
                                                             selectedSprite:[CCSprite spriteWithFile:kLockIcon]];
            lock.position = ccp(worldItem.position.x + worldItem.contentSize.width / 2, worldItem.position.y);
            [worldItem addChild:lock];
        }
        
        [page addChild:menu];
        [pages addObject:page];
    }
    
    CCScrollLayer *scroller = [[CCScrollLayer alloc] initWithLayers:pages widthOffset:winSize.width / 1.5];
    [self addChild:scroller];
    
    // Back to Menu Button
    CCControlButton *menuButton = [CCControlButton buttonWithTitle:@"Back" fontName:@"Helvetica" fontSize:30];
    [menuButton setAdjustBackgroundImage:NO];
    [menuButton addTarget:self action:@selector(menu:) forControlEvents:CCControlEventTouchUpInside];
    menuButton.position = ccp(menuButton.contentSize.width / 2 + kScreenPadding, menuButton.contentSize.height / 2 + kScreenPadding);
    [self addChild:menuButton];
}

#pragma mark -
#pragma mark Select World
- (IBAction)world:(id)sender {
    NSDictionary *world = [sender userObject];
    NSNumber *worldID = [world valueForKey:kWorldIDKey];
    BOOL isLocked = [[world valueForKey:kWorldIsLockedKey] boolValue];
    
    if(!isLocked) {
        STScene *scene = [STChooseLevelLayer sceneWithWorldID:[worldID shortValue]];
        [[CCDirector sharedDirector] replaceScene: scene
                              withTransitionClass:[CCTransitionFade class]
                                         duration:0.5];
    }
}

#pragma mark -
#pragma mark Switch Scene
- (IBAction)menu:(id)sender {
    [[CCDirector sharedDirector] replaceScene:[STStartLayer scene]
                          withTransitionClass:[CCTransitionFade class]
                                     duration:0.5];
}

@end
