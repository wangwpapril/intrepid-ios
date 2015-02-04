//
//  LegalViewController.m
//  intrepidApp
//
//  Created by Ian Page on 2013-08-09.
//  Copyright (c) 2013 JonCarrHarris Consulting. All rights reserved.
//

#import "LegalViewController.h"

@interface LegalViewController ()

@end

@implementation LegalViewController

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
    
    UIGraphicsBeginImageContext(self.view.frame.size);
    [[UIImage imageNamed:@"login-background"] drawInRect:self.view.bounds];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    self.view.backgroundColor = [UIColor colorWithPatternImage:image];
    
    //create title label
    UILabel *legalLabel = [[UILabel alloc] init];
    legalLabel.frame = CGRectMake(40, self.view.frame.origin.y - 35, 240, 150);
    legalLabel.text = @"Terms of Use";
    legalLabel.font = [UIFont fontWithName:APP_FONT size:24];
    legalLabel.textColor = [UIColor whiteColor];
    legalLabel.backgroundColor = [UIColor clearColor];
    [legalLabel setTextAlignment:NSTextAlignmentCenter];
    [self.view addSubview:legalLabel];
    
    exitButton.frame = CGRectMake(280, 32, 40, 40);
    [self.view addSubview:exitButton];
    UIImage *exitImage = [UIImage imageNamed:@"close"];
    //create an image and put it overtop of the button?
    UIImageView *exitImageContainer = [[UIImageView alloc] initWithFrame: CGRectMake(290, 32, 15, 15)];
    [exitImageContainer setImage:exitImage];
    [self.view addSubview:exitImageContainer];
    
    CGRect rect = CGRectMake(0, 75, 320, self.view.frame.size.height);
    scrollView = [[UIScrollView alloc] initWithFrame:rect];
    scrollView.showsVerticalScrollIndicator = YES;
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.scrollEnabled = YES;
    
    
    UITextView *legal = [[UITextView alloc] initWithFrame:CGRectMake(0, 10, 320, 2450)];
    legal.text = [self fetchLegal];
    legal.editable = NO;
    legal.selectable = NO;
    legal.font = [UIFont fontWithName:@"ProximaNova-Light" size:13];
    legal.backgroundColor = [UIColor clearColor];
    legal.scrollEnabled = NO;
    legal.textColor = [UIColor whiteColor];
    legal.textAlignment = NSTextAlignmentCenter;
    [legal sizeToFit];
    [legal layoutIfNeeded];
    
    [scrollView addSubview:legal];
    
    [self.view addSubview:scrollView];
    scrollView.contentSize = CGSizeMake(320, legal.frame.size.height + 80);
}

- (void)moveAllSubviewsDown {
    float barHeight = 45.0;
    for (UIView *view in self.view.subviews) {
        
        if ([view isKindOfClass:[UIScrollView class]]) {
            view.frame = CGRectMake(view.frame.origin.x, view.frame.origin.y + barHeight, view.frame.size.width, view.frame.size.height - barHeight);
        } else {
            view.frame = CGRectMake(view.frame.origin.x, view.frame.origin.y + barHeight, view.frame.size.width, view.frame.size.height);
        }
    }
}

- (IBAction)exit:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - Helper methods

- (NSString *)fetchLegal {
    NSURL *requestURL = [NSURL URLWithString:[NSString stringWithFormat:@"%@companies/52525252/legal", BASE_URL]];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:requestURL];
    request.HTTPMethod = @"GET";
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
    NSURLResponse *response = nil;
    NSError *error = nil;
    NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    if (!error) {
        NSDictionary *responseObject = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        return responseObject[@"company"][@"legal"];
    } else {
        NSLog(@"error: %@", error.localizedDescription);
        return @"Not available at this time.";
    }
}

@end
