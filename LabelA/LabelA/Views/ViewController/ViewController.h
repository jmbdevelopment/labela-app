//
//  ViewController.h
//  LabelA
//
//
//  
//

#import <UIKit/UIKit.h>
#import "BeaconViewController.h"
#import "BeaconController.h"
#import "TriangleObject.h"
#import "ButtonObject.h"
@import CoreLocation;

@interface ViewController : UIViewController <CLLocationManagerDelegate>
@property (strong, nonatomic) CLBeaconRegion *myBeaconRegion;
@property (strong, nonatomic) BeaconViewController *beaconViewController;
@property (strong, nonatomic) CLLocationManager *locationManager;
//@property (strong, nonatomic) BeaconController *beaconController;
- (IBAction)launchBeaconVC:(UIBarButtonItem *)sender;

//@property (strong, nonatomic) TriangleObject *triangleObject;
@property (strong, nonatomic) ButtonObject *buttonObject;
@property (strong, nonatomic) UIView *polygonContainer;
@property (strong, nonatomic) NSDictionary *triangleData;
@property (strong, nonatomic) NSMutableArray *triangles;
@property (strong, nonatomic) NSMutableArray *buttons;
@property (strong, nonatomic) UIBezierPath *buttonPath;

@property (nonatomic, weak) NSTimer *timer;
@property (strong, nonatomic) NSMutableArray *triangleCoordinates;
@property (strong, nonatomic) NSMutableDictionary *triangleDictCoordinates;

@end
