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
@synthesize city;

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
    
    [self cityNames];
    
    //set background
    UIImageView *backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"login-background.png"]];
    [self.view addSubview:backgroundView];

    //implement scrollview
    scrollView.delegate = self;
    scrollView.scrollEnabled = YES;
    scrollView.pagingEnabled = YES;
    
    //create array for images
    NSArray *imageArray = [[NSMutableArray alloc] initWithObjects:@"new-trip.png", @"mexico-city.png", @"mexico-city.png", nil];
    UILabel *cityName = [[UILabel alloc] init];
    
    for (int i=0; i < [imageArray count]; i++) {
        CGRect frame;
        frame.origin.x = (scrollView.frame.size.width) * i + 25;
        frame.origin.y = 0;
        frame.size = CGSizeMake(268.0, 366.0);
        
        //this doesn't change
        cityName.frame = CGRectMake(85, self.view.frame.size.height - 125, 150, 25);
        cityName.font = [UIFont fontWithName:@"ProximaNova-Regular" size:18];
        cityName.backgroundColor = [UIColor clearColor];
        cityName.textColor = [UIColor whiteColor];
        [cityName setTextAlignment:NSTextAlignmentCenter];
        cityName.text = [city objectAtIndex:i];
        [scrollView addSubview:cityName];
        
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:frame];
        imageView.image = [UIImage imageNamed:[imageArray objectAtIndex:i]];
        [scrollView addSubview:imageView];
        if (i == 0) {
            UIButton *toTrips = [UIButton buttonWithType:UIButtonTypeCustom];
            toTrips.frame = imageView.frame;
            [toTrips addTarget:self action:@selector(toTrips) forControlEvents:UIControlEventTouchUpInside];
            [scrollView addSubview:toTrips];
        }
    }
    
    scrollView.contentSize = CGSizeMake(scrollView.frame.size.width * [imageArray count], scrollView.frame.size.height);
    
    [self.view addSubview:scrollView];
    
    pageControl.frame = CGRectMake(135, self.view.frame.size.height - 100, 50, 50);
    pageControl.numberOfPages = 3;
    pageControl.currentPage = 0;
    pageControl.pageIndicatorTintColor = [UIColor lightGrayColor];
    pageControl.currentPageIndicatorTintColor = [UIColor whiteColor];
    [self.view addSubview:pageControl];
    
}

-(void)toTrips {
    UIViewController *viewController = [self.storyboard instantiateViewControllerWithIdentifier:@"trips"];
    [self.navigationController pushViewController:viewController animated:YES];
}

-(void)cityNames {
    city = [[NSMutableArray alloc] init];
    [city addObject:@" "];
    [city addObject:@"Mexico City"];
    [city addObject:@"Barcelona"];
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
