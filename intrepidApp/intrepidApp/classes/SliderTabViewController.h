//
//  SliderTabViewController.h
//  intrepidApp
//
//  Created by Philip Ojha on 7/21/2013.
//  Copyright (c) 2013 JonCarrHarris Consulting. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MenuController.h"

@interface SliderTabViewController : UIViewController

@property (nonatomic, strong) NSMutableArray *tabArray;
@property (nonatomic, strong) NSMutableArray *viewArray;
@property (nonatomic) NSInteger currentTab;
@property (nonatomic) NSInteger previousTab;
@property (nonatomic, strong) UILabel *line;
@property (nonatomic, strong) MenuController *mController;
@property (nonatomic) NSInteger verticalOffset;

// mandatory method to be called at viewDidLoad in order to create the tabs
// (takes 3 tab names)
- (void)addTabs:(NSArray *)nameArray;

-(CityEntity *)getCity;

// mandatory method to be called at viewDidLoad in order to populate the views
// takes 3 views; offset is vertical offset from the top
- (void) addViews:(NSMutableArray *)arrayOfViews withVerticalOffset:(NSInteger)offset;

@end
