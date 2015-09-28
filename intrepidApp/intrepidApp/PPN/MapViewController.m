/*
     File: MapViewController.m
 Abstract: n/a
  Version: 1.5
 
 Disclaimer: IMPORTANT:  This Apple software is supplied to you by Apple
 Inc. ("Apple") in consideration of your agreement to the following
 terms, and your use, installation, modification or redistribution of
 this Apple software constitutes acceptance of these terms.  If you do
 not agree with these terms, please do not use, install, modify or
 redistribute this Apple software.
 
 In consideration of your agreement to abide by the following terms, and
 subject to these terms, Apple grants you a personal, non-exclusive
 license, under Apple's copyrights in this original Apple software (the
 "Apple Software"), to use, reproduce, modify and redistribute the Apple
 Software, with or without modifications, in source and/or binary forms;
 provided that if you redistribute the Apple Software in its entirety and
 without modifications, you must retain this notice and the following
 text and disclaimers in all such redistributions of the Apple Software.
 Neither the name, trademarks, service marks or logos of Apple Inc. may
 be used to endorse or promote products derived from the Apple Software
 without specific prior written permission from Apple.  Except as
 expressly stated in this notice, no other rights or licenses, express or
 implied, are granted by Apple herein, including but not limited to any
 patent rights that may be infringed by your derivative works or by other
 works in which the Apple Software may be incorporated.
 
 The Apple Software is provided by Apple on an "AS IS" basis.  APPLE
 MAKES NO WARRANTIES, EXPRESS OR IMPLIED, INCLUDING WITHOUT LIMITATION
 THE IMPLIED WARRANTIES OF NON-INFRINGEMENT, MERCHANTABILITY AND FITNESS
 FOR A PARTICULAR PURPOSE, REGARDING THE APPLE SOFTWARE OR ITS USE AND
 OPERATION ALONE OR IN COMBINATION WITH YOUR PRODUCTS.
 
 IN NO EVENT SHALL APPLE BE LIABLE FOR ANY SPECIAL, INDIRECT, INCIDENTAL
 OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
 SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
 INTERRUPTION) ARISING IN ANY WAY OUT OF THE USE, REPRODUCTION,
 MODIFICATION AND/OR DISTRIBUTION OF THE APPLE SOFTWARE, HOWEVER CAUSED
 AND WHETHER UNDER THEORY OF CONTRACT, TORT (INCLUDING NEGLIGENCE),
 STRICT LIABILITY OR OTHERWISE, EVEN IF APPLE HAS BEEN ADVISED OF THE
 POSSIBILITY OF SUCH DAMAGE.
 
 Copyright (C) 2014 Apple Inc. All Rights Reserved.
 
 */

#import "MapViewController.h"
#import "DetailViewController.h"


#import "SFAnnotation.h"            // annotation for the city of San Francisco
#import "BridgeAnnotation.h"        // annotation for the Golden Gate bridge
#import "CustomAnnotation.h"        // annotation for the Tea Garden

#import "TripManager.h"


#pragma mark -

@implementation MapViewController


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    // restore the nav bar to translucent
    self.navigationController.navigationBar.barStyle = UIBarStyleBlackTranslucent;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationController.navigationBarHidden = false;
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Back " style:UIBarButtonItemStylePlain target:nil action:nil];
    self.navigationItem.title = @"PPN Map";
    self.navigationController.toolbarHidden = FALSE;
    
    
    CGRect rect=CGRectMake(0, 0, 320, self.view.frame.size.height);
    scrollView = [[UIScrollView alloc] initWithFrame:rect];
    scrollView.showsVerticalScrollIndicator = YES;
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.scrollEnabled = YES;
    
//    [self addContent];
//    mapView.delegate = self;
    mapView = [[MKMapView alloc] initWithFrame:CGRectMake(0, 0, 320, self.view.frame.size.height)];
//    mapView.delegate = self;
    [scrollView addSubview:mapView];

    [self.view addSubview:scrollView];

    
    ppnList = [[TripManager getInstance] getPPNList];

    arrayLocation = [[NSMutableArray alloc]init];
    
    for (PPNEntity *pe in ppnList) {
    
        NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
        [dict setValue:[pe latitude] forKey:@"latitude"];
        [dict setValue:[pe longitude] forKey:@"longitude"];
        [dict setValue:[pe type] forKey:@"title"];
        [arrayLocation addObject:dict];
        dict = nil;
    }
    
    [self allAction:self];
    
}

- (void)viewWillDisappear:(BOOL)animated {
    self.navigationController.toolbarHidden = TRUE;
}

#pragma mark - Button Actions

