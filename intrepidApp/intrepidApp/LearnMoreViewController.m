//
//  LearnMoreViewController.m
//  intrepidApp
//
//  Created by Madelaine Page on 2013-07-29.
//  Copyright (c) 2013 JonCarrHarris Consulting. All rights reserved.
//

#import "LearnMoreViewController.h"

@interface LearnMoreViewController ()

@end

@implementation LearnMoreViewController

@synthesize pageControl;
@synthesize scrollView;
@synthesize exitButton;

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
    
//    [self.navigationController setNavigationBarHidden:YES];

    //set background image
    UIGraphicsBeginImageContext(self.view.frame.size);
    [[UIImage imageNamed:@"login-background"] drawInRect:self.view.bounds];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    self.view.backgroundColor = [UIColor colorWithPatternImage:image];
    
//    UIImageView *backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"login-background"]];
//    [self.view addSubview:backgroundView];
    
    //create title label
    UILabel *learnMoreLabel = [[UILabel alloc] init];
    learnMoreLabel.frame = CGRectMake(85, self.view.frame.origin.y - 35, 150, 150);
    learnMoreLabel.text = @"Learn More";
    learnMoreLabel.font = [UIFont fontWithName:APP_FONT size:24];
    learnMoreLabel.textColor = [UIColor whiteColor];
    learnMoreLabel.backgroundColor = [UIColor clearColor];
    [learnMoreLabel setTextAlignment:NSTextAlignmentCenter];
    [self.view addSubview:learnMoreLabel];
    
    //implement scrollview
    scrollView.delegate = self;
    scrollView.scrollEnabled = YES;
    scrollView.pagingEnabled = YES;
    
    //create array for images
    NSArray *imageArray = [[NSMutableArray alloc] initWithObjects:@"overview", @"health", @"cool", @"assistance-new", nil];
    
    for (int i=0; i < [imageArray count]; i++) {
        CGRect frame;
        NSInteger height = scrollView.frame.size.height - 150.0;
        NSInteger width = height * 0.5634;
        frame.origin.x = 320 * i + (320 - width)/2;
        frame.origin.y = scrollView.frame.origin.y + 75;
        //0.7322;
        frame.size = CGSizeMake(width, height);
                
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:frame];
        imageView.image = [UIImage imageNamed:[imageArray objectAtIndex:i]];
        [scrollView addSubview:imageView];
        
    }
    scrollView.contentSize = CGSizeMake(scrollView.frame.size.width * [imageArray count], 366.0);
    
    [self populateDescriptions];
    
    [self.view addSubview:scrollView];
    exitButton.frame = CGRectMake(280, 32, 40, 40);
    [self.view addSubview:exitButton];
    UIImage *exitImage = [UIImage imageNamed:@"close"];
    //create an image and put it overtop of the button?
    UIImageView *exitImageContainer = [[UIImageView alloc] initWithFrame: CGRectMake(290, 32, 15, 15)];
    [exitImageContainer setImage:exitImage];
    [self.view addSubview:exitImageContainer];
    
    pageControl.frame = CGRectMake(135, self.view.frame.size.height - 40, 50, 50);
    pageControl.numberOfPages = 4;
    pageControl.currentPage = 0;
    pageControl.pageIndicatorTintColor = [UIColor darkGrayColor];
    pageControl.currentPageIndicatorTintColor = [UIColor whiteColor];
    [self.view addSubview:pageControl];
    
    if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"7.0")) {
        
        self.edgesForExtendedLayout = UIRectEdgeNone;
        
    } else {
        [self moveAllSubviewsDown];
    }
}

- (void) moveAllSubviewsDown{
    float barHeight = 45.0;
    for (UIView *view in self.view.subviews) {
        
        if ([view isKindOfClass:[UIScrollView class]]) {
            view.frame = CGRectMake(view.frame.origin.x, view.frame.origin.y + barHeight, view.frame.size.width, view.frame.size.height - barHeight);
        } else {
            view.frame = CGRectMake(view.frame.origin.x, view.frame.origin.y + barHeight, view.frame.size.width, view.frame.size.height);
        }
    }
}

