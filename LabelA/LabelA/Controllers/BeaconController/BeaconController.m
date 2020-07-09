//
//  BeaconController.m
//  LabelA
//
//
//  
//

#import "BeaconController.h"

NSString * const kStoredItemsKey = @"storedItems";

@implementation BeaconController
+ (id)sharedInstance {
    static dispatch_once_t p = 0;
    __strong static id sharedObject = nil;
    
    dispatch_once(&p, ^{
        sharedObject = [[self alloc] init];
    });
    
    return sharedObject;
}
- (id)init {
    self = [super init];
    if (self) {
        self.locationManager = [[CLLocationManager alloc] init];
        self.locationManager.delegate = self;
        [self.locationManager startUpdatingLocation];
        if ([self loadItems]) {
            [[SharedElements sharedInstance] setAllItems:[[self loadItems] mutableCopy]];
            [self startMonitoringAllItems];
        }
    }
    return self;
}

- (void)addItemWithName:(NSString *)name
                   uuid:(NSUUID *)uuid
                  major:(CLBeaconMajorValue)major
                  minor:(CLBeaconMinorValue)minor
{
    __strong Item *item = [[Item alloc] initWithName:name
                                       uuid:uuid
                                      major:major
                                      minor:minor];
    BOOL found = NO;
    for (Item *storedItem in [[SharedElements sharedInstance] allItems]) {
        if ([item isEqualToItem:storedItem])
            found = YES;
    }
    
    // If the beacon is not found add it
    if (!found) {
        // Add all beacons to singleton
        [[[SharedElements sharedInstance] allItems] addObject:item];
        [self startMonitoringItem:item];
        [self persistItems];
    }
}

- (void)startMonitoringAllItems {
    for (Item *item in [[SharedElements sharedInstance] allItems])
        [self startMonitoringItem:item];
}

- (void)startMonitoringItem:(Item *)item {
    __strong CLBeaconRegion *beaconRegion = [self beaconRegionWithItem:item];
    [self.locationManager startMonitoringForRegion:beaconRegion];
    [self.locationManager startRangingBeaconsInRegion:beaconRegion];
}

- (void)stopMonitoringItem:(Item *)item {
    CLBeaconRegion *beaconRegion = [self beaconRegionWithItem:item];
    [self.locationManager stopMonitoringForRegion:beaconRegion];
    [self.locationManager stopRangingBeaconsInRegion:beaconRegion];
}



- (CLBeaconRegion *)beaconRegionWithItem:(Item *)item {
    CLBeaconRegion *beaconRegion =
    [[CLBeaconRegion alloc] initWithProximityUUID:item.uuid
                                            major:item.majorValue
                                            minor:item.minorValue
                                       identifier:item.name];
    return beaconRegion;
}

- (void)persistItems {
    [self saveCustomObject:[[SharedElements sharedInstance] allItems] key:kStoredItemsKey];
}

- (NSArray *)loadItems {
    return (NSArray *)[self loadCustomObjectWithKey:kStoredItemsKey];
}

- (void)saveCustomObject:(id)object key:(NSString *)key {
    NSData *encodedObject = [NSKeyedArchiver archivedDataWithRootObject:object];
    [DEFAULTS setObject:encodedObject forKey:key];
    [DEFAULTS synchronize];
}

- (id)loadCustomObjectWithKey:(NSString *)key {
    NSData *encodedObject = [DEFAULTS objectForKey:key];
    id object = [NSKeyedUnarchiver unarchiveObjectWithData:encodedObject];
    return object;
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
    NSLog(@"Location manager failed: %@", error);
}

- (void)locationManager:(CLLocationManager *)manager
        didRangeBeacons:(NSArray *)beacons
               inRegion:(CLBeaconRegion *)region
{
    NSLog(@"all items:%@",[[SharedElements sharedInstance] allItems]);
    for (CLBeacon *beacon in beacons) {
        for (Item *item in [[SharedElements sharedInstance] allItems]) {
            if ([item isEqualToCLBeacon:beacon]) {
                item.lastSeenBeacon = beacon;
            }
        }
    }
}

@end
