//
//  ScrollerTabViewController.m
//  intrepidApp
//
//  Created by Philip Ojha on 8/11/2013.
//  Copyright (c) 2013 JonCarrHarris Consulting. All rights reserved.
//

#import "ScrollerTabViewController.h"

@implementation ScrollerTabViewController

@synthesize tabArray;
@synthesize currentTab;
@synthesize previousTab;
@synthesize line;
//@synthesize verticalOffset;
@synthesize scroll;
@synthesize pageControl;

# pragma  mark - visual interface setup

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.hidesBackButton = YES;
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@" " style:UIBarButtonItemStylePlain target:nil action:nil];
    [self.navigationController setNavigationBarHidden:NO animated:NO];
    
    // property allocations
    tabArray = [NSMutableArray new];
    line = [[UILabel alloc] init];
    
    // scrollView setup
    scroll = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, 320, self.view.frame.size.height)];
    scroll.showsVerticalScrollIndicator = YES;
    scroll.showsHorizontalScrollIndicator = NO;
    scroll.pagingEnabled = YES;
    scroll.scrollEnabled = YES;
    scroll.delegate = self;
    [self.view addSubview:scroll];
}

- (void)viewWillAppear:(BOOL)animated {
    [[MenuController getInstance] displayMenuWithParent:self];
}

- (CityEntity *)getCity {
    return [MenuController getInstance].city;
}

- (void)addTabs:(NSArray *)nameArray {
    NSInteger i = 0;
    NSInteger limit = nameArray.count;
    float width = 321/limit;
    while (i < limit) {        
        // create the tab
        UIButton *tab = [UIButton buttonWithType:UIButtonTypeCustom];
        tab.frame = CGRectMake(width*i, 0, width, 35);
        NSString *title = [nameArray objectAtIndex:i];

        [tab setTitle:title forState:UIControlStateNormal];
        [tab setTitleColor:APP_TOGGLE_SELECTED forState:UIControlStateNormal];
        tab.titleLabel.font = [UIFont fontWithName:APP_FONT size:13];
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
    
    // create line
    line.backgroundColor = APP_TOGGLE_SELECTED;
    [self addLineToTab];
    [self.view addSubview:line];
}

- (void)addViews:(NSMutableArray *)arrayOfViews withVerticalOffset:(NSInteger)offset {
    NSInteger i = 0;
    NSInteger limit = arrayOfViews.count;
    NSInteger specialOffset = self.view.frame.size.height - 44;
    while (i < limit) {
        UIView *view =[arrayOfViews objectAtIndex:i];
        view.frame = CGRectMake(i*320, offset, 320, specialOffset);
        [scroll addSubview:[arrayOfViews objectAtIndex:i]];
        i++;
    }
    scroll.contentSize = CGSizeMake(320 * i, self.view.frame.size.height);
}

// custom for Health View Controller
- (void)addViews:(NSMutableArray *)arrayOfViews withVerticalOffset:(NSInteger)offset withTableOffset:(NSInteger)tableOffset {
    NSInteger i = 0;
    NSInteger limit = arrayOfViews.count;
    NSInteger specialOffset = self.view.frame.size.height - 44;
    while (i < limit) {
        UIView *view =[arrayOfViews objectAtIndex:i];
        if (i == 0) {
            view.frame = CGRectMake(i*320, offset, 320, specialOffset);
        } else {
            view.frame = CGRectMake(i*320, tableOffset, 320, specialOffset);
        }
        [scroll addSubview:[arrayOfViews objectAtIndex:i]];
        i++;
    }
    scroll.contentSize = CGSizeMake(320 * i, self.view.frame.size.height);
}

#pragma  mark - handle view swiping

- (void)tabSelected:(id)sender {
    UIButton *clickedTab = (UIButton *)sender;
    [self switchTabs:clickedTab.tag];
    [self.scroll scrollRectToVisible:CGRectMake(currentTab * 320, 0, 320, self.view.frame.size.height) animated:YES];
}

- (void)addLineToTab {
    UIButton *tab = ((UIButton *)[tabArray objectAtIndex:currentTab]);
    
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineBreakMode = NSLineBreakByWordWrapping;
    
    CGSize size = [tab.titleLabel.text boundingRectWithSize:CGSizeMake(280, 15000)
                                                    options:NSStringDrawingUsesLineFragmentOrigin
                                                 attributes:@{NSParagraphStyleAttributeName:paragraphStyle.copy, NSFontAttributeName:[UIFont fontWithName:@"ProximaNova-Light" size:13]}
                                                    context:nil].size;
    
    float length = size.width + 2;
    float xPos = tab.center.x - length / 2;
    line.frame = CGRectMake(xPos, 27, length, 1);
}


- (void)switchTabs:(NSInteger)newTag{ // refactor this method so that line drawin / tab selection is separated
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
        
//        [self addLineToTab];
        
        for (UIButton * tab in tabArray) {
            tab.userInteractionEnabled = NO;
        }
        
        currentTab = newTag;
        [self viewSwitched];
        [self.scroll scrollRectToVisible:CGRectMake(currentTab * 320, 0, 320, self.view.frame.size.height) animated:YES];
        
        [self.view endEditing:YES];
        [UIView animateWithDuration:0.1 delay:0 options:UIViewAnimationOptionCurveEaseIn animations:^ {
            [self addLineToTab];

        }
                         completion:^(BOOL finished){
                             for (UIButton * tab in tabArray) {
                                 tab.userInteractionEnabled = YES;
                             }
//                             autoScrolling = false;
                         }];
    }
}

- (void)viewSwitched {
    // 4 child class
}

#pragma mark - scrollView delegate methods

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    CGFloat pageWidth = self.scroll.frame.size.width;
    int page = floor((scroll.contentOffset.x - pageWidth / 2)/pageWidth) +1;
    [self switchTabs:page];
}

@end
