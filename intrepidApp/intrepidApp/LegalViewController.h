//
//  LegalViewController.h
//  intrepidApp
//
//  Created by Ian Page on 2013-08-09.
//  Copyright (c) 2013 JonCarrHarris Consulting. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LegalViewController : UIViewController {
    UIScrollView *scrollView;
}

@property (weak, nonatomic) IBOutlet UIButton *exitButton;

- (IBAction)exit:(id)sender;

@end
