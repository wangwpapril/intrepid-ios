//
//  AssistanceViewController.m
//  intrepidApp
//
//  Created by Ian Page on 2013-08-04.
//  Copyright (c) 2013 JonCarrHarris Consulting. All rights reserved.
//

#import "AssistanceViewController.h"
#import "MenuController.h"
#import "Constants.h"

@implementation AssistanceViewController

@synthesize mController;
@synthesize onOff;

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
    
    //Provide Location
    UILabel *provideLocationLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, ambulanceImage.frame.origin.y + ambulanceImage.frame.size.height + 10, 250, 20)];
    provideLocationLabel.text = @"Current Location:";
    provideLocationLabel.font = [UIFont fontWithName:@"ProximaNova-Light" size:21];
    provideLocationLabel.backgroundColor = [UIColor clearColor];
    provideLocationLabel.textColor = [UIColor colorWithRed:0.2 green:0.25 blue:0.28 alpha:1];
    [scrollView addSubview:provideLocationLabel];
    
    onOff.frame = CGRectMake(230, ambulanceImage.frame.origin.y + ambulanceImage.frame.size.height + 7, 63, 23);
    [onOff setOnTintColor: [UIColor clearColor]];
    [scrollView addSubview:onOff];
    
    //Map Image
    UIImage *map;
    map = [UIImage imageNamed:@"Map"];
    UIImageView *mapImage = [[UIImageView alloc] initWithImage:map];
    mapImage.frame = CGRectMake(0, provideLocationLabel.frame.origin.y + 30, 320, mapImage.frame.size.height*1);
    [scrollView addSubview:mapImage];
    
    
    //Call Assistance Button
        UIButton *callAssistance = [[UIButton alloc] init];
    // [callAssistance setImage:callAssistanceImage forState:UIControlStateNormal];
    callAssistance.backgroundColor = [UIColor colorWithRed:0.53 green:0.73 blue:0.14 alpha:1];
    callAssistance.frame = CGRectMake(0, mapImage.frame.origin.y + mapImage.frame.size.height - 2, 320, 128*0.5);
    callAssistance.titleLabel.font = [UIFont fontWithName:@"ProximaNova-Regular" size:21];
    callAssistance.tintColor = [UIColor clearColor];
    [callAssistance setTitleColor: [UIColor colorWithRed:1 green:1 blue:1 alpha:1] forState:UIControlStateNormal];
    [callAssistance setTitle:@"Contact ACE Assistance" forState:UIControlStateNormal];

    [callAssistance addTarget:self
                        action:@selector(callAssistance:)
              forControlEvents:UIControlEventTouchUpInside];
    [scrollView addSubview:callAssistance];
    
    scrollView.contentSize = CGSizeMake(320, callAssistance.frame.origin.y + callAssistance.frame.size.height + 50);    
}

-(IBAction)callAssistance:(id) sender
{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"telprompt://14166463107"]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
