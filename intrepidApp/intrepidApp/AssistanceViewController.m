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

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [[SEGAnalytics sharedAnalytics] screen:@"Assistance"];
    
    mController = [MenuController getInstance];
    [mController displayMenuWithParent:self];
}

-(void)addContent {
    int y = 0;
    
//    // Ambulance Image
//    UIImage *ambulance;
//    ambulance = [UIImage imageNamed:@"ambulance"];
//    UIImageView *ambulanceImage = [[UIImageView alloc] initWithImage:ambulance];
//    ambulanceImage.frame = CGRectMake(0, y, 320, ambulanceImage.frame.size.height*1);
//    [scrollView addSubview:ambulanceImage];
//    y = ambulanceImage.frame.origin.y + ambulanceImage.frame.size.height;
    
    // User Location Map
    MKMapView *mapView = [[MKMapView alloc] initWithFrame:CGRectMake(0, y, 320, 200)];
    mapView.showsUserLocation = YES;
    mapView.userTrackingMode = MKUserTrackingModeFollow;
    [scrollView addSubview:mapView];
    y = mapView.frame.origin.y + mapView.frame.size.height;
    
    // Instructional Text
    TripManager *manager = [TripManager getInstance];
    if (manager.currentUser[@"user"][@"company"][@"content"] != [NSNull null] && ![manager.currentUser[@"user"][@"company"][@"content"] isEqual:@""]) {
        if (manager.currentUser[@"user"][@"company"][@"content"][@"instructional_text"] != [NSNull null] && ![manager.currentUser[@"user"][@"company"][@"content"][@"instructional_text"] isEqual:@""]) {
            NSString *instructionalText = [TripManager getInstance].currentUser[@"user"][@"company"][@"content"][@"instructional_text"];
            UILabel *textLabel = [[UILabel alloc] init];
            textLabel.font = [UIFont fontWithName:APP_FONT size:15];
            textLabel.textColor = APP_TEXT_COLOR;
            textLabel.lineBreakMode = NSLineBreakByWordWrapping;
            textLabel.numberOfLines = 0;

            NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
            paragraphStyle.lineBreakMode = NSLineBreakByWordWrapping;
            CGSize size = [instructionalText boundingRectWithSize:CGSizeMake(300, CGFLOAT_MAX)
                                                   options:NSStringDrawingUsesLineFragmentOrigin
                                                attributes:@{NSParagraphStyleAttributeName:paragraphStyle.copy, NSFontAttributeName:[UIFont fontWithName:@"ProximaNova-Light" size:16]}
                                                   context:nil].size;
            textLabel.frame = CGRectMake(15, y + 15, 300, size.height);
            textLabel.font = [UIFont fontWithName:@"ProximaNova-Light" size:16];
            textLabel.backgroundColor = [UIColor clearColor];
            textLabel.textColor = APP_TEXT_COLOR;
            textLabel.text = instructionalText;
            [scrollView addSubview:textLabel];
            y = textLabel.frame.origin.y + textLabel.frame.size.height + 15;
        }
    }
    
    // Call Assistance Button
    UIButton *callAssistance = [[UIButton alloc] init];
    // [callAssistance setImage:callAssistanceImage forState:UIControlStateNormal];
    callAssistance.backgroundColor = [UIColor colorWithRed:0.92 green:0.31 blue:0.25 alpha:1];
    callAssistance.frame = CGRectMake(0, y, 320, 128*0.5);
    callAssistance.titleLabel.font = [UIFont fontWithName:APP_FONT size:21];
    callAssistance.tintColor = [UIColor clearColor];
    [callAssistance setTitleColor: [UIColor colorWithRed:1 green:1 blue:1 alpha:1] forState:UIControlStateNormal];
    [callAssistance setTitle:@"Call Intrepid Assistance" forState:UIControlStateNormal];
    [callAssistance addTarget:self
                       action:@selector(callAssistance)
             forControlEvents:UIControlEventTouchUpInside];
    [scrollView addSubview:callAssistance];
    y = callAssistance.frame.origin.y + callAssistance.frame.size.height;
    
    scrollView.contentSize = CGSizeMake(320, y + 75);
}

- (void)callAssistance
{
    NSArray *providers = [TripManager getInstance].currentUser[@"user"][@"company"][@"assistance_providers"];
    if (providers.count > 0) {
        UIActionSheet *assitanceSheet = [[UIActionSheet alloc] init];
        assitanceSheet.title = @"Call";
        assitanceSheet.delegate = self;
        for (id assistance in providers) {
            NSString *formattedNum = [assistance[@"phone"] stringByReplacingOccurrencesOfString:@" " withString:@""];
            [assitanceSheet addButtonWithTitle:[NSString stringWithFormat:@"%@ (%@)", assistance[@"name"], formattedNum]];
        }
        assitanceSheet.cancelButtonIndex = [assitanceSheet addButtonWithTitle:@"Cancel"];
        [assitanceSheet showInView:self.view];
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
    if (buttonIndex != actionSheet.cancelButtonIndex) {
        NSArray *providers = [TripManager getInstance].currentUser[@"user"][@"company"][@"assistance_providers"];
        NSString *formattedNum = [providers[buttonIndex][@"phone"] stringByReplacingOccurrencesOfString:@" " withString:@""];
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel://%@", formattedNum]]];
    }
}

@end
