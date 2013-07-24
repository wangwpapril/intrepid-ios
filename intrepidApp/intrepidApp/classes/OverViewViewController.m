//
//  OverViewViewController.m
//  intrepidApp
//
//  Created by Philip Ojha on 7/23/2013.
//  Copyright (c) 2013 JonCarrHarris Consulting. All rights reserved.
//

#import "OverViewViewController.h"
#import "SlidingTextView.h"

@interface OverViewViewController ()

@end

@implementation OverViewViewController

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
    self.navigationItem.title = @"Mexico Overview";
    
    NSInteger height = self.view.bounds.size.height;
    SlidingTextView *history = [[SlidingTextView alloc] initWithFrame:CGRectMake(0, 0, 320, height)];
    [history setupWithImageName:@"MexicoBackBigger.png" withTitle:@"History" withIconName:@"stethoscope-pic.png"];
    
    SlidingTextView *culture = [[SlidingTextView alloc] initWithFrame:CGRectMake(0, 0, 320, height)];
    [culture setupWithImageName:@"MexicoBackBigger.png" withTitle:@"Culture" withIconName:@"stethoscope-pic.png"];
    UIView *green = [[UIView alloc] initWithFrame:CGRectMake(0, 150, 320, height)];
    green.backgroundColor = [UIColor greenColor];
    NSMutableArray *views = [NSMutableArray arrayWithObjects:history, culture, green, nil];
    [self addViews:views withVerticalOffset:0];
    NSLog(@"added views");
    
    NSArray *names = [NSArray arrayWithObjects:@"HISTORY", @"CULTURE", @"CURRENCY", nil];
    NSLog(@"names array made");
    [self addTabs:names];
    NSLog(@"added tabs");
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
