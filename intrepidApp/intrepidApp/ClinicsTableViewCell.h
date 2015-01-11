//
//  ClinicsTableViewCell.h
//  intrepidApp
//
//  Created by Madelaine Page on 2015-01-10.
//  Copyright (c) 2015 JonCarrHarris Consulting. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ClinicsTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *locationImage;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;



@end
