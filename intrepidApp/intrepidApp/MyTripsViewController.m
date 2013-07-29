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
    CGFloat contentOffset = 150.0f;
    
    //set background
    UIImageView *backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"login-background.png"]];
    [self.view addSubview:backgroundView];

    //implement scrollview
    scrollView.delegate = self;
    scrollView.scrollEnabled = YES;
    scrollView.pagingEnabled = YES;
    
    //create array for images
    NSArray *imageArray = [[NSMutableArray alloc] initWithObjects:@"new-trip.png", @"mexico-city.png", @"Guada@2x.png", @"miami@2x.png", nil];
    NSArray *nameArray = [[NSMutableArray alloc] initWithObjects:@" ", @"Mexico City", @"Guada", @"miami", nil];
    
    for (int i=0; i < [imageArray count]; i++) {
        CGRect frame;
        frame.origin.x = (scrollView.frame.size.width) * i + 45;
        frame.origin.y = scrollView.frame.origin.y + 15;
        frame.size = CGSizeMake(234, scrollView.frame.size.height - 182.0);

        CGRect nameFrame;
        nameFrame.origin.x = (scrollView.frame.size.width) * i + 45;
        nameFrame.origin.y = scrollView.frame.size.height + 15;
        nameFrame.size = CGSizeMake(234, scrollView.frame.size.height - 182.0);
        
        
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:frame];
        imageView.image = [UIImage imageNamed:[imageArray objectAtIndex:i]];
        [scrollView addSubview:imageView];
        
        UILabel *cityName = [[UILabel alloc] initWithFrame:nameFrame];
        cityName.font = [UIFont fontWithName:@"ProximaNova-Regular" size:18];
        cityName.backgroundColor = [UIColor clearColor];
        cityName.textColor = [UIColor whiteColor];
        [cityName setTextAlignment:NSTextAlignmentCenter];
        cityName.text = @"hello";
        [scrollView addSubview:cityName];
        
        
        if (i == 0) {
            UIButton *toTrips = [UIButton buttonWithType:UIButtonTypeCustom];
            toTrips.frame = imageView.frame;
            [toTrips addTarget:self action:@selector(toTrips) forControlEvents:UIControlEventTouchUpInside];
            [scrollView addSubview:toTrips];       
        }        
        else if (i == 1) {
            cityName.text = @"Mexico City";
        }

        else {
            cityName.text = @"Barcelona";
        }
    }
    
    scrollView.contentSize = CGSizeMake(scrollView.frame.size.width * [imageArray count], 366.0);
    
    [self.view addSubview:scrollView];
    
    pageControl.frame = CGRectMake(135, self.view.frame.size.height - 100, 50, 50);
    pageControl.numberOfPages = 4;
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
    [city addObject:@"Guadalajara"];
    [city addObject:@"Miami"];
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
