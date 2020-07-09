//
//  SharedElements.h
//  LabelA
//
//  
//
//

#import <Foundation/Foundation.h>

@interface SharedElements : NSObject
@property (strong, nonatomic) NSMutableArray *allItems;

+ (id)sharedInstance;
@end
