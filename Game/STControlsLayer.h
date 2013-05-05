//
//  STControlsLayer.h
//  Game
//
//  Created by Lukas Seglias on 30.04.13.
//  Copyright (c) 2013 Ilija Tovilo. All rights reserved.
//

#import "STLayer.h"
#import "SneakyJoystick.h"
#import "SneakyJoystickSkinnedBase.h"
#import "STLayerConstants.h"
#import "ColoredCircleSprite.h"
#import "ColoredSquareSprite.h"

#define kJoystickBaseColor ccc4(128, 128, 128, 128)
#define kJoystickColor ccc4(64, 64, 64, 128)
#define kJoystickBaseRadius 64
#define kJoystickRadius 32
#define kJoystickPosition ccp(64, 64)
#define kJoystickRect CGRectMake(0, 0, 128, 128)

@protocol STControlsDelegate <NSObject>

#pragma mark -
#pragma mark Buttons
- (IBAction)a:(id)sender;

- (IBAction)b:(id)sender;

- (IBAction)joystick:(id)sender delta:(ccTime)delta;

- (IBAction)pause:(id)sender;

@end

@interface STControlsLayer : STLayer
{}

#pragma mark -
#pragma mark Properties
@property (unsafe_unretained) id <STControlsDelegate> delegate;
@property (strong) SneakyJoystick *joystick;

- (id)initWithDelegate:(id <STControlsDelegate>)delegate;

+ (id)layerWithDelegate:(id <STControlsDelegate>)delegate;

- (void)setUpWithDelegate:(id <STControlsDelegate>)delegate;

- (void)update:(ccTime)delta;

@end

