//
//  HLViewController.m
//  HLSegmentedControl
//
//  Created by Lei Huang on 9/13/14.
//  Copyright (c) 2014 ___FULLUSERNAME___. All rights reserved.
//

#import "HLViewController.h"
#import "HLSegmentedControl.h"

@interface HLViewController ()

@end

@implementation HLViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    HLSegmentedControl *segC = [[HLSegmentedControl alloc]initWithFrame:CGRectMake(0, 10, 320, 60) titleArray:@[@"test1",@"test2",@"test3"] imageArray:@[@"settings-icon.png",@"settings-icon.png",@"settings-icon.png"] segmentedControlMode:HLSegmentedControlModeImageUpButtonDown];
    segC.delegate = self;
    [self.view addSubview:segC];
    
    
    HLSegmentedControl *segC1 = [[HLSegmentedControl alloc]initWithFrame:CGRectMake(0, 70, 320, 45) titleArray:@[@"test1",@"test2",@"test3"] imageArray:@[@"settings-icon.png",@"settings-icon.png",@"settings-icon.png"] segmentedControlMode:HLSegmentedControlMOdeImageLiftButtonRight];
    segC.delegate = self;
    [self.view addSubview:segC1];
    
    HLSegmentedControl *segC2 = [[HLSegmentedControl alloc]initWithFrame:CGRectMake(0, 120, 320, 45) titleArray:@[@"test1",@"test2",@"test3"] imageArray:@[@"settings-icon.png",@"settings-icon.png",@"settings-icon.png"] segmentedControlMode:HLSegmentedControlModeButtonOnly];
    segC.delegate = self;
    [self.view addSubview:segC2];
    
    
    HLSegmentedControl *segC3 = [[HLSegmentedControl alloc]initWithFrame:CGRectMake(0, 170, 320, 45) titleArray:@[@"test1",@"test2",@"test3"] imageArray:@[@"settings-icon.png",@"settings-icon.png",@"settings-icon.png"] segmentedControlMode:HLSegmentedControlModeImageOnly];
    segC.delegate = self;
    [self.view addSubview:segC3];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)segmentedViewController:(HLSegmentedControl *)segmentedControl touchedAtIndex:(NSUInteger)index
{
    NSLog(@"select index is %d",index);
}

@end
