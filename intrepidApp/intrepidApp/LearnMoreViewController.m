//
//  LearnMoreViewController.m
//  intrepidApp
//
//  Created by Madelaine Page on 2013-07-29.
//  Copyright (c) 2013 JonCarrHarris Consulting. All rights reserved.
//

#import "LearnMoreViewController.h"
#import "Constants.h"

@interface LearnMoreViewController ()

@end

@implementation LearnMoreViewController

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
    
    [self.navigationController setNavigationBarHidden:YES];
    
    UIImageView *backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"login-background.png"]];
    [self.view addSubview:backgroundView];
    
    //create title label
    UILabel *learnMoreLabel = [[UILabel alloc] init];
    learnMoreLabel.frame = CGRectMake(85, self.view.frame.origin.y - 65, 150, 150);
    learnMoreLabel.text = @"Learn More";
    learnMoreLabel.font = [UIFont fontWithName:@"ProximaNova-Regular" size:24];
    learnMoreLabel.textColor = [UIColor colorWithRed:231/255.0f green:238/255.0f blue:226/255.0f alpha:1.0f];
    learnMoreLabel.backgroundColor = [UIColor clearColor];
    [learnMoreLabel setTextAlignment:NSTextAlignmentCenter];
    [self.view addSubview:learnMoreLabel];
    
    //implement scrollview
    scrollView.delegate = self;
    scrollView.scrollEnabled = YES;
    scrollView.pagingEnabled = YES;
    
    //create array for images
    NSArray *imageArray = [[NSMutableArray alloc] initWithObjects:@"mexico-embassy@2x.png", @"health-screen@2x.png", @"mexico-culture@2x.png", @"miami.png", nil];
    
    for (int i=0; i < [imageArray count]; i++) {
        CGRect frame;
        frame.origin.x = (scrollView.frame.size.width) * i + 45;
        frame.origin.y = scrollView.frame.origin.y + 55;
        frame.size = CGSizeMake(234, scrollView.frame.size.height - 182.0);
        
        
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:frame];
        imageView.image = [UIImage imageNamed:[imageArray objectAtIndex:i]];
        [scrollView addSubview:imageView];
        
    }
    scrollView.contentSize = CGSizeMake(scrollView.frame.size.width * [imageArray count], 366.0);
    
    [self populateDescriptions];
    
    [self.view addSubview:scrollView];
    
    pageControl.frame = CGRectMake(135, self.view.frame.size.height - 75, 50, 50);
    pageControl.numberOfPages = 4;
    pageControl.currentPage = 0;
    pageControl.pageIndicatorTintColor = [UIColor darkGrayColor];
    pageControl.currentPageIndicatorTintColor = [UIColor whiteColor];
    [self.view addSubview:pageControl];
    
    
}

-(void)populateDescriptions {
    UILabel *mexicoEmbassyDescription = [[UILabel alloc] init];
    mexicoEmbassyDescription.frame = CGRectMake(37, self.view.frame.size.height - 220, 250.0, 250.0);
    mexicoEmbassyDescription.font = [UIFont fontWithName:@"ProximaNova-Regular" size:13];
    mexicoEmbassyDescription.backgroundColor = [UIColor clearColor];
    mexicoEmbassyDescription.textColor = [UIColor whiteColor];
    [mexicoEmbassyDescription setTextAlignment:NSTextAlignmentCenter];
    mexicoEmbassyDescription.text = @"Information about the local, political, and embassies for the country";
    mexicoEmbassyDescription.numberOfLines = 0;
    mexicoEmbassyDescription.lineBreakMode = NSLineBreakByWordWrapping;
    [scrollView addSubview:mexicoEmbassyDescription];
    
    UILabel *healthOverviewDescription = [[UILabel alloc] init];
    healthOverviewDescription.frame = CGRectMake(345, self.view.frame.size.height - 225, 275.0, 275.0);
    healthOverviewDescription.font = [UIFont fontWithName:@"ProximaNova-Regular" size:13];
    healthOverviewDescription.backgroundColor = [UIColor clearColor];
    healthOverviewDescription.textColor = [UIColor whiteColor];
    [healthOverviewDescription setTextAlignment:NSTextAlignmentCenter];
    healthOverviewDescription.text = @"Information about health concerns for the country including symptoms and treatments available.";
    healthOverviewDescription.numberOfLines = 0;
    healthOverviewDescription.lineBreakMode = NSLineBreakByWordWrapping;
    [scrollView addSubview:healthOverviewDescription];
    
    UILabel *mexicoCultureDescription = [[UILabel alloc] init];
    mexicoCultureDescription.frame = CGRectMake(677, self.view.frame.size.height - 220, 250.0, 250.0);
    mexicoCultureDescription.font = [UIFont fontWithName:@"ProximaNova-Regular" size:13];
    mexicoCultureDescription.backgroundColor = [UIColor clearColor];
    mexicoCultureDescription.textColor = [UIColor whiteColor];
    [mexicoCultureDescription setTextAlignment:NSTextAlignmentCenter];
    mexicoCultureDescription.text = @"Information about the history, culture, and currency for the country.";
    mexicoCultureDescription.numberOfLines = 0;
    mexicoCultureDescription.lineBreakMode = NSLineBreakByWordWrapping;
    [scrollView addSubview:mexicoCultureDescription];
    
    UILabel *assistanceScreenDescription = [[UILabel alloc] init];
    assistanceScreenDescription.frame = CGRectMake(980, self.view.frame.size.height - 220, 250.0, 250.0);
    assistanceScreenDescription.font = [UIFont fontWithName:@"ProximaNova-Regular" size:13];
    assistanceScreenDescription.backgroundColor = [UIColor clearColor];
    assistanceScreenDescription.textColor = [UIColor whiteColor];
    [assistanceScreenDescription setTextAlignment:NSTextAlignmentCenter];
    assistanceScreenDescription.text = @"Placeholder for Assistance Screen";
    assistanceScreenDescription.numberOfLines = 0;
    assistanceScreenDescription.lineBreakMode = NSLineBreakByWordWrapping;
    [scrollView addSubview:assistanceScreenDescription];
}

-(void)scrollViewDidScroll:(UIScrollView *)sender {
    CGFloat pageWidth = self.scrollView.frame.size.width;
    int page = floor((scrollView.contentOffset.x - pageWidth / 2)/pageWidth) +1;
    pageControl.currentPage = page;

}
- (void)viewWillAppear:(BOOL)animated
{
    
    [self.navigationController setNavigationBarHidden:YES animated:animated];
    [super viewWillAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    
    [self.navigationController setNavigationBarHidden:NO animated:animated];
    [super viewWillDisappear:animated];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
