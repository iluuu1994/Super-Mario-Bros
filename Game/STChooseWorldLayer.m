//
//  STChooseWorldLayer.m
//  Game
//
//  Created by Lukas Seglias on 26.03.13.
//  Copyright 2013 Ilija Tovilo. All rights reserved.
//

#import "CCDirector+Transitions.h"
#import "CCControlExtension.h"
#import "STChooseWorldLayer.h"
#import "STChooseLevelLayer.h"
#import "STWorldsConstants.h"
#import "STWorldInfoReader.h"
#import "STStartLayer.h"
#import "STLevelLayer.h"
#import "CCScrollLayer.h"
#import "STLayoutConstants.h"

@implementation STChooseWorldLayer
{}

#pragma mark -
#pragma mark Initialise

- (void)setUp {
    [super setUp];
    
    CGSize winSize = [[CCDirector sharedDirector] winSize];
    
    // first world is always unlocked
    [[STWorldInfoReader sharedInstance] unlockWorldID:0];
    
    // Scene Title
    CCLabelTTF *title = [CCLabelTTF labelWithString:@"Worlds" fontName:kTitleFontName fontSize:kTitleFontSize];
    [title setColor:kTitleTextColor];
    title.position = ccp(winSize.width / 2, winSize.height - title.contentSize.height - kPadding);
    [self addChild:title];

    NSMutableArray *pages = [[NSMutableArray alloc] init];
    
    for(NSDictionary *world in [[STWorldInfoReader sharedInstance] worlds]) {
        CCLayer *page = [[CCLayer alloc] init];
        
        CCSprite *worldIcon = [CCSprite spriteWithFile:[world valueForKey:kWorldIconKey]];
        CCSprite *worldIconSelected = [CCSprite spriteWithFile:[world valueForKey:kWorldIconKey]];
        
        CCMenuItemSprite *worldItem = [CCMenuItemSprite itemWithNormalSprite:worldIcon
                                                          selectedSprite:worldIconSelected
                                                                  target:self
                                                                selector:@selector(world:)];
        [worldItem setUserObject:world];
        
        // World Title
        CCLabelTTF *tlabel = [CCLabelTTF labelWithString:[world valueForKey:kWorldNameKey] fontName:kTextFontName fontSize:20];
        [tlabel setColor:kTextColor];
        CCMenuItemLabel *title = [CCMenuItemLabel itemWithLabel:tlabel target:self selector:@selector(world:)];
        [title setUserObject:world];
        
        // World Item Menu
        CCMenu *menu = [CCMenu menuWithItems: worldItem, title, nil];
        [menu alignItemsVerticallyWithPadding:20];
        menu.position = ccp(winSize.width / 2, winSize.height / 2);
        
        // If the world is locked
        if(![[STWorldInfoReader sharedInstance] isUnlockedWorldID:[[world valueForKey:kWorldIDKey] shortValue]]) {
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
    CCLabelTTF *menuLabel = [CCLabelTTF labelWithString:@"Menu" fontName:kButtonFontName fontSize:kButtonFontSize];
    [menuLabel setColor:kButtonTextColor];
    CCControlButton *menuButton = [CCControlButton buttonWithLabel:menuLabel
                                                  backgroundSprite:[CCScale9Sprite spriteWithFile:kButtonImageName]];
    [menuButton addTarget:self action:@selector(menu:) forControlEvents:CCControlEventTouchUpInside];
    menuButton.position = ccp(menuButton.contentSize.width / 2 + kPadding, menuButton.contentSize.height / 2 + kPadding);
    [self addChild:menuButton];
}

#pragma mark -
#pragma mark Select World

/**
 * When the user selected a world this method is called. Displays an overview 
 * of all levels within the selected world. 
 * @param sender - the sender of this message. The STChooseWorldLayer.
 * @return an IBAction.
 */
- (IBAction)world:(id)sender {
    NSDictionary *world = [sender userObject];
    NSNumber *worldID = [world valueForKey:kWorldIDKey];
    BOOL isUnlocked = [[STWorldInfoReader sharedInstance] isUnlockedWorldID:[worldID shortValue]];
    
    if(isUnlocked) {
        STLevelLayer *level = [STChooseLevelLayer layerWithWorldID:[worldID shortValue]];
        STScene *scene = [level scene];
        [[CCDirector sharedDirector] replaceScene:scene
                              withTransitionClass:[CCTransitionFade class]
                                         duration:0.5];
    }
}

#pragma mark -
#pragma mark Switch Scene

/**
 * When the user wants to go back to the main-menu this method is called.
 * @param sender - the sender of this message. The STChooseWorldLayer.
 * @return an IBAction.
 */
- (IBAction)menu:(id)sender {
    [[CCDirector sharedDirector] replaceScene:[STStartLayer scene]
                          withTransitionClass:[CCTransitionFade class]
                                     duration:0.5];
}

@end
