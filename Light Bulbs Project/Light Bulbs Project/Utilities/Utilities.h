#import <Foundation/Foundation.h>
#import <CoreBluetooth/CoreBluetooth.h>

#import "Defines.h"
#import "Constants.h"

typedef struct {
    short index;
    BOOL found;
}CheckTableItem;

@interface Utilities : NSObject

+(NSString*) UUIDofPeripheral:(CBPeripheral*)peripheral;

+(NSMutableArray*) arrayFromUserDefaultWithKey:(NSString*)key;
+(void) saveToUserDefaultWithKey:(NSString*) key forArray:(NSMutableArray*)array;
+(CheckTableItem) findDeviceConfig:(NSString *)UUID;
+(CheckTableItem) findDevice:(NSString*)UUID;

@end