- (void)gotoByAnnotationClass:(Class)annotationClass
{
    // user tapped "City" button in the bottom toolbar
/*    for (id annotation in self.mapAnnotations)
    {
        if ([annotation isKindOfClass:annotationClass])
        {
            // remove any annotations that exist
            [self.mapView removeAnnotations:self.mapView.annotations];
            // add just the city annotation
            [self.mapView addAnnotation:annotation];
            
            [self gotoDefaultLocation];
        }
    }*/
}

- (void)gotoByType:(NSString*) typeString
{
    NSMutableArray *arrAnnotations  = [[NSMutableArray alloc]init];
    
    [mapView removeAnnotations:mapView.annotations];
//    [scrollView re:mapView];
//    mapView = [[MKMapView alloc] initWithFrame:CGRectMake(0, 0, 320, 300)];
//    [scrollView addSubview:mapView];

    for(int i=0;i<[arrayLocation count];i++)
    {
        if ([[[arrayLocation objectAtIndex:i] objectForKey:@"title"] compare:typeString] == 0) {
            CLLocationCoordinate2D location;
            location.latitude = [[[arrayLocation objectAtIndex:i] objectForKey:@"latitude"] doubleValue];
            location.longitude = [[[arrayLocation objectAtIndex:i] objectForKey:@"longitude"] doubleValue];
            
            MapViewAnnotation *newAnnotation = [[MapViewAnnotation alloc] initWithTitle:[[arrayLocation objectAtIndex:i] objectForKey:@"title"] Coordinate:location andIndex:i];
            [arrAnnotations addObject:newAnnotation];

        }
        
    }
    
    [mapView addAnnotations:arrAnnotations];
    mapView.region = [MapViewAnnotation regionForAnnotations:arrAnnotations];

}

- (IBAction)cityAction:(id)sender
{
//    [self gotoByAnnotationClass:[SFAnnotation class]];
    currentSelection = @"HOSPITAL";
    [self gotoByType:@"HOSPITAL"];
}

- (IBAction)bridgeAction:(id)sender
{
    // user tapped "Bridge" button in the bottom toolbar
//    [self gotoByAnnotationClass:[BridgeAnnotation class]];
    currentSelection = @"SPECIALTY HOSPITAL";
    [self gotoByType:@"SPECIALTY HOSPITAL"];
}

- (IBAction)teaGardenAction:(id)sender
{
    // user tapped "Tea Gardon" button in the bottom toolbar
    [self gotoByAnnotationClass:[CustomAnnotation class]];
}


- (IBAction)allAction:(id)sender
{
    // user tapped "All" button in the bottom toolbar
    
    // remove any annotations that exist
//    [self.mapView removeAnnotations:self.mapView.annotations];
    
    // add all 3 annotations
//    [self.mapView addAnnotations:self.mapAnnotations];
    
    currentSelection = @"All";
    
    NSMutableArray *arrAnnotations  = [[NSMutableArray alloc]init];
    
    [mapView removeAnnotations:mapView.annotations];

    for(int i=0;i<[arrayLocation count];i++)
    {
        CLLocationCoordinate2D location;
        location.latitude = [[[arrayLocation objectAtIndex:i] objectForKey:@"latitude"] doubleValue];
        location.longitude = [[[arrayLocation objectAtIndex:i] objectForKey:@"longitude"] doubleValue];
        
        MapViewAnnotation *newAnnotation = [[MapViewAnnotation alloc] initWithTitle:[[arrayLocation objectAtIndex:i] objectForKey:@"title"] Coordinate:location andIndex:i];
        
        [arrAnnotations addObject:newAnnotation];
    }
    
    mapView.delegate = self;
/*    dispatch_async(dispatch_get_main_queue(), ^{
        [mapView addAnnotations:arrAnnotations];
    });*/
    [mapView addAnnotations:arrAnnotations];
    mapView.region = [MapViewAnnotation regionForAnnotations:arrAnnotations];
//    mapView.delegate = self;
}


#pragma mark - MKMapViewDelegate

