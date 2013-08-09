//
//  MyTripsViewController.m
//  intrepidApp
//
//  Created by Madelaine Page on 2013-07-28.
//  Copyright (c) 2013 JonCarrHarris Consulting. All rights reserved.
//

#import "MyTripsViewController.h"
#import "MenuController.h"
#import "Constants.h"
#import "TripManager.h"
#import "CityEntity.h"
#import "TripItem.h"
#import "SecurityViewController.h"

@implementation MyTripsViewController

@synthesize pageControl;
@synthesize scrollView;
@synthesize cities;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@" " style:UIBarButtonItemStylePlain target:nil action:nil];
    
//    [self cityNames];
    
//    CGFloat contentOffset = 150.0f;
    
    //set background
    UIImageView *backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"login-background.png"]];
    [self.view addSubview:backgroundView];

    //implement scrollview
    scrollView.delegate = self;
    scrollView.scrollEnabled = YES;
    scrollView.pagingEnabled = YES;
    
    TripManager *manager = [TripManager getInstance];
    cities = [manager getCities];
    
    //create array for images
    NSMutableArray *cityArray = [NSMutableArray new];
    for (CityEntity *city in cities) {
        TripItem *trip = [[TripItem alloc] init];
        trip.image = city.cityImage;
        trip.city = city.cityName;
        [cityArray addObject:trip];
    }
    
    TripItem *newTrip = [[TripItem alloc] init];
    newTrip.image = @"ANew-trip@2x.png";
    newTrip.city = @"A New Trip";
    [cityArray addObject:newTrip];
//    NSArray *imageArray = [[NSMutableArray alloc] initWithObjects:@"new-trip.png", @"NMexico@2x.png", @"Guada@2x.png", @"miami@2x.png", @"Puerto-Plata@2x.png", nil];
//    NSArray *nameArray = [[NSMutableArray alloc] initWithObjects:@" ", @"Mexico City", @"Guadalajara", @"Miami", @"Puerto Plata", nil];

    NSInteger height = scrollView.frame.size.height - 150.0;
    NSInteger width = height * 0.7322;
    int i = 0;
    NSInteger max = cityArray.count - 1;
    for (TripItem *city in cityArray) {
        NSLog(@"city name: %@ city img: %@", city.city, city.image);
        CGRect frame;
        frame.origin.x = 320 * i + (320 - width)/2;
        frame.origin.y = scrollView.frame.origin.y + 37; // was 15
        
        frame.size = CGSizeMake(width, height);
        
        
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:frame];
        imageView.image = [UIImage imageNamed:city.image];
        [scrollView addSubview:imageView];
        
        // make imageViews clickable with invisible buttons
        if (i == max) {
            UIButton *toTrips = [UIButton buttonWithType:UIButtonTypeCustom];
            toTrips.frame = imageView.frame;
            [toTrips addTarget:self action:@selector(toTrips) forControlEvents:UIControlEventTouchUpInside];
            [scrollView addSubview:toTrips];       
        }
        else {
            UIButton *toSecurity = [UIButton buttonWithType:UIButtonTypeCustom];
            toSecurity.tag = i;
            toSecurity.frame = imageView.frame;
            [toSecurity addTarget:self action:@selector(toSecurity:) forControlEvents:UIControlEventTouchUpInside];
            [scrollView addSubview:toSecurity];
        }
        
        // add a label
        UILabel *cityName = [[UILabel alloc] init];
        cityName.frame = CGRectMake(110 + 320 * i, self.view.frame.size.height - 138, 100.0, 100.0);
        [cityName setTextAlignment:NSTextAlignmentCenter];
        cityName.font = [UIFont fontWithName:@"ProximaNova-Regular" size:18];
        cityName.backgroundColor = [UIColor clearColor];
        cityName.textColor = [UIColor whiteColor];
        [cityName setTextAlignment:NSTextAlignmentCenter];
        cityName.text =city.city;
        [scrollView addSubview:cityName];

        i++;
    }

    NSInteger entries = [cityArray count];
    scrollView.contentSize = CGSizeMake(scrollView.frame.size.width * entries, 366.0);
    
    [self.view addSubview:scrollView];
    
    pageControl.frame = CGRectMake(135, self.view.frame.size.height - 78, 50, 50);
    pageControl.numberOfPages = entries;
    pageControl.currentPage = 0;
    pageControl.pageIndicatorTintColor = [UIColor darkGrayColor];
    pageControl.currentPageIndicatorTintColor = [UIColor whiteColor];
    [self.view addSubview:pageControl];
    
}

-(void)toTrips {
    UIViewController *viewController = [self.storyboard instantiateViewControllerWithIdentifier:@"trips"];
    [self.navigationController pushViewController:viewController animated:YES];
}

-(void)toSecurity:sender {
    NSInteger index = ((UIButton *)sender).tag - 1; // to account for new trip
    CityEntity *city = [cities objectAtIndex:index];
    [MenuController getInstance].city = city;
    SecurityViewController *viewController = [self.storyboard instantiateViewControllerWithIdentifier:@"security"];
    viewController.firstLoad = true;
    [self.navigationController pushViewController:viewController animated:YES];
//    [[MenuController getInstance] showMenu];
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

 - (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:animated];
}



@end
