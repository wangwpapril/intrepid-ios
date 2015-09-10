//
//  PPNEntity.h
//  intrepidApp
//
//  Created by Will Wang on 2015-09-10.
//  Copyright (c) 2015 Ingle International. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface PPNEntity : NSManagedObject

@property (nonatomic, retain) NSString * id;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * type;
@property (nonatomic, retain) NSString * content;
@property (nonatomic, retain) NSString * longitude;
@property (nonatomic, retain) NSString * latitude;
@property (nonatomic, retain) NSString * postal;
@property (nonatomic, retain) NSString * address;
@property (nonatomic, retain) NSString * contact;
@property (nonatomic, retain) NSString * staffName;

@end
