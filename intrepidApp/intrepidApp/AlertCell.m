//
//  AlertCell.m
//  intrepidApp
//
//  Created by Chaitanya Shah on 2015-01-23.
//  Copyright (c) 2015 JonCarrHarris Consulting. All rights reserved.
//

#import "AlertCell.h"

@implementation AlertCell

@synthesize categoryLabel;
@synthesize dateLabel;
@synthesize textLabel;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initializeViews];
    }
    return self;
}

- (void)initializeViews {
    UILabel *categoryHeader = [[UILabel alloc] initWithFrame:CGRectMake(15, 15, 75, 25)];
    categoryHeader.font = [UIFont fontWithName:@"ProximaNova-light" size:15];
    categoryHeader.textColor = APP_TEXT_COLOR;
    categoryHeader.text = @"Category: ";
    [self addSubview:categoryHeader];
    
    categoryLabel = [[UILabel alloc] initWithFrame:CGRectMake(90, 15, 225, 25)];
    categoryLabel.font = [UIFont fontWithName: APP_FONT size:15];
    categoryLabel.textColor = APP_TEXT_COLOR;
    [self addSubview:categoryLabel];
    
    UILabel *dateHeader = [[UILabel alloc] initWithFrame:CGRectMake(15, 40, 50, 25)];
    dateHeader.font = [UIFont fontWithName:@"ProximaNova-light" size:15];
    dateHeader.textColor = APP_TEXT_COLOR;
    dateHeader.text = @"Valid: ";
    [self addSubview:dateHeader];
    
    dateLabel = [[UILabel alloc] initWithFrame:CGRectMake(90, 40, 250, 25)];
    dateLabel.font = [UIFont fontWithName:APP_FONT size:15];
    dateLabel.textColor = APP_TEXT_COLOR;
    [self addSubview:dateLabel];
    
    textLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 65, 450, 25)];
    textLabel.font = [UIFont fontWithName:@"ProximaNova-light" size:15];
    textLabel.textColor = APP_TEXT_COLOR;
    textLabel.lineBreakMode = NSLineBreakByWordWrapping;
    textLabel.numberOfLines = 0;
    [self addSubview:textLabel];
}

- (void)setupWithAlert:(AlertEntity *)alert {
    categoryLabel.text = alert.category;
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"MMM d, yyyy"];
    dateLabel.text = [NSString stringWithFormat:@"%@ to %@", [formatter stringFromDate:alert.startDate], [formatter stringFromDate:alert.endDate]];
    
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineBreakMode = NSLineBreakByWordWrapping;
    CGSize size = [alert.text boundingRectWithSize:CGSizeMake(360, CGFLOAT_MAX)
                                        options:NSStringDrawingUsesLineFragmentOrigin
                                     attributes:@{NSParagraphStyleAttributeName:paragraphStyle.copy, NSFontAttributeName:[UIFont fontWithName:@"ProximaNova-light" size:17]}
                                        context:nil].size;
    textLabel.frame = CGRectMake(15, 65, 360, size.height);
    textLabel.text = alert.text;
}

@end
