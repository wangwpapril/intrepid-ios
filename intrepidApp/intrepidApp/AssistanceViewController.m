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

@interface AssistanceViewController ()

@end

@implementation AssistanceViewController

@synthesize mController;
@synthesize onOff;

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
    self.navigationItem.hidesBackButton = YES;    
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@" " style:UIBarButtonItemStylePlain target:nil action:nil];
    
    [self addContent];
}

- (void) viewWillAppear:(BOOL)animated {
    mController = [MenuController getInstance];
    [mController displayMenuWithParent:self];
}

-(void)addContent {
    //Ambulance Image
    UIImage *ambulance;
    ambulance = [UIImage imageNamed:@"IMG@2x.png"];
    UIImageView *ambulanceImage = [[UIImageView alloc] initWithImage:ambulance];
    ambulanceImage.frame = CGRectMake(0, 0, 320, ambulanceImage.frame.size.height*0.5);
    
    [self.view addSubview:ambulanceImage];
    
    //Current Location and Image
    UIImage *currentLocation;
    currentLocation = [UIImage imageNamed:@"Shape-24@2x.png"];
    UIImageView *currentLocationImage = [[UIImageView alloc] initWithImage:currentLocation];
    currentLocationImage.frame = CGRectMake(15, ambulanceImage.frame.size.height + 25, 21, 20);
    [self.view addSubview:currentLocationImage];
    
    UILabel *currentLocationLabel = [[UILabel alloc] initWithFrame:CGRectMake(50, ambulanceImage.frame.size.height + 25, 250, 20)];
    currentLocationLabel.text = @"Current Location";
    currentLocationLabel.font = [UIFont fontWithName:@"ProximaNova-Bold" size:20];
    currentLocationLabel.backgroundColor = [UIColor clearColor];
    currentLocationLabel.textColor = [UIColor colorWithRed: 66.0/255 green: 58.0/255 blue: 56.0/255 alpha: 1.0];
    [self.view addSubview:currentLocationLabel];
    
    //Map Image
    UIImage *map;
    map = [UIImage imageNamed:@"Map@2x.png"];
    UIImageView *mapImage = [[UIImageView alloc] initWithImage:map];
    mapImage.frame = CGRectMake(0, currentLocationLabel.frame.origin.y + 45, 320, mapImage.frame.size.height*0.5);
    [self.view addSubview:mapImage];
    
    //Provide Location
    
    UILabel *provideLocationLabel = [[UILabel alloc] initWithFrame:CGRectMake(30, mapImage.frame.origin.y + mapImage.frame.size.height + 25, 250, 20)];
    provideLocationLabel.text = @"Provide my Location:";
    provideLocationLabel.font = [UIFont fontWithName:@"ProximaNova-Light" size:21];
    provideLocationLabel.backgroundColor = [UIColor clearColor];
    provideLocationLabel.textColor = [UIColor colorWithRed: 66.0/255 green: 58.0/255 blue: 56.0/255 alpha: 1.0];
    [self.view addSubview:provideLocationLabel];
    
    onOff.frame = CGRectMake(230, mapImage.frame.origin.y + mapImage.frame.size.height + 22, 63, 23);
    [onOff setOnTintColor: [UIColor colorWithRed:84/255.0f green:213/255.0f blue:105/255.0f alpha:1.0f]];
    
    //Call Assistance Button
    UIImage *callAssistanceImage = [UIImage imageNamed:@"Call-Intrepid@2x.png"];
    UIButton *callAssistance = [[UIButton alloc] init];
    [callAssistance setImage:callAssistanceImage forState:UIControlStateNormal];
    callAssistance.frame = CGRectMake(0, provideLocationLabel.frame.origin.y + 45, 320, callAssistance.imageView.image.size.height*0.5);
    [callAssistance addTarget:self
                        action:@selector(callAssistance:)
              forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:callAssistance];
    
}

-(IBAction)callAssistance:(id) sender
{
    NSString *phoneNumber = @"tel:1234567890";
    
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:phoneNumber]];
    
    NSLog(@"Call");
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
