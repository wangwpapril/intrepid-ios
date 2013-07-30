//
//  SlidingTextView.h
//  intrepidApp
//
//  Created by Philip Ojha on 7/23/2013.
//  Copyright (c) 2013 JonCarrHarris Consulting. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SlidingTextView : UIScrollView

//@property (nonatomic, strong) UIScrollView *scroll;

-(void)setupWithImageName:(NSString *)image withTitle:(NSString *)title withIconName:(NSString *)icon;
- (void)addTextAreaWithText:(NSString *)text;
@end
