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

@implementation MyTripsViewController

@synthesize mController;
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
    
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@" " style:UIBarButtonItemStylePlain target:nil action:nil];
    
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
    NSArray *imageArray = [[NSMutableArray alloc] initWithObjects:@"new-trip.png", @"NMexico@2x.png", @"Guada@2x.png", @"miami@2x.png", @"Puerto-Plata@2x.png", nil];
    NSArray *nameArray = [[NSMutableArray alloc] initWithObjects:@" ", @"Mexico City", @"Guadalajara", @"Miami", @"Puerto Plata", nil];
    NSInteger height = scrollView.frame.size.height - 150.0;
    NSInteger width = height * 0.7322;
    for (int i=0; i < [imageArray count]; i++) {
        CGRect frame;
        frame.origin.x = 320 * i + (320 - width)/2;
        frame.origin.y = scrollView.frame.origin.y + 15;
        
        frame.size = CGSizeMake(width, height);
        
        
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:frame];
        imageView.image = [UIImage imageNamed:[imageArray objectAtIndex:i]];
        [scrollView addSubview:imageView];
        
        
        if (i == 0) {
            UIButton *toTrips = [UIButton buttonWithType:UIButtonTypeCustom];
            toTrips.frame = imageView.frame;
            [toTrips addTarget:self action:@selector(toTrips) forControlEvents:UIControlEventTouchUpInside];
            [scrollView addSubview:toTrips];       
        }
        else {
            UIButton *toSecurity = [UIButton buttonWithType:UIButtonTypeCustom];
            toSecurity.frame = imageView.frame;
            [toSecurity addTarget:self action:@selector(toSecurity) forControlEvents:UIControlEventTouchUpInside];
            [scrollView addSubview:toSecurity];
        }
    }
    
    UILabel *mexicoCityName = [[UILabel alloc] init];
    mexicoCityName.frame = CGRectMake(430, self.view.frame.size.height - 160, 100.0, 100.0);
    mexicoCityName.font = [UIFont fontWithName:@"ProximaNova-Regular" size:18];
    mexicoCityName.backgroundColor = [UIColor clearColor];
    mexicoCityName.textColor = [UIColor whiteColor];
    [mexicoCityName setTextAlignment:NSTextAlignmentCenter];
    mexicoCityName.text = @"Mexico City";
    [scrollView addSubview:mexicoCityName];
    
    UILabel *guadaCityName = [[UILabel alloc] init];
    guadaCityName.frame = CGRectMake(750, self.view.frame.size.height - 160, 100.0, 100.0);
    guadaCityName.font = [UIFont fontWithName:@"ProximaNova-Regular" size:18];
    guadaCityName.backgroundColor = [UIColor clearColor];
    guadaCityName.textColor = [UIColor whiteColor];
    [guadaCityName setTextAlignment:NSTextAlignmentCenter];
    guadaCityName.text = @"Guadalajara";
    [scrollView addSubview:guadaCityName];
    
    UILabel *miamiCityName = [[UILabel alloc] init];
    miamiCityName.frame = CGRectMake(1070, self.view.frame.size.height - 160, 100.0, 100.0);
    miamiCityName.font = [UIFont fontWithName:@"ProximaNova-Regular" size:18];
    miamiCityName.backgroundColor = [UIColor clearColor];
    miamiCityName.textColor = [UIColor whiteColor];
    [miamiCityName setTextAlignment:NSTextAlignmentCenter];
    miamiCityName.text = @"Miami";
    [scrollView addSubview:miamiCityName];
    
    UILabel *puertoplataCityName = [[UILabel alloc] init];
    puertoplataCityName.frame = CGRectMake(1390, self.view.frame.size.height - 160, 100.0, 100.0);
    puertoplataCityName.font = [UIFont fontWithName:@"ProximaNova-Regular" size:18];
    puertoplataCityName.backgroundColor = [UIColor clearColor];
    puertoplataCityName.textColor = [UIColor whiteColor];
    [puertoplataCityName setTextAlignment:NSTextAlignmentCenter];
    puertoplataCityName.text = @"Puerto Plata";
    [scrollView addSubview:puertoplataCityName];
    
    scrollView.contentSize = CGSizeMake(scrollView.frame.size.width * [imageArray count], 366.0);
    
    [self.view addSubview:scrollView];
    
    pageControl.frame = CGRectMake(135, self.view.frame.size.height - 100, 50, 50);
    pageControl.numberOfPages = 5;
    pageControl.currentPage = 0;
    pageControl.pageIndicatorTintColor = [UIColor darkGrayColor];
    pageControl.currentPageIndicatorTintColor = [UIColor whiteColor];
    [self.view addSubview:pageControl];
    
}

-(void)toTrips {
    UIViewController *viewController = [self.storyboard instantiateViewControllerWithIdentifier:@"trips"];
    [self.navigationController pushViewController:viewController animated:YES];
}

-(void)toSecurity {
    UIViewController *viewController = [self.storyboard instantiateViewControllerWithIdentifier:@"security"];
    [self.navigationController pushViewController:viewController animated:YES];
}

-(void)cityNames {
    city = [[NSMutableArray alloc] init];
    [city addObject:@" "];
    [city addObject:@"Mexico City"];
    [city addObject:@"Guadalajara"];
    [city addObject:@"Miami"];
    [city addObject:@"Puerto Plata"];
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

/* - (void)viewWillAppear:(BOOL)animated
{
    
    [self.navigationController setNavigationBarHidden:YES animated:animated];
    [super viewWillAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    
    [self.navigationController setNavigationBarHidden:NO animated:animated];
    [super viewWillDisappear:animated];
}
 */

@end
