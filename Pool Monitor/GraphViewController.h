//
//  PageContentViewController.h
//  Pool Monitor
//
//  Created by tom on 8/19/14.
//  Copyright (c) 2014 CEE. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GraphViewController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property NSUInteger pageIndex;
@property NSString *titleText;

@end
