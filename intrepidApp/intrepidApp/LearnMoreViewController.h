//
//  LearnMoreViewController.h
//  intrepidApp
//
//  Created by Madelaine Page on 2013-07-29.
//  Copyright (c) 2013 JonCarrHarris Consulting. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LearnMoreViewController : UIViewController

@property (nonatomic, weak) IBOutlet UIScrollView *scrollView;
@property (nonatomic, weak) IBOutlet UIPageControl *pageControl;

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event;


@end
