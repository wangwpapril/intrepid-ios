//
//  AssistanceViewController.m
//  intrepidApp
//
//  Created by Ian Page on 2013-08-04.
//  Copyright (c) 2013 JonCarrHarris Consulting. All rights reserved.
//

#import "AssistanceViewController.h"
#import "MenuController.h"
#import "TripManager.h"

@implementation AssistanceViewController

@synthesize mController;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.tag = 6;
    self.navigationItem.hidesBackButton = YES;    
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@" " style:UIBarButtonItemStylePlain target:nil action:nil];
    
    CGRect rect=CGRectMake(0, 0, 320, self.view.frame.size.height);
    scrollView = [[UIScrollView alloc] initWithFrame:rect];
    scrollView.showsVerticalScrollIndicator = YES;
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.scrollEnabled = YES;
    
    [self addContent];
    [self.view addSubview:scrollView];
}

- (void) viewWillAppear:(BOOL)animated {
    mController = [MenuController getInstance];
    [mController displayMenuWithParent:self];
}

-(void)addContent {
    //Ambulance Image
    UIImage *ambulance;
    ambulance = [UIImage imageNamed:@"ambulance"];
    UIImageView *ambulanceImage = [[UIImageView alloc] initWithImage:ambulance];
    ambulanceImage.frame = CGRectMake(0, 0, 320, ambulanceImage.frame.size.height*1);
    [scrollView addSubview:ambulanceImage];
    
    
    UILabel *provideLocationLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, ambulanceImage.frame.origin.y + ambulanceImage.frame.size.height + 15, 250, 20)];
    provideLocationLabel.text = @"My Current Location";
    provideLocationLabel.font = [UIFont fontWithName:@"ProximaNova-Regular" size:18];
    provideLocationLabel.backgroundColor = [UIColor clearColor];
    provideLocationLabel.textColor = [UIColor colorWithRed:0.2 green:0.25 blue:0.28 alpha:1];
    [scrollView addSubview:provideLocationLabel];
    
    MKMapView *mapView = [[MKMapView alloc] initWithFrame:CGRectMake(0, ambulanceImage.frame.origin.y+20 + ambulanceImage.frame.size.height + 30, 320, 200)];
    mapView.showsUserLocation = YES;
    mapView.userTrackingMode = MKUserTrackingModeFollow;
    [scrollView addSubview:mapView];
    
    //Call Assistance Button
        UIButton *callAssistance = [[UIButton alloc] init];
    // [callAssistance setImage:callAssistanceImage forState:UIControlStateNormal];
    callAssistance.backgroundColor = [UIColor colorWithRed:0.53 green:0.73 blue:0.14 alpha:1];
    callAssistance.frame = CGRectMake(0, mapView.frame.origin.y + mapView.frame.size.height - 2, 320, 128*0.5);
    callAssistance.titleLabel.font = [UIFont fontWithName:APP_FONT size:21];
    callAssistance.tintColor = [UIColor clearColor];
    [callAssistance setTitleColor: [UIColor colorWithRed:1 green:1 blue:1 alpha:1] forState:UIControlStateNormal];
    [callAssistance setTitle:@"Contact ACE Assistance" forState:UIControlStateNormal];

    [callAssistance addTarget:self
                        action:@selector(callAssistance)
              forControlEvents:UIControlEventTouchUpInside];
    [scrollView addSubview:callAssistance];
    
    scrollView.contentSize = CGSizeMake(320, callAssistance.frame.origin.y + callAssistance.frame.size.height + 50);    
}

- (void)callAssistance
{
    NSArray *providers = [TripManager getInstance].currentUser[@"user"][@"company"][@"assistance_providers"];
    if (providers.count > 1) {
        UIActionSheet *assitanceSheet = [[UIActionSheet alloc] init];
        assitanceSheet.title = @"Call";
        assitanceSheet.delegate = self;
        for (id assistance in providers) {
            [assitanceSheet addButtonWithTitle:assistance[@"phone"]];
        }
        assitanceSheet.cancelButtonIndex = [assitanceSheet addButtonWithTitle:@"Cancel"];
        [assitanceSheet showInView:self.view];
    } else if (providers.count == 1) {
        NSString *formattedNum = [providers[0][@"phone"] stringByReplacingOccurrencesOfString:@" " withString:@""];
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"telprompt://%@", formattedNum]]];
    } else {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Sorry"
                                                            message:@"There are no ACE Assistance providers available to help you."
                                                           delegate:nil
                                                  cancelButtonTitle:@"OK"
                                                  otherButtonTitles:nil];
        [alertView show];
    }
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    NSString *formattedNum = [[actionSheet buttonTitleAtIndex:buttonIndex] stringByReplacingOccurrencesOfString:@" " withString:@""];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel://%@", formattedNum]]];
}

@end
