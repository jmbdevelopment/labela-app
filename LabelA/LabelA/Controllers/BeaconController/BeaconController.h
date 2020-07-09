//
//  BeaconController.h
//  LabelA
//
// 
//
//

#import <Foundation/Foundation.h>
#import "Item.h"
@import CoreLocation;

@interface BeaconController : NSObject <CLLocationManagerDelegate>
@property (strong, nonatomic) CLLocationManager *locationManager;

+ (id)sharedInstance;
-(void)addItemWithName:(NSString *)name
                    uuid:(NSUUID *)uuid
                   major:(CLBeaconMajorValue)major
                   minor:(CLBeaconMinorValue)minor;

- (void)stopMonitoringItem:(Item *)item;
- (void)startMonitoringAllItems;

@end
