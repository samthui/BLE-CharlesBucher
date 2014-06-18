#import "Utilities.h"
#import "DeviceConfig.h"

@implementation Utilities

+(NSString*) UUIDfromCFUUID:(NSString*)CFUUID
{
    return [[CFUUID componentsSeparatedByString:@"> "] objectAtIndex:1];
}

+(NSString*) UUIDofPeripheral:(CBPeripheral *)peripheral
{
    NSString* pUUID = [NSString stringWithFormat:@"%@", (NSString*)peripheral.identifier];
    
    return [Utilities UUIDfromCFUUID:pUUID];
}

+(NSMutableArray*) arrayFromUserDefaultWithKey:(NSString*)key
{
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    NSData *_arrayData = [prefs objectForKey:key];
    if (_arrayData)
    {
        NSArray *_rsArray = [NSKeyedUnarchiver unarchiveObjectWithData:_arrayData];
        return [[NSMutableArray alloc] initWithArray:_rsArray];
    }
    else
    {
        return [[NSMutableArray alloc] init];
    }
    return nil;
}

+(void) saveToUserDefaultWithKey:(NSString*) key forArray:(NSMutableArray*)array
{
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    NSData* arrayData = [NSKeyedArchiver archivedDataWithRootObject:array];
    [prefs setObject:arrayData forKey:key];
    [prefs synchronize];
}

+(CheckTableItem) findSavedObject:(NSString *)UUID
{
    CheckTableItem ret = { -1, NO};
    
    NSMutableArray* storedDeviceList = [Utilities arrayFromUserDefaultWithKey:(NSString*)kStoredDeviceList];
    int index;
    DeviceConfig* seekStoredDevice;
    for (index = 0; index < storedDeviceList.count; index++) {
        seekStoredDevice = (DeviceConfig*)[storedDeviceList objectAtIndex:index];
        if ([seekStoredDevice.UUID isEqual:UUID]) {
            ret.found = YES;
            ret.index = index;
            
            return ret;
        }
    }
    
    return ret;
}

@end
