//
//  HLSegmentedControl.m
//  HLSegmentedControl
//
//  Created by Lei Huang on 9/13/14.
//  Copyright (c) 2014 Lei Huang. All rights reserved.
//

#import "HLSegmentedControl.h"

#define kAKButtonSeparatorWidth 1.0

@interface HLSegmentedControl ()

/**
 Buttons target method
 */
- (void)segmentButtonPressed:(id)sender;

@end

@implementation HLSegmentedControl
{
    /**
     Array containing all the separators, for easy access
     */
    NSMutableArray *separatorsArray;
    
    /**
     Background Image view of the segmented control
     */
    UIImageView *backgroundImageView;
}


#pragma mark -
#pragma mark Init and Dealloc

- (id)initWithFrame:(CGRect)frame titleArray:(NSArray *)titleArr imageArray:(NSArray *)imageArr segmentedControlMode:(HLSegmentedControlMode)mode
{
    self = [super initWithFrame:frame];
    if (!self) return nil;
    
    [self setContentEdgeInsets:UIEdgeInsetsZero];
    [self setSelectedIndex:0];
    [self setSegmentedControlMode:mode];
    [self setButtonsArray:[NSMutableArray array]];
    separatorsArray = [NSMutableArray array];
    
    backgroundImageView = [[UIImageView alloc] initWithFrame:self.bounds];
    backgroundImageView.backgroundColor = [UIColor grayColor];
    [backgroundImageView setAutoresizingMask:UIViewAutoresizingFlexibleWidth];
    [self addSubview:backgroundImageView];
    
    
    //UIImage *backgroundImage = [[UIImage imageNamed:@"segmented-bg.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(10.0, 10.0, 10.0, 10.0)];
    //[self setBackgroundImage:backgroundImage];
    
    //[self setContentEdgeInsets:UIEdgeInsetsMake(2.0, 2.0, 3.0, 2.0)];
    [self setAutoresizingMask:UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleBottomMargin];
    
    
    
    NSMutableArray *buttonArr = [NSMutableArray array];
    for (int i = 0; i < [titleArr count]; i++)
    {
        UIButton *button = [[UIButton alloc] init];
        [button setBackgroundColor:[UIColor whiteColor]];
        
        if (mode != HLSegmentedControlModeImageOnly) {
            [button setTitle:titleArr[i] forState:UIControlStateNormal];
            [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [button setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
            
            [button setTitleShadowColor:[UIColor whiteColor] forState:UIControlStateNormal];
            //[button.titleLabel setShadowOffset:CGSizeMake(0.0, 1.0)];
            [button.titleLabel setFont:[UIFont systemFontOfSize:15]];//[UIFont fontWithName:@"HelveticaNeue-Bold" size:15.0]];
        }
        
        
        
        if (mode != HLSegmentedControlModeButtonOnly)
        {
            
            UIImage *buttonSocialImageNormal = [UIImage imageNamed:imageArr[i]];
            [button setImage:buttonSocialImageNormal forState:UIControlStateNormal];
            [button setImage:[UIImage imageNamed:[self getSelectedImageName:imageArr[i]]] forState:UIControlStateSelected];
            //[button setImage:buttonSocialImageNormal forState:UIControlStateHighlighted];
            //[button setImage:buttonSocialImageNormal forState:(UIControlStateHighlighted|UIControlStateSelected)];
        }
        
        switch (mode)
        {
            case HLSegmentedControlMOdeImageLiftButtonRight:
            {
                [button setTitleEdgeInsets:UIEdgeInsetsMake(0.0, 5.0, 0.0, 0.0)];
                
                
            }
                
                break;
            case HLSegmentedControlModeImageUpButtonDown:
            {
                [button setTitleEdgeInsets:UIEdgeInsetsMake(20, -30, 0.0, 0.0)];
                [button setImageEdgeInsets:UIEdgeInsetsMake(-20, 20, 0, 0)];
            }
                break;
            default:
                break;
        }
        
        [buttonArr addObject:button];
    }
    [self setButtonsArray:buttonArr];
    [self setNeedsDisplay];
    
    
    return self;
}

#pragma mark -
#pragma mark Layout

- (void)layoutSubviews
{
    // creating the content rect that will "contain" the button
    CGRect contentRect = UIEdgeInsetsInsetRect(self.bounds, _contentEdgeInsets);
    
    // for more clarity we create simple variables
    NSUInteger buttonsCount = [_buttonsArray count];
    NSUInteger separtorsNumber = buttonsCount - 1;
    
    // calculating the button prperties
    CGFloat separatorWidth = (_separatorImage != nil) ? _separatorImage.size.width : kAKButtonSeparatorWidth;
    CGFloat buttonWidth = floorf((CGRectGetWidth(contentRect) - (separtorsNumber * separatorWidth)) / buttonsCount);
    CGFloat buttonHeight = CGRectGetHeight(contentRect);
    CGSize buttonSize = CGSizeMake(buttonWidth, buttonHeight);
    
    CGFloat dButtonWidth = 0;
    CGFloat spaceLeft = CGRectGetWidth(contentRect) - (buttonsCount * buttonSize.width) - (separtorsNumber * separatorWidth);
    
    CGFloat offsetX = CGRectGetMinX(contentRect);
    CGFloat offsetY = CGRectGetMinY(contentRect);
    
    NSUInteger increment = 0;
    
    // laying-out the buttons
    for (UIButton *button in _buttonsArray)
    {
        // trick to incread the size of the button a little bit because of the separators
        dButtonWidth = buttonSize.width;
        
        if (spaceLeft != 0)
        {
            dButtonWidth++;
            spaceLeft--;
        }
        
        if (increment != 0) offsetX += separatorWidth;
        
        //
        [button setFrame:CGRectMake(offsetX, offsetY, dButtonWidth, buttonSize.height)];
        
        // replacing each separators
        if (increment < separtorsNumber)
        {
            UIImageView *separatorImageView = separatorsArray[increment];
            [separatorImageView setFrame:CGRectMake(CGRectGetMaxX(button.frame),
                                                    offsetY,
                                                    separatorWidth,
                                                    CGRectGetHeight(self.bounds) - _contentEdgeInsets.top - _contentEdgeInsets.bottom)];
        }
        
        increment++;
        offsetX = CGRectGetMaxX(button.frame);
    }
}

#pragma mark -
#pragma mark Button Actions

- (void)segmentButtonPressed:(id)sender
{
    UIButton *button = (UIButton *)sender;
    if (!button || ![button isKindOfClass:[UIButton class]])
        return;
    
    NSUInteger selectedIndex = button.tag;
    
    [self setSelectedIndex:selectedIndex];
}

#pragma mark -
#pragma mark Setters

- (void)setBackgroundImage:(UIImage *)backgroundImage
{
    _backgroundImage = backgroundImage;
    [backgroundImageView setImage:_backgroundImage];
}

- (void)setButtonsArray:(NSArray *)buttonsArray
{
    [_buttonsArray enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        [(UIButton *)obj removeFromSuperview];
    }];
    
    [separatorsArray removeAllObjects];
    
    // filling the arrays
    _buttonsArray = buttonsArray;
    
    [_buttonsArray enumerateObjectsWithOptions:NSEnumerationConcurrent usingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        [self addSubview:(UIButton *)obj];
        [(UIButton *)obj addTarget:self action:@selector(segmentButtonPressed:) forControlEvents:UIControlEventTouchDown];
        [(UIButton *)obj setTag:idx];
        
        if (idx ==_selectedIndex)
            [(UIButton *)obj setSelected:YES];
    }];
    
    [self setSeparatorImage:_separatorImage];
    [self setSegmentedControlMode:_segmentedControlMode];
}

