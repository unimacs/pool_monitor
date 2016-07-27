//
//  MonitorViewController.h
//  Pool Monitor
//
//  Created by tom on 8/9/14.
//  Copyright (c) 2014 CEE. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GraphViewController.h"

@interface MonitorViewController : UIViewController <UIPageViewControllerDataSource>

// @property (weak, nonatomic) IBOutlet UIButton *startWalkthrough;


@property (nonatomic, strong) IBOutlet UILabel *poolTemp;
@property (nonatomic, strong) IBOutlet UILabel *outsideTemp;
@property (nonatomic, strong) IBOutlet UILabel *updateTime;
@property (nonatomic, strong) IBOutlet UILabel *status;
@property (nonatomic, strong) IBOutlet UILabel *windSpeed;
@property (nonatomic, strong) IBOutlet UILabel *conditions;
@property (nonatomic, strong) IBOutlet UILabel *windDir;

@property (strong, nonatomic) UIPageViewController *pageViewController;
@property (strong, nonatomic) NSArray *pageTitles;
// @property (nonatomic, retain, readwrite) IBOutlet UIActivityIndicatorView * activityIndicator;

- (IBAction)fetchConditions;

@end
