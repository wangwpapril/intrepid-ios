//
//  SliderTabViewController.m
//  intrepidApp
//
//  Created by Philip Ojha on 7/21/2013.
//  Copyright (c) 2013 JonCarrHarris Consulting. All rights reserved.
//

#import "SliderTabViewController.h"
#import "Constants.h"

@implementation SliderTabViewController

@synthesize tabArray;
@synthesize viewArray;
@synthesize currentTab;
@synthesize previousTab;
@synthesize mController;
@synthesize line;
@synthesize verticalOffset;

# pragma  mark - visual interface setup

- (void)viewDidLoad
{
    [super viewDidLoad];
    mController = [MenuController getInstance];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.hidesBackButton = YES;
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@" " style:UIBarButtonItemStylePlain target:nil action:nil];
}

- (void)viewWillAppear:(BOOL)animated {
    [self.navigationController setNavigationBarHidden:NO animated:animated];
}

-(void)viewDidAppear:(BOOL)animated {
    [mController displayMenuWithParent:self];
}


- (CityEntity *)getCity {
    return mController.city;
}

- (void)addTabs:(NSArray *)nameArray {
    int i = 0;
    tabArray = [NSMutableArray new];
    
    while (i < 3) {
        
        // create the tab
        UIButton *tab = [UIButton buttonWithType:UIButtonTypeCustom];
        tab.frame = CGRectMake(107*i, 0, 107, 35);
        NSString *title;
        switch (i) {
            case 0:
                title = [nameArray objectAtIndex:0];
                break;
            case 1:
                title = [nameArray objectAtIndex:1];
                break;
            case 2:
                title = [nameArray objectAtIndex:2];
                break;
                
            default:
                break;
        }
        [tab setTitle:title forState:UIControlStateNormal];
        [tab setTitleColor:APP_TOGGLE_SELECTED forState:UIControlStateNormal];
        tab.titleLabel.font = [UIFont fontWithName:@"ProximaNova-Regular" size:13];
        [tab setBackgroundColor:NAVIGATION_BG_COLOR];
        tab.alpha = 0.8;
        [tab.titleLabel setTextAlignment:NSTextAlignmentCenter];
        
        tab.tag = i; // for tracking which one is clicked
        [tab addTarget:self action:@selector(tabSelected:) forControlEvents:UIControlEventTouchUpInside];
        [tabArray addObject:tab];
        [self.view addSubview:tab];
        i++;
    }
    currentTab = 0;
    [self tabSelected:[tabArray objectAtIndex:currentTab]];
    
    // swipe to switch tabs
    UISwipeGestureRecognizer *swipeLeft = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipedLeft:)];
    swipeLeft.numberOfTouchesRequired = 1;
    swipeLeft.direction = (UISwipeGestureRecognizerDirectionLeft);
    [self.view addGestureRecognizer:swipeLeft];
    
    UISwipeGestureRecognizer *swipeRight = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipedRight:)];
    swipeRight.numberOfTouchesRequired = 1;
    swipeRight.direction = (UISwipeGestureRecognizerDirectionRight);
    [self.view addGestureRecognizer:swipeRight];
    
    // create line
    line = [[UILabel alloc] init];
    line.backgroundColor = APP_TOGGLE_SELECTED;
    [self addLineToTab];
    [self.view addSubview:line];
}

- (void) addViews:(NSMutableArray *)arrayOfViews withVerticalOffset:(NSInteger)offset {
    verticalOffset = offset;
    viewArray = arrayOfViews;
    [self.view addSubview:[viewArray objectAtIndex:0]];
    
}

#pragma  mark - handle view swiping

- (void)tabSelected:(id)sender {
    UIButton *clickedTab = (UIButton *)sender;
    [self switchTabs:clickedTab.tag];
}

- (void) swipedRight:(UISwipeGestureRecognizer*)swipeGesture {
    NSInteger newTag = currentTab - 1;
    if (newTag >= 0) {
        [self switchTabs:newTag];
    }
}

- (void) swipedLeft:(UISwipeGestureRecognizer*)swipeGesture {
    NSInteger newTag = currentTab + 1;
    if (newTag <= 2) {
        [self switchTabs:newTag];
    }
}

-(void)addLineToTab {
    UIButton *tab = ((UIButton *)[tabArray objectAtIndex:currentTab]);
    CGSize size = [tab.titleLabel.text sizeWithFont:[UIFont fontWithName:@"ProximaNova-Regular" size:13]
                   constrainedToSize:CGSizeMake(280, 15000)
                       lineBreakMode:NSLineBreakByWordWrapping];
    float length = size.width + 2;
    float xPos = tab.center.x - length / 2;
    line.frame = CGRectMake(xPos, 27, length, 1);
}


-(void)switchTabs:(NSInteger)newTag{
    previousTab = currentTab;
    NSInteger index = 0;
    
    // handle tabs
    for (UIButton *tab in tabArray) {
        
        // capital letter
        //        UILabel *capitalLetter = ((UILabel *)[largeLetterArray objectAtIndex:index]);
        // select that tab
        
        if (tab.tag == newTag) {
            [tab setTitleColor:APP_TOGGLE_SELECTED forState:UIControlStateNormal];
            //            [capitalLetter setTextColor:APP_TOGGLE_SELECTED];
//            lineX = 107 * index + 13;
            
        }
        
        // make sure tab is inactive
        else {
            [tab setTitleColor:APP_TOGGLE_UNSELECTED forState:UIControlStateNormal];
            //            [capitalLetter setTextColor:APP_TOGGLE_UNSELECTED];
        }
        index++;
    }
    
    if (currentTab !=newTag) {
        
        //        [self removeText];
        [self addLineToTab];
        
        for (UIButton * tab in tabArray) {
            tab.userInteractionEnabled = NO;
        }
        
        currentTab = newTag;
        
        // handle views sliding
        
        UIView *tableToBe = ((UIView *)[viewArray objectAtIndex:currentTab]);
        
        if (currentTab == 0 || currentTab == 2) {
            NSInteger position = (currentTab - 1) * 320;
            if (position < 0) {
            }
            tableToBe.frame = CGRectMake(position, verticalOffset, 320, self.view.frame.size.height - verticalOffset);
        }
        else {
            if (previousTab == 0) {
                tableToBe.frame = CGRectMake(320, verticalOffset, 320, self.view.frame.size.height - verticalOffset);
            }
            else {
                tableToBe.frame = CGRectMake(-320, verticalOffset, 320, self.view.frame.size.height - verticalOffset);
            }
        }
        [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseIn animations:^ {
                //line.frame = CGRectMake(lineX, 27, 80, 1);
                [self addLineToTab];
                NSInteger offset;
                if (currentTab - previousTab > 0) {
                    offset = -320;
                }
                else {
                    offset = 320;
                }
                
                [self.view insertSubview:[viewArray objectAtIndex:currentTab] belowSubview:[tabArray objectAtIndex:0]];
                for (UIView *view in viewArray) {
                    [view setFrame:CGRectMake(view.frame.origin.x + offset, verticalOffset, 320, self.view.frame.size.height - verticalOffset)];
                }
            }
                             completion:^(BOOL finished){
                                 [[viewArray objectAtIndex:previousTab] removeFromSuperview];
                                 for (UIButton * tab in tabArray) {
                                     tab.userInteractionEnabled = YES;
                                 }
                                 [self viewSwitched];
                             }];
    }
}

-(void)viewSwitched {
    // to be implemented by child class
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
