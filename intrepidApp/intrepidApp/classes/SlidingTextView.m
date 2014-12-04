//
//  SlidingTextView.m
//  intrepidApp
//
//  Created by Philip Ojha on 7/23/2013.
//  Copyright (c) 2013 JonCarrHarris Consulting. All rights reserved.
//

#import "SlidingTextView.h"
#import "QuartzCore/QuartzCore.h"
#import "Constants.h"

@implementation SlidingTextView

//@synthesize scroll;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
    }
    return self;
}

-(void)setupWithImageName:(NSString *)image withTitle:(NSString *)title withIconName:(NSString *)icon {
    
//    CGRect rect=CGRectMake(0, 0, 320, 480);
    scroll = [[UIScrollView alloc] initWithFrame:self.frame];
    scroll.showsVerticalScrollIndicator = YES;
    scroll.showsHorizontalScrollIndicator = NO;
    scroll.scrollEnabled = YES;
    
    // top image
    UIImageView  *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:image]];
    imageView.frame = CGRectMake(0, 0, 320, 268);
    [scroll addSubview:imageView];
    
    // title background
    UIView *borderLine = [[UIView alloc] initWithFrame:CGRectMake(0, 268, 320, 40)];
    borderLine.layer.borderColor = [UIColor colorWithRed:231.0/255 green:238.0/255 blue:226.0/255 alpha:1].CGColor;
    borderLine.layer.borderWidth = 1;
    
    // actual title
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(53, 0, 159, 40)];
    titleLabel.text = title;
    titleLabel.font = [UIFont fontWithName:@"ProximaNova-SemiBold" size:17];
    titleLabel.textColor = APP_TEXT_COLOR;
    [borderLine addSubview:titleLabel];
    [scroll addSubview:borderLine];
    
    // icon
    UIImageView *iconView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:icon]];
    iconView.frame = CGRectMake(14, 275, 25, 25);
    [scroll addSubview:iconView];
    
    [self addSubview:scroll];
    
}

- (void)addTableViewWithRows:(NSInteger)rows withTableView:(UITableView *)tableView {
    NSInteger height = 45 * rows;
    tableView.scrollEnabled = NO;
    tableView.frame = CGRectMake(tableView.frame.origin.x, tableView.frame.origin.y, 320, height);
    [self addSubview:tableView];
    self.contentSize = CGSizeMake(320, 330 + height); // was 308
}

- (void)addTextAreaWithText:(NSString *)text {
    
    UIFont *textFont = [UIFont fontWithName:@"ProximaNova-Light" size:15];
    
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineBreakMode = NSLineBreakByWordWrapping;
    
    CGSize size = [text boundingRectWithSize:CGSizeMake(280, 15000)
                                     options:NSStringDrawingUsesLineFragmentOrigin
                                  attributes:@{NSParagraphStyleAttributeName:paragraphStyle.copy, NSFontAttributeName:[UIFont fontWithName:@"ProximaNova-Light" size:15]}
                                     context:nil].size;
    
    UILabel *textView = [[UILabel alloc] initWithFrame:CGRectMake(20, 5,  280, size.height + 5)];
    textView.textColor = APP_TEXT_COLOR;
    textView.font = textFont;
    textView.text = text;
    textView.lineBreakMode = NSLineBreakByWordWrapping;
    textView.numberOfLines = 0;
    
    UILabel *textViewContainer = [[UILabel alloc] initWithFrame:CGRectMake(0, 308,  320, size.height + 10)];

    [textViewContainer addSubview: textView];
    [scroll addSubview:textViewContainer];
    scroll.contentSize = CGSizeMake(320, 308 + textViewContainer.frame.size.height + 75); // used to be 5 but impossible to read last few lines
}

@end
