//
//  MyTripsViewController.m
//  intrepidApp
//
//  Created by Madelaine Page on 2013-07-28.
//  Copyright (c) 2013 JonCarrHarris Consulting. All rights reserved.
//

#import "MyTripsViewController.h"
#import "Constants.h"

@interface MyTripsViewController ()


@end

@implementation MyTripsViewController


@synthesize pageControl;
@synthesize scrollView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //set background
    UIImageView *backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"login-background.png"]];
    [self.view addSubview:backgroundView];

    //implement scrollview
    scrollView.delegate = self;
    scrollView.scrollEnabled = YES;
    scrollView.pagingEnabled = YES;
    
    //create array for images
    NSArray *imageArray = [[NSMutableArray alloc] initWithObjects:@"new-trip.png", @"mexico-city.png", @"mexico-city.png", nil];
    
    for (int i=0; i < [imageArray count]; i++) {
        CGRect frame;
        frame.origin.x = scrollView.frame.size.width * i;
        frame.origin.y = 0;
        frame.size = scrollView.frame.size;
        
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:frame];
        imageView.image = [UIImage imageNamed:[imageArray objectAtIndex:i]];
        [scrollView addSubview:imageView];
    }
    
    scrollView.contentSize = CGSizeMake(scrollView.frame.size.width * [imageArray count], scrollView.frame.size.height);
    
    [self.view addSubview:scrollView];
    
    NSArray *cityNames = [NSArray arrayWithObjects:
                          [name:@""], [name:@"Mexico City"], [name:@"Honolulu"], [name:@"Toronto"], nil];
    
    UILabel *cityName = [[UILabel alloc] init];
    cityName.frame = CGRectMake(85, self.view.frame.size.height - 125, 150, 25);
    cityName.font = [UIFont fontWithName:@"ProximaNova-Regular" size:18];
    cityName.text = @"Hello";
    cityName.backgroundColor = [UIColor clearColor];
    cityName.textColor = [UIColor whiteColor];
    [cityName setTextAlignment:NSTextAlignmentCenter];
    [self.view addSubview:cityName];

    pageControl.frame = CGRectMake(135, self.view.frame.size.height - 100, 50, 50);
    pageControl.numberOfPages = 3;
    pageControl.currentPage = 0;
    pageControl.pageIndicatorTintColor = [UIColor lightGrayColor];
    pageControl.currentPageIndicatorTintColor = [UIColor whiteColor];
    [self.view addSubview:pageControl];
    
}

-(void)scrollViewDidScroll:(UIScrollView *)sender {
    CGFloat pageWidth = self.scrollView.frame.size.width;
    int page = floor((scrollView.contentOffset.x - pageWidth / 2)/pageWidth) +1;
    pageControl.currentPage = page;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
