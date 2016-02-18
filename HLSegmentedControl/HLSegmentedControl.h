//
//  HLSegmentedControl.h
//  HLSegmentedControl
//
//  Created by Lei Huang on 9/13/14.
//  Copyright (c) 2014 Lei Huang. All rights reserved.
//

#import <UIKit/UIKit.h>


@class HLSegmentedControl;

typedef enum : NSUInteger
{
    HLSegmentedControlModeButtonOnly,
    HLSegmentedControlModeImageOnly,
    HLSegmentedControlModeImageUpButtonDown,
    HLSegmentedControlMOdeImageLiftButtonRight
    
} HLSegmentedControlMode;

@protocol HLSegmentedDelegate <NSObject>

@optional
- (void)segmentedViewController:(HLSegmentedControl *)segmentedControl touchedAtIndex:(NSUInteger)index;

@end

@interface HLSegmentedControl : UIView

@property (nonatomic, assign) id<HLSegmentedDelegate> delegate;

/**
 */
@property (nonatomic, strong) NSArray *buttonsArray;

/**
 */
@property (nonatomic, strong) UIImage *backgroundImage;

/**
 */
@property (nonatomic, strong) UIImage *separatorImage;

/**
 */
@property (nonatomic, assign) UIEdgeInsets contentEdgeInsets;

/**
 */
@property (nonatomic, assign) NSInteger selectedIndex;

/**
 */
@property (nonatomic, assign) HLSegmentedControlMode segmentedControlMode;

- (id)initWithFrame:(CGRect)frame titleArray:(NSArray *)titleArr imageArray:(NSArray *)imageArr segmentedControlMode:(HLSegmentedControlMode)mode;

@end