// user tapped the disclosure button in the bridge callout
//
- (void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control
{
    // here we illustrate how to detect which annotation type was clicked on for its callout
    NSLog(@"clicked Golden Gate Bridge annotation");
/*    id <MKAnnotation> annotation = [view annotation];
    if ([annotation isKindOfClass:[BridgeAnnotation class]])
    {
        
    }
    {
        NSLog(@"clicked Golden Gate Bridge annotation");
        
        DetailViewController *detailViewController = [[self storyboard] instantiateViewControllerWithIdentifier:@"DetailViewController"];
        if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad)
        {
            // for iPad, we use a popover
            if (self.bridgePopoverController == nil)
            {
                _bridgePopoverController = [[UIPopoverController alloc] initWithContentViewController:detailViewController];
            }
            [self.bridgePopoverController presentPopoverFromRect:control.bounds
                                                          inView:control
                                        permittedArrowDirections:UIPopoverArrowDirectionLeft
                                                        animated:YES];
        }
        else
        {
            // for iPhone we navigate to a detail view controller using UINavigationController
            [self.navigationController pushViewController:detailViewController animated:YES];
        }
    }*/
        
}

- (MKAnnotationView *)mapView:(MKMapView *)theMapView viewForAnnotation:(id <MKAnnotation>)annotation
{
 /*   if ([annotation isKindOfClass:[MKUserLocation class]]) return nil;
    
    static NSString* AnnotationIdentifier = @"AnnotationIdentifier";
    
    MKPinAnnotationView* pinView = [[MKPinAnnotationView alloc]initWithAnnotation:annotation reuseIdentifier:AnnotationIdentifier];
    
    pinView.animatesDrop=YES;
    pinView.canShowCallout=YES;
    pinView.pinColor=MKPinAnnotationColorPurple;
    pinView.image = [UIImage imageNamed:@"Electricity"];
    
    
    UIButton* rightButton = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
    [rightButton setTitle:annotation.title forState:UIControlStateNormal];
    
    [rightButton addTarget:self
                    action:@selector(showDetails:)
          forControlEvents:UIControlEventTouchUpInside];
    
    pinView.rightCalloutAccessoryView = rightButton;
    
    return pinView;*/
    
    if (annotation == mapView.userLocation)
    {
        return nil;
    }
    MKAnnotationView *pin = (MKAnnotationView *) [mapView dequeueReusableAnnotationViewWithIdentifier: @"restMap"];
    if (pin == nil)
    {
        pin = [[MKAnnotationView alloc] initWithAnnotation: annotation reuseIdentifier: @"restMap"];
    }
    else
    {
        pin.annotation = annotation;
    }
//    pin.pinColor = MKPinAnnotationColorRed;
//    pin.animatesDrop = NO;
    pin.canShowCallout=TRUE;
    
    if ((currentSelected.coordinate.latitude == annotation.coordinate.latitude)&&
    (currentSelected.coordinate.longitude == annotation.coordinate.longitude)){
        pin.image = [UIImage imageNamed:@"map-marker-active"];
    } else {
        pin.image = [UIImage imageNamed:@"map-marker-inactive"];
    }
  
    UIButton *btn=[UIButton buttonWithType:UIButtonTypeDetailDisclosure];
    MapViewAnnotation *temp = (MapViewAnnotation *)pin.annotation;
    btn.tag=temp.index;
    pin.rightCalloutAccessoryView=btn;
    [btn addTarget:self action:@selector(openDetail:) forControlEvents:UIControlEventTouchUpInside];
    
    return pin;
}

- (IBAction)showDetails:(id)sender{
    
    NSLog(@"Annotation Click");
    
}

-(void)mapView:(MKMapView *)mapView didSelectAnnotationView:(MKAnnotationView *)view
{
    if ([view.annotation isKindOfClass:[MapViewAnnotation class]]) {
        MapViewAnnotation *annotation = (MapViewAnnotation *)view.annotation;
        currentSelected = annotation;
        
        NSString * s = annotation.title;
//        view.image = [UIImage imageNamed:@"map-marker-inactive"];
        
        [self->mapView removeFromSuperview];
        self->mapView = [[MKMapView alloc] initWithFrame:CGRectMake(0, 0, 320, 300)];
        [scrollView addSubview:self->mapView];
        
        if ([currentSelection compare:@"All"] == 0) {
            [self allAction:self];
        }else {
            [self gotoByType:currentSelection];
        }
        
        
        int y = self->mapView.frame.origin.y + self->mapView.frame.size.height;

        UILabel *textLabel = [[UILabel alloc] init];
        textLabel.font = [UIFont fontWithName:APP_FONT size:15];
        textLabel.textColor = APP_TEXT_COLOR;
        textLabel.lineBreakMode = NSLineBreakByWordWrapping;
        textLabel.numberOfLines = 0;
        
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        paragraphStyle.lineBreakMode = NSLineBreakByWordWrapping;
        CGSize size = [s boundingRectWithSize:CGSizeMake(300, CGFLOAT_MAX)
                                                      options:NSStringDrawingUsesLineFragmentOrigin
                                                   attributes:@{NSParagraphStyleAttributeName:paragraphStyle.copy, NSFontAttributeName:[UIFont fontWithName:@"ProximaNova-Light" size:16]}
                                                      context:nil].size;
        textLabel.frame = CGRectMake(15, y + 15, 300, size.height);
        textLabel.font = [UIFont fontWithName:@"ProximaNova-Light" size:16];
        textLabel.backgroundColor = [UIColor clearColor];
        textLabel.textColor = APP_TEXT_COLOR;
        textLabel.text = s;
        [scrollView addSubview:textLabel];
        y = textLabel.frame.origin.y + textLabel.frame.size.height + 15;


    }
}

@end
