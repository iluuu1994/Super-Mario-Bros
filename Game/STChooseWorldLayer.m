//
//  STChooseWorldLayer.m
//  Game
//
//  Created by Lukas Seglias on 26.03.13.
//  Copyright 2013 Ilija Tovilo. All rights reserved.
//

#import "STChooseWorldLayer.h"


@implementation STChooseWorldLayer
{}

#pragma mark -
#pragma mark Initialise
- (void)setUp {
    [super setUp];
    
    NSMutableArray *worlds = [[NSMutableArray alloc] init];
    
    NSArray *root = [[NSArray alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:kWorldsFile ofType:@""]];
    
    for(NSDictionary *world in [root valueForKey:kWorldsKey]) {
        CCLabelTTF *worldLabel = [[CCLabelTTF alloc] initWithString:[world valueForKey:kWorldIDKey] fontName:@"Helvetica" fontSize:10];
        CCMenuItemLabel *worldItem = [CCMenuItemLabel itemWithLabel:worldLabel];
        [worlds addObject:worldItem];
    }
    
    SlidingMenuGrid *worldGrid = [SlidingMenuGrid
                                 menuWithArray:worlds
                                 cols:kWorldSelectionColumnNumber
                                 rows:kWorldSelectionRowNumber
                                 position:CGPointMake(60.f, 280.f)
                                 padding:CGPointMake(90.f, 80.f)
                                 verticalPaging:YES];
    // klarklar!?
    
        
    [self addChild:worldGrid];
}

@end
