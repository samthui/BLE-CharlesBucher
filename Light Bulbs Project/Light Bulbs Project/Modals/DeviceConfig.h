#import <Foundation/Foundation.h>
#import "Constants.h"

@interface DeviceConfig : NSObject<NSCoding>

@property (nonatomic, retain) NSString* UUID;
@property (nonatomic, retain) NSString* name;
@property (nonatomic, assign) COMMAND state;


@end
