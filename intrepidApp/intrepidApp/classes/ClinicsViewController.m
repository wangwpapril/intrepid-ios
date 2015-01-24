//
//  ClinicsViewController.m
//  intrepidApp
//
//  Created by Madelaine Page on 2015-01-08.
//  Copyright (c) 2015 JonCarrHarris Consulting. All rights reserved.
//

#import "ClinicsViewController.h"
#import "MenuController.h"
#import "MapKit/MapKit.h"
#import "ClinicsTableViewCell.h"

@interface ClinicsViewController ()

@end


@implementation ClinicsViewController {
    NSArray *clinics;
    NSArray *images;
    NSArray *addresses;
}

@synthesize map;


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"Clinics";

    
    
    [self populateClinics];
    
}

- (void)viewWillAppear:(BOOL)animated {
    CLLocationCoordinate2D zoomLocation;
    zoomLocation.latitude = 39.281516;
    zoomLocation.longitude= -76.580806;
    
    MKCoordinateRegion viewRegion = MKCoordinateRegionMakeWithDistance(zoomLocation, 0.5*METERS_PER_MILE, 0.5*METERS_PER_MILE);
    
    [map setRegion:viewRegion animated:YES];
    
    [[MenuController getInstance] displayMenuWithParent:self];
}

-(void)populateClinics {
    clinics = [NSArray arrayWithObjects:@"Centro Medico Puerta De Hierro", @"Hospital Angeles Del Carmen", nil];
    addresses = [NSArray arrayWithObjects:@"Blvd. Puerta De Hierro No. 5150\nCol. Puerta De Hierro Guadalajara", @"Tarasco 3435, Franc. Monraz", nil];
    images = [NSArray arrayWithObjects:@"samplePic.png", @"samplePic.png", nil];

}

# pragma mark - UITableView methods
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [clinics count];
}



- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *MyIdentifier = @"MyIdentifier";
    
    ClinicsTableViewCell *cell = (ClinicsTableViewCell *)[tableView dequeueReusableCellWithIdentifier:MyIdentifier];
    
    if (cell == nil)
    {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"ClinicsTableViewCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    
    cell.nameLabel.text = [clinics objectAtIndex:indexPath.row];
    cell.locationImage.image = [UIImage imageNamed:[images objectAtIndex:indexPath.row]];
    cell.addressLabel.text = [addresses objectAtIndex:indexPath.row];
    
    return cell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
