//
//  ViewController.h
//  ckeyboard
//
//  Created by Pedro Luis Berbel dos Santos on 22/05/15.
//  Copyright (c) 2015 BEPiD Fucapi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PageContentViewController.h"


@interface ViewController : UIViewController <UIPageViewControllerDataSource>

- (IBAction)startWalkthrough:(id)sender;

@property (strong, nonatomic) UIPageViewController *pageViewController;

@property (strong, nonatomic) NSArray *pageImages;
//@property (strong, nonatomic) NSArray *pageTitles;

@end
