//
//  MyTripsViewController.m
//  intrepidApp
//
//  Created by Madelaine Page on 2013-07-28.
//  Copyright (c) 2013 JonCarrHarris Consulting. All rights reserved.
//

#import "MyTripsViewController.h"
#import "MenuController.h"
#import "TripManager.h"
#import "CityEntity.h"
#import "TripItem.h"
#import "OverViewViewController.h"
#import "UIImageView+WebCache.h"

@implementation MyTripsViewController

@synthesize pageControl;
@synthesize scrollView;
@synthesize cities;
@synthesize pageControlBeingUsed;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    pageControlBeingUsed = NO;
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@" " style:UIBarButtonItemStylePlain target:nil action:nil];
    
    //set background
    UIGraphicsBeginImageContext(self.view.frame.size);
    [[UIImage imageNamed:@"login-background"] drawInRect:self.view.bounds];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    self.view.backgroundColor = [UIColor colorWithPatternImage:image];
    
    UISwipeGestureRecognizer *swipeUpGestureRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipeUpFrom:)];
    swipeUpGestureRecognizer.direction = UISwipeGestureRecognizerDirectionUp;
    [scrollView addGestureRecognizer:swipeUpGestureRecognizer];

    //implement scrollview
    scrollView.delegate = self;
    scrollView.scrollEnabled = YES;
    scrollView.pagingEnabled = YES;
    [self.view addSubview:scrollView];
    
    pageControl.frame = CGRectMake(0, self.view.frame.size.height - 60, 320, 50);
    pageControl.currentPage = 0;
    // replace with loading indicator
    pageControl.numberOfPages = 1;
    pageControl.pageIndicatorTintColor = [UIColor darkGrayColor];
    pageControl.currentPageIndicatorTintColor = [UIColor whiteColor];
    [pageControl addTarget:self action:@selector(changePage:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:pageControl];
    [self loadCities];
}

- (void)loadCities {
    TripManager *manager = [TripManager getInstance];
    
    NSArray *intermediateArray = [manager getSavedCities];
    NSSortDescriptor *sort = [NSSortDescriptor sortDescriptorWithKey:@"destinationName" ascending:YES];
    cities = [intermediateArray sortedArrayUsingDescriptors:@[sort]];

    NSMutableArray *cityArray = [NSMutableArray new];
    TripItem *newTrip = [[TripItem alloc] init];
    newTrip.image = @"ANew-trip";
    newTrip.city = @"A New Trip";
    [cityArray addObject:newTrip];
    
    for (CityEntity *city in cities) {
        TripItem *trip = [[TripItem alloc] init];
        trip.image = city.introImage1x;
        trip.image2x = city.introImage2x;
        trip.image3x = city.introImage3x;
        trip.city = city.destinationName;
        [cityArray addObject:trip];
    }
    
    double scaleFactor = [UIScreen mainScreen].scale;
    
    NSInteger height = scrollView.frame.size.height - 170.0;
    NSInteger width = height * 0.7322;
    int i = 0;
    for (TripItem *city in cityArray) {
        CGRect frame;
        frame.origin.x = 320 * i + (320 - width)/2;
        frame.origin.y = scrollView.frame.origin.y + 37; // was 15
        frame.size = CGSizeMake(width, height);
        
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:frame];
        imageView.layer.cornerRadius = 10.0;
        imageView.clipsToBounds = YES;

        // make imageViews clickable with invisible buttons
        if (i == 0) {
            imageView.image = [UIImage imageNamed:city.image];
            [scrollView addSubview:imageView];
            
            UIButton *toTrips = [UIButton buttonWithType:UIButtonTypeCustom];
            toTrips.frame = imageView.frame;
            [toTrips addTarget:self action:@selector(toTrips) forControlEvents:UIControlEventTouchUpInside];
            [scrollView addSubview:toTrips];
        }
        else {
            if (scaleFactor > 2.9 && ![city.image3x isEqualToString:@""]) {
                [imageView sd_setImageWithURL:[NSURL URLWithString:city.image3x]];
            } else if (![city.image2x isEqualToString:@""]) {
                [imageView sd_setImageWithURL:[NSURL URLWithString:city.image2x]];
            } else if (![city.image isEqualToString:@""]) {
                [imageView sd_setImageWithURL:[NSURL URLWithString:city.image]];
            } else {
                imageView.image = [UIImage imageNamed:@"empty-trip"];
            }
            [scrollView addSubview:imageView];
            
            UIButton *toSecurity = [UIButton buttonWithType:UIButtonTypeCustom];
            toSecurity.tag = i - 1;
            toSecurity.frame = imageView.frame;
            [toSecurity addTarget:self action:@selector(toSecurity:) forControlEvents:UIControlEventTouchUpInside];
            [scrollView addSubview:toSecurity];
        }
    
        // add a label
        UILabel *cityName = [[UILabel alloc] init];
        cityName.frame = CGRectMake(10 + 320 * i, self.view.frame.size.height - 138, 300.0, 100.0);
        [cityName setTextAlignment:NSTextAlignmentCenter];
        cityName.font = [UIFont fontWithName:APP_FONT size:18];
        cityName.backgroundColor = [UIColor clearColor];
        cityName.textColor = [UIColor whiteColor];
        cityName.text = city.city;
        [scrollView addSubview:cityName];
        
        i++;
    }
    
    NSInteger entries = [cityArray count];
    scrollView.contentSize = CGSizeMake(scrollView.frame.size.width * entries, 366.0);
    
    pageControl.numberOfPages = entries;;
}