- (void)populateDescriptions {
    UILabel *mexicoEmbassyDescription = [[UILabel alloc] init];
    mexicoEmbassyDescription.frame = CGRectMake(677, self.view.frame.size.height - 175, 250.0, 250.0);
    mexicoEmbassyDescription.font = [UIFont fontWithName:APP_FONT size:13];
    mexicoEmbassyDescription.backgroundColor = [UIColor clearColor];
    mexicoEmbassyDescription.textColor = [UIColor whiteColor];
    [mexicoEmbassyDescription setTextAlignment:NSTextAlignmentCenter];
    mexicoEmbassyDescription.text = @"Security information about the country including safety and embassy details.";
    mexicoEmbassyDescription.numberOfLines = 0;
    mexicoEmbassyDescription.lineBreakMode = NSLineBreakByWordWrapping;
    [scrollView addSubview:mexicoEmbassyDescription];
    
    UILabel *healthOverviewDescription = [[UILabel alloc] init];
    healthOverviewDescription.frame = CGRectMake(345, self.view.frame.size.height - 190, 275.0, 275.0);
    healthOverviewDescription.font = [UIFont fontWithName:APP_FONT size:13];
    healthOverviewDescription.backgroundColor = [UIColor clearColor];
    healthOverviewDescription.textColor = [UIColor whiteColor];
    [healthOverviewDescription setTextAlignment:NSTextAlignmentCenter];
    healthOverviewDescription.text = @"Information about health concerns including prevalent conditions and medications.";
    healthOverviewDescription.numberOfLines = 0;
    healthOverviewDescription.lineBreakMode = NSLineBreakByWordWrapping;
    [scrollView addSubview:healthOverviewDescription];
    
    UILabel *mexicoCultureDescription = [[UILabel alloc] init];
    mexicoCultureDescription.frame = CGRectMake(37, self.view.frame.size.height - 175, 250.0, 250.0);
    mexicoCultureDescription.font = [UIFont fontWithName:APP_FONT size:13];
    mexicoCultureDescription.backgroundColor = [UIColor clearColor];
    mexicoCultureDescription.textColor = [UIColor whiteColor];
    [mexicoCultureDescription setTextAlignment:NSTextAlignmentCenter];
    mexicoCultureDescription.text = @"Information about the history, culture, and currency for the country.";
    mexicoCultureDescription.numberOfLines = 0;
    mexicoCultureDescription.lineBreakMode = NSLineBreakByWordWrapping;
    [scrollView addSubview:mexicoCultureDescription];
    
    UILabel *assistanceScreenDescription = [[UILabel alloc] init];
    assistanceScreenDescription.frame = CGRectMake(995, self.view.frame.size.height - 175, 250.0, 250.0);
    assistanceScreenDescription.font = [UIFont fontWithName:APP_FONT size:13];
    assistanceScreenDescription.backgroundColor = [UIColor clearColor];
    assistanceScreenDescription.textColor = [UIColor whiteColor];
    [assistanceScreenDescription setTextAlignment:NSTextAlignmentCenter];
    assistanceScreenDescription.text = @"Get emergency assistance whenever you need it.";
    assistanceScreenDescription.numberOfLines = 0;
    assistanceScreenDescription.lineBreakMode = NSLineBreakByWordWrapping;
    [scrollView addSubview:assistanceScreenDescription];

}

- (void)scrollViewDidScroll:(UIScrollView *)sender {
    CGFloat pageWidth = self.scrollView.frame.size.width;
    int page = floor((scrollView.contentOffset.x - pageWidth / 2)/pageWidth) +1;
    pageControl.currentPage = page;

}

- (IBAction)exit:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
