//
//  EmbassyCell.h
//  intrepidApp
//
//  Created by Philip Ojha on 7/28/2013.
//  Copyright (c) 2013 JonCarrHarris Consulting. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EmbassyCell : UITableViewCell


@property (nonatomic, strong) UIImageView *flagLabel;
@property (nonatomic, strong) UILabel *countryLabel;
//@property (nonatomic, strong) UIImageView *arrow;

- (void)setupWithImageName:(NSString *)image withCountry:(NSString *)country;
@end
