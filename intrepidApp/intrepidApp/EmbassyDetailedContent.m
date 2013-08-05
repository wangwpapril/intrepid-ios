//
//  EmbassyDetailedContent.m
//  intrepidApp
//
//  Created by Jon Carr-Harris on 7/30/2013.
//  Copyright (c) 2013 JonCarrHarris Consulting. All rights reserved.
//

#import "EmbassyDetailedContent.h"
#import "EmbassyItem.h"

@implementation EmbassyDetailedContent

-(NSArray *)getContent {
    
    EmbassyItem *item1 = [[EmbassyItem alloc] init];
    item1.flag = @"USD.png";
    item1.name = @"United States";
    
    EmbassyItem *item2 = [[EmbassyItem alloc] init];
    item2.flag = @"CAD.png";
    item2.name = @"Canada";
    
    EmbassyItem *item3 = [[EmbassyItem alloc] init];
    item3.flag = @"GBP.png";
    item3.name = @"United Kingdom";
    
    EmbassyItem *item4 = [[EmbassyItem alloc] init];
    item4.flag = @"BRL.png";
    item4.name = @"Brazil";
    
    EmbassyItem *item5 = [[EmbassyItem alloc] init];
    item5.flag = @"EUR.png";
    item5.name = @"European Union";
    
    EmbassyItem *item6 = [[EmbassyItem alloc] init];
    item6.flag = @"CHF.png";
    item6.name = @"Switzerland";
    
    EmbassyItem *item7 = [[EmbassyItem alloc] init];
    item7.flag = @"CNY.png";
    item7.name = @"China";
    
    EmbassyItem *item8 = [[EmbassyItem alloc] init];
    item8.flag = @"INR.png";
    item8.name = @"India";
    
    EmbassyItem *item9 = [[EmbassyItem alloc] init];
    item9.flag = @"THB.png";
    item9.name = @"Thailand";
    
    EmbassyItem *item10 = [[EmbassyItem alloc] init];
    item10.flag = @"AUS.png";
    item10.name = @"Australia";
    
    EmbassyItem *item11 = [[EmbassyItem alloc] init];
    item11.flag = @"MYR.png";
    item11.name = @"Malaysia";
    
    EmbassyItem *item12 = [[EmbassyItem alloc] init];
    item12.flag = @"DOP.png";
    item12.name = @"Dominican Republic";
    
    EmbassyItem *item13 = [[EmbassyItem alloc] init];
    item13.flag = @"MXN.png";
    item13.name = @"Mexico";
        
    return [NSArray arrayWithObjects:item1, item2, item3, item4, item5, item6, item7, item8, item9, item10, item11, item12, item13, nil];
}

@end