- (void)viewDidAppear:(BOOL)animated {
    // init vars
    NSInteger index, i, limit;
    i = 0;
    limit = cities.count;
    
    MenuController *mController = [MenuController getInstance];
    if (mController.city) {
        while (i < limit) {
            if (mController.city == [cities objectAtIndex:i]) {
                index = i;
            }
            i++;
        }
        CGRect target = CGRectMake(320 * index, 0, 320, self.view.frame.size.height);
        [scrollView scrollRectToVisible:target animated:YES];
    }
}

- (IBAction)changePage:(id)sender {
    pageControlBeingUsed = YES;
    UIPageControl *pager=sender;
    NSInteger page = pager.currentPage;
    
    CGRect frame = scrollView.frame;
    frame.origin.x = frame.size.width * page;
    frame.origin.y = 0;
    [scrollView scrollRectToVisible:frame animated:YES];
}

- (void)toTrips {
    UIViewController *viewController = [self.storyboard instantiateViewControllerWithIdentifier:@"trips"];
    [self.navigationController pushViewController:viewController animated:YES];
}

- (void)toSecurity:sender {
    NSInteger index = ((UIButton *)sender).tag;
    CityEntity *city = [cities objectAtIndex:index];
    [MenuController getInstance].city = city;
    OverViewViewController *viewController = [self.storyboard instantiateViewControllerWithIdentifier:@"overView"];
    viewController.firstLoad = true;
    [[MenuController getInstance] selectButtonWithTag:0];
    [self.navigationController pushViewController:viewController animated:YES];
//    [[MenuController getInstance] showMenu];
}

- (void)viewWillAppear:(BOOL)animated {
    [self.navigationController setNavigationBarHidden:YES animated:animated];
}

- (void)scrollViewDidScroll:(UIScrollView *)sender {
    if (!pageControlBeingUsed) {
    // Update the page when more than 50% of the previous/next page is visible
        CGFloat pageWidth = self.scrollView.frame.size.width;
        int page = floor((self.scrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
        self.pageControl.currentPage = page;
    }
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    pageControlBeingUsed = NO;
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    pageControlBeingUsed = NO;
}

- (void)handleSwipeUpFrom:(UIGestureRecognizer*)recognizer {
    CGPoint touchPoint = [recognizer locationInView:scrollView];
    NSInteger cityPoint = (int)ceilf(touchPoint.x/320.0) - 2;

    if (cityPoint >= 0) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil
                                                            message:@"Are you sure you want to delete this trip?"
                                                           delegate:self
                                                  cancelButtonTitle:@"Cancel"
                                                  otherButtonTitles:@"Delete", nil];
        alertView.tag = cityPoint;
        [alertView show];
    }
}

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 1) {
        CityEntity *city = cities[alertView.tag];
        [[TripManager getInstance] deleteHealthItemsWithCity:city];
        [[TripManager getInstance] deleteEmbassyItemsWithCity:city];
        [[TripManager getInstance] deleteCurrencyItemsWithCity:city];
        [[TripManager getInstance] deleteAlertItemsWithCity:city];
        [[TripManager getInstance].managedObjectContext deleteObject:city]; // delete object
        for (id object in scrollView.subviews) {
            [object removeFromSuperview];
        }
        [self loadCities];
    }
}

@end
