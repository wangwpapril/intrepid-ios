//
//  SlidingTableView.h
//  intrepidApp
//
//  Created by Philip Ojha on 7/23/2013.
//  Copyright (c) 2013 JonCarrHarris Consulting. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SlidingTableView : UIView <UITableViewDelegate, UITableViewDataSource>


@property (nonatomic, strong) UITableView *tableList;
@property (nonatomic, strong) NSArray *dataArray;

- (void)setupWithImageName:(NSString *)image withTitle:(NSString *)title withIconName:(NSString *)icon withArray:(NSArray *)array;
@end
