//
//  MapViewAnnotation.h
//  intrepidApp
//
//  Created by WeiPing Wang on 2015-09-15.
//  Copyright (c) 2015 JonCarrHarris Consulting. All rights reserved.
//


#import <MapKit/MapKit.h>

@interface MapViewAnnotation : NSObject <MKAnnotation , MKMapViewDelegate>{
    NSString *title;
    int index;
    CLLocationCoordinate2D coordinate;
    
}
@property (nonatomic, copy) NSString *title;
@property (nonatomic, readwrite) int index;
@property (nonatomic, readonly) CLLocationCoordinate2D coordinate;

- (id)initWithTitle:(NSString *)ttl andCoordinate:(CLLocationCoordinate2D)c2d;
- (id)initWithTitle:(NSString *)ttl Coordinate:(CLLocationCoordinate2D)c2d andIndex:(int)intIndex;

+(MKCoordinateRegion) regionForAnnotations:(NSArray*) annotations ;
@end