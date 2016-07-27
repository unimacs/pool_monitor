//
//  MonitorViewController.m
//  Pool Monitor
//
//  Created by tom on 8/9/14.
//  Copyright (c) 2014 CEE. All rights reserved.
//

#import "MonitorViewController.h"

@interface MonitorViewController ()

@end

@implementation MonitorViewController


- (IBAction)fetchConditions;
{
	self.status.text = @"Updating...";
    NSURL *url = [NSURL URLWithString:@"http://bogie.duckdns.org:8085/current_conditions"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [NSURLConnection sendAsynchronousRequest:request
                                       queue:[NSOperationQueue mainQueue]
	 completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError)
     {
         if (data.length > 0 && connectionError == nil)
         {
             NSDictionary *conditions = [NSJSONSerialization JSONObjectWithData:data
                                                                      options:0
                                                                        error:NULL];
			 
			 self.status.text = @"";
			 NSNumber *poolTemp = [conditions objectForKey:@"pool_temp"];
			 self.poolTemp.text = [NSString stringWithFormat:@"%.02f", [poolTemp floatValue]];

             self.outsideTemp.text = [conditions objectForKey:@"temp_f"] ;
			 self.windSpeed.text = [conditions objectForKey:@"wind_speed"] ;
			 self.conditions.text = [conditions objectForKey:@"conditions"] ;
			 self.windDir.text = [conditions objectForKey:@"wind_dir"] ;
			 
			 // Get current date time
			 NSDate *currentDateTime = [NSDate date];
			 
			 // Instantiate a NSDateFormatter
			 NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
			 
			 // Set the dateFormatter format
			 [dateFormatter setDateFormat:@"MM-dd-yyyy HH:mm:ss"];
			 
			 // format the timestamp
			 NSString *formatedTime = [dateFormatter stringFromDate:currentDateTime];
			 
			 self.updateTime.text = formatedTime;
			 
			 //NSLog(@"%@", dateInStringFormated);
			 			 
         }
		 else
		 {
			 if (connectionError)
			 {
				self.status.text = @"Pool Status not available. Try Later.";
			 }
		 }
	}];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	
	_pageTitles = @[@"Over 200 Tips and Tricks", @"Discover Hidden Features"];
	
	UIImageView *backgroundImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"parasailing"]];
	backgroundImage.frame = self.view.bounds;
	[[self view] addSubview:backgroundImage];
	[backgroundImage.superview sendSubviewToBack:backgroundImage];
//	[self.view insertSubview:backgroundImage atIndex:0];
	
	// Create page view controller
//    self.pageViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"PageViewController"];
//    self.pageViewController.dataSource = self;
    
 //   GraphViewController *graphViewController = [self viewControllerAtIndex:0];
//    NSArray *viewControllers = @[graphViewController];
//    [self.pageViewController setViewControllers:viewControllers direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
    
    // Change the size of page view controller
 //   self.pageViewController.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - 30);
    
 //   [self addChildViewController:_pageViewController];
 //   [self.view addSubview:_pageViewController.view];
 //   [self.pageViewController didMoveToParentViewController:self];
	
    [self fetchConditions];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController
{
    NSUInteger index = ((GraphViewController*) viewController).pageIndex;
    
    if ((index == 0) || (index == NSNotFound)) {
        return nil;
    }
    
	index--;
	[self.view sendSubviewToBack:_pageViewController.view];
	return nil;

   //	return [self viewControllerAtIndex:index];
	
	//	NSString *restorationId = viewController.restorationIdentifier;
//	if ([restorationId isEqualToString:@"MonitorViewController"])
//	{
//		return nil;
//	}
//	else
//	{
//		return self;
//	}


}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController
{
    NSUInteger index = ((GraphViewController*) viewController).pageIndex;
    
    if (index == NSNotFound) {
        return nil;
    }
    
    index++;
    if (index == [self.pageTitles count]) {
        return nil;
    }
    return [self viewControllerAtIndex:index];
}

- (UIViewController *)viewControllerAtIndex:(NSUInteger)index
{
    if (([self.pageTitles count] == 0) || (index >= [self.pageTitles count])) {
        return nil;
    }
    
    // Create a new view controller and pass suitable data.
    GraphViewController *GraphViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"GraphViewController"];
    GraphViewController.titleText = self.pageTitles[index];
    GraphViewController.pageIndex = index;
    
    return GraphViewController;
}

- (NSInteger)presentationCountForPageViewController:(UIPageViewController *)pageViewController
{
    return [self.pageTitles count];
}

- (NSInteger)presentationIndexForPageViewController:(UIPageViewController *)pageViewController
{
    return 0;
}

@end
