//
//  ScrollerTabViewController.h
//  intrepidApp
//
//  Created by Philip Ojha on 8/11/2013.
//  Copyright (c) 2013 JonCarrHarris Consulting. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MenuController.h"

@interface ScrollerTabViewController : UIViewController <UIScrollViewDelegate>

@property (nonatomic, strong) NSMutableArray *tabArray;
@property (nonatomic) NSInteger currentTab;
@property (nonatomic) NSInteger previousTab;
@property (nonatomic, strong) UILabel *line;
//@property (nonatomic) NSInteger verticalOffset;
@property (nonatomic, strong) UIScrollView *scroll;

@property (nonatomic, retain) IBOutlet UIPageControl *pageControl;

- (CityEntity *)getCity;
- (void)addTabs:(NSArray *)nameArray;
- (void)addViews:(NSMutableArray *)arrayOfViews withVerticalOffset:(NSInteger)offset;
- (void)addViews:(NSMutableArray *)arrayOfViews withVerticalOffset:(NSInteger)offset withTableOffset:(NSInteger)tableOffset;
@end
