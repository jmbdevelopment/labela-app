//
//  SharedElements.m
//  LabelA
//
//  
//
//

#import "SharedElements.h"

@implementation SharedElements

+ (id)sharedInstance {
    static dispatch_once_t p = 0;
    __strong static id _sharedObject = nil;
    dispatch_once(&p, ^{
        _sharedObject = [[self alloc] init];
    });
    return _sharedObject;
}

-(NSMutableArray *)allItems {
    if(!_allItems)
        _allItems = [NSMutableArray array];
    return _allItems;
}

@end
