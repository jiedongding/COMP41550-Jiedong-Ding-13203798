//
//  LiftMapViewController.m
//  Pool It
//
//  Created by Jaden on 30/03/2014.
//  Copyright (c) 2014 Jaden. All rights reserved.
//

#import "LiftMapViewController.h"
#import <MapKit/MapKit.h>

@interface LiftMapViewController () <MKMapViewDelegate>
@property (weak, nonatomic) IBOutlet MKMapView *mapView;

@end

@implementation LiftMapViewController

- (void)setMapView:(MKMapView *)mapView
{
    _mapView = mapView;
    self.mapView.delegate = self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // show current location
    self.mapView.showsUserLocation = YES;
    self.mapView.zoomEnabled = YES;
    self.mapView.scrollEnabled = YES;
    
    // Search
    MKLocalSearchRequest *request = [[MKLocalSearchRequest alloc] init];
    request.naturalLanguageQuery = [self.fromAddress stringByAppendingString:@", Ireland"];
    MKLocalSearch *search = [[MKLocalSearch alloc] initWithRequest:request];
    [search startWithCompletionHandler:^(MKLocalSearchResponse *response, NSError *error) {
        if (!error) {
            MKMapItem *mapItem = response.mapItems[0];
            MKPlacemark *placeMark = mapItem.placemark;
            [self.mapView addAnnotation:placeMark];
        }
    }];
    
    request.naturalLanguageQuery = [self.toAddress stringByAppendingString:@", Ireland"];
    search = [[MKLocalSearch alloc] initWithRequest:request];
    [search startWithCompletionHandler:^(MKLocalSearchResponse *response, NSError *error) {
        if (!error) {
            MKMapItem *mapItem = response.mapItems[0];
            MKPlacemark *placeMark = mapItem.placemark;
            [self.mapView addAnnotation:placeMark];
            
            // set region
            [self.mapView setRegion:response.boundingRegion];
            // set to center
            [self.mapView setCenterCoordinate:placeMark.coordinate animated:YES];
        }
    }];

}

- (IBAction)myLocation:(UIBarButtonItem *)sender {
    CLLocationCoordinate2D coords = self.mapView.userLocation.location.coordinate;
    [self.mapView setCenterCoordinate:coords animated:YES];
    
//    // Set Region
//    float zoomLevel = 0.02f;
//    MKCoordinateRegion region = MKCoordinateRegionMake(coords, MKCoordinateSpanMake(zoomLevel, zoomLevel));
//    [self.mapView setRegion:region animated:YES];
}

- (IBAction)dismissMap:(UIBarButtonItem *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