- (void)setSeparatorImage:(UIImage *)separatorImage
{
    [separatorsArray enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        [(UIImageView *)obj removeFromSuperview];
    }];
    
    _separatorImage = separatorImage;
    
    NSUInteger separatorsNumber = [_buttonsArray count] - 1;
    
    [_buttonsArray enumerateObjectsWithOptions:NSEnumerationConcurrent usingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        if (idx < separatorsNumber)
        {
            UIImageView *separatorImageView = [[UIImageView alloc] initWithImage:_separatorImage];
            [self addSubview:separatorImageView];
            [separatorsArray addObject:separatorImageView];
        }
    }];
}

- (void)setSegmentedControlMode:(HLSegmentedControlMode)segmentedControlMode
{
    _segmentedControlMode = segmentedControlMode;
    
    if ([_buttonsArray count] == 0) return;
    
}

- (void)setSelectedIndex:(NSInteger)selectedIndex
{
    if (selectedIndex != _selectedIndex)
    {
        
        if ([_buttonsArray count] == 0) return;
        
        UIButton *currentSelectedButton = (UIButton *)_buttonsArray[_selectedIndex];
        UIButton *selectedButton = (UIButton *)_buttonsArray[selectedIndex];
        
        [currentSelectedButton setSelected:!currentSelectedButton.selected];
        [selectedButton setSelected:!selectedButton.selected];
        
        _selectedIndex = selectedIndex;
        
        if ([_delegate respondsToSelector:@selector(segmentedViewController:touchedAtIndex:)])
            [_delegate segmentedViewController:self touchedAtIndex:selectedIndex];
    }
}

- (NSString *)getSelectedImageName:(NSString *)imageName
{
    NSMutableString *returnString = [NSMutableString stringWithString:imageName];
    if ([imageName hasSuffix:@"@2x.png"]) {
        [returnString replaceCharactersInRange:NSMakeRange([returnString length] - 7, 7) withString:@"-selected@2x.png"];
    }
    else if([imageName hasSuffix:@".png"])
    {
        [returnString replaceCharactersInRange:NSMakeRange([returnString length] - 4, 4) withString:@"-selected.png"];
    }
    
    return returnString;
}

@end
