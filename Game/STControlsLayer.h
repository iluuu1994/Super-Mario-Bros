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
#import "STControlsDelegate.h"

#define kjoystickImageName @"pd_dpad.png"

@interface STControlsLayer : STLayer
{}

#pragma mark -
#pragma mark Properties
@property (strong) id <STControlsDelegate> delegate;
@property (strong) SneakyJoystick *joystick;

- (id)initWithDelegate:(id <STControlsDelegate>)delegate;

+ (id)layerWithDelegate:(id <STControlsDelegate>)delegate;

- (void)setUpWithDelegate:(id <STControlsDelegate>)delegate;

- (void)update:(ccTime)delta;


@end
