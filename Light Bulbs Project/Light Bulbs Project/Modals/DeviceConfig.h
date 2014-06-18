#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, DeviceState) {
	OFF = 0,
	ON,
	STOP,
};

@interface DeviceConfig : NSObject<NSCoding>

@property (nonatomic, retain) NSString* UUID;
@property (nonatomic, retain) NSString* name;
@property (nonatomic, assign) int state;


@end
