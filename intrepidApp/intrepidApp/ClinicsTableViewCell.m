//
//  ClinicsTableViewCell.m
//  intrepidApp
//
//  Created by Madelaine Page on 2015-01-10.
//  Copyright (c) 2015 JonCarrHarris Consulting. All rights reserved.
//

#import "ClinicsTableViewCell.h"
#import "Constants.h"

@implementation ClinicsTableViewCell

@synthesize nameLabel = _nameLabel;
@synthesize addressLabel = _addressLabel;
@synthesize locationImage = _locationImage;


- (void)awakeFromNib {
    // Initialization code
    [_nameLabel setFont:[UIFont boldSystemFontOfSize:12]];
    [_addressLabel setFont:[UIFont fontWithName:APP_FONT size:12]];
    _addressLabel.numberOfLines = 0;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
