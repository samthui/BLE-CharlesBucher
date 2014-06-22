#import "BLEDiscoveryHelper.h"

#import "Constants.h"
#import "Utilities.h"

#import "Device.h"
#import "DeviceConfig.h"

#import "AppDelegate.h"

static BLEDiscoveryHelper *shareBLEDiscoveryHelper = nil;

@interface BLEDiscoveryHelper () <CBCentralManagerDelegate, CBPeripheralDelegate>
{
}

@property (nonatomic, retain) CBCentralManager* centralManager;

@property (nonatomic, retain) NSTimer *stopScanTimer;

//-(CheckTableItem) findUnregisteredBike:(NSString *)UUID;
//-(void) didDiscoverUnregisteredObject:(CBPeripheral*)peripheral RSSI:(NSNumber *)RSSI;

@end

@implementation BLEDiscoveryHelper

@synthesize centralManager = _centralManager;
@synthesize BLEDiscoveryHelperDelegate = _BLEDiscoveryHelperDelegate;

//new
@synthesize discoveredDeviceList = _discoveredDeviceList;

+ (id)sharedInstance
{
    @synchronized(self) {
        if (shareBLEDiscoveryHelper == nil) {
            shareBLEDiscoveryHelper = [[super allocWithZone:NULL] init];
        }
    }
    return shareBLEDiscoveryHelper;
}

+ (id)allocWithZone:(NSZone *)zone
{
    return [[self sharedInstance] retain];
}

- (id)copyWithZone:(NSZone *)zone
{
    return self;
}

- (id)retain
{
    return self;
}

- (unsigned)retainCount
{
    return UINT_MAX; //denotes an object that cannot be released
}

- (oneway void)release
{
    // never release
}

- (id)autorelease
{
    return self;
}

- (id)init
{
    if (self = [super init]) {
        //custom initialization.
        self.centralManager = [[[CBCentralManager alloc] initWithDelegate:self queue:nil] autorelease];
        
        //new
        _discoveredDeviceList = [NSMutableArray new];
    }
    return self;
}

-(void)dealloc
{
    self.centralManager = nil;
    
    //new
    self.discoveredDeviceList = nil;
    
    [super dealloc];
}

#pragma mark - Handle background/foreground notification

#pragma mark - Private methods

#pragma mark - Public methods
- (void)startScanning
{
	NSArray			*uuidArray	= [NSArray arrayWithObjects:[CBUUID UUIDWithString:SERVICE_UUID], nil];
    
    NSDictionary	*options	= [NSDictionary dictionaryWithObject:[NSNumber numberWithBool:NO] forKey:CBCentralManagerScanOptionAllowDuplicatesKey];
    
    if ([self.stopScanTimer isValid]) {
        [self.stopScanTimer invalidate];
    }
//    self.stopScanTimer = [NSTimer scheduledTimerWithTimeInterval:kStopScanTimer target:self selector:@selector(stopScanning) userInfo:nil repeats:NO];
    
    //start scanning
	[_centralManager scanForPeripheralsWithServices:uuidArray options:options];
//	[_centralManager scanForPeripheralsWithServices:nil options:options];
}

- (void) stopScanning
{
    [_centralManager stopScan];
}

-(void) reScan
{
    //    NSLog(@"reScan");
    [self stopScanning];
    [self startScanning];
}
- (void) connectPeripheral:(CBPeripheral*)peripheral
{
	if (peripheral.state == CBPeripheralStateDisconnected) {
		[_centralManager connectPeripheral:peripheral options:nil];
	}
}

- (void) disconnectPeripheral:(CBPeripheral*)peripheral
{
	[_centralManager cancelPeripheralConnection:peripheral];
}

#pragma mark - CBCentralManagerDelegate

- (void) centralManagerDidUpdateState:(CBCentralManager *)central
{
    static CBCentralManagerState previousState = -1;
    
	switch ([_centralManager state]) {
		case CBCentralManagerStatePoweredOff:
		{
			NSLog(@"PoweredOff");
            
//            [self stopScanning];
//            [self stopTimerRequestConnectionToSavedBikes];
            
            //Nude _discoveredBikesList
//            self.discoveredBikesList = [NSMutableArray array];
//            [_BLEDiscoveryHelperDelegate discoveryDidRefresh];
            
            //new
            self.discoveredDeviceList = nil;
            
            break;
		}
            
		case CBCentralManagerStateUnauthorized:
		{
			/* Tell user the app is not allowed. */
			NSLog(@"Unauthorized");
            break;
		}
            
		case CBCentralManagerStateUnknown:
		{
			/* Bad news, let's wait for another event. */
			NSLog(@"Unknown");
            break;
		}
            
		case CBCentralManagerStatePoweredOn:
		{
            NSLog(@"CBCentralManagerState PoweredOn");
            
            [self startScanning];
//            [self startTimerSendAutoCommandToSavedBikes];
			break;
		}
            
		case CBCentralManagerStateResetting:
		{
			NSLog(@"Resetting");
            break;
		}
            
        default: //CBCentralManagerStateUnsupported
        {
            NSLog(@"Unsupported");
            UIAlertView *alertView = [[[UIAlertView alloc] initWithTitle:@"Bluetooth" message:@"BLE is not supported for this device" delegate:nil cancelButtonTitle:@"Dismiss" otherButtonTitles:nil] autorelease];
            [alertView show];
            break;
        }
	}
    
    previousState = [_centralManager state];
}

/*
- (void)centralManager:(CBCentralManager *)central didDiscoverPeripheral:(CBPeripheral *)peripheral advertisementData:(NSDictionary *)advertisementData RSSI:(NSNumber *)RSSI
{
    //    [self localNotification2];
//            NSLog(@"Advert:%@", advertisementData);
    CBUUID *uuid = [[advertisementData objectForKey:CBAdvertisementDataServiceUUIDsKey] objectAtIndex:0];
    //        NSLog(@"uuid:%@", uuid.description);
    if (!(NSString*)peripheral.identifier) {
        NSLog(@"............. discovered nil UUID ==>> connect to get UUID ...................");
        [central connectPeripheral:peripheral options:nil];
        return;
    }
    
    if ([uuid isEqual:[CBUUID UUIDWithString:SERVICE_UUID]]) {
        //check saved
        NSString* pUUID = [Utilities UUIDofPeripheral:peripheral];
        CheckTableItem checkItem = [Utilities findDeviceConfig:pUUID];
        
        if (!checkItem.found) {
            
            //save
            NSMutableArray* savedDeviceList = [Utilities arrayFromUserDefaultWithKey:(NSString*)kStoredDeviceList];
            DeviceConfig* deviceConfig = [DeviceConfig new];
            deviceConfig.UUID = pUUID;
            deviceConfig.state = 0;
            deviceConfig.interval = 0.5;
            [savedDeviceList addObject:deviceConfig];
            [deviceConfig release];
            [Utilities saveToUserDefaultWithKey:(NSString*)kStoredDeviceList forArray:savedDeviceList];
        }
        
        //create object
        [self didDiscoverUnregisteredObject:peripheral RSSI:RSSI];
                
    }
}
 */


- (void)centralManager:(CBCentralManager *)central didDiscoverPeripheral:(CBPeripheral *)peripheral advertisementData:(NSDictionary *)advertisementData RSSI:(NSNumber *)RSSI
{
    CBUUID *uuid = [[advertisementData objectForKey:CBAdvertisementDataServiceUUIDsKey] objectAtIndex:0];;
    if (!(NSString*)peripheral.identifier) {
        NSLog(@"............. discovered nil UUID ==>> connect to get UUID ...................");
        [central connectPeripheral:peripheral options:nil];
        return;
    }
    
    if ([uuid isEqual:[CBUUID UUIDWithString:SERVICE_UUID]]) {        
        //check did add to owner
        NSString* pUUID = [Utilities UUIDofPeripheral:peripheral];
        CheckTableItem checkItem = [Utilities findDeviceConfig:pUUID];
        if (checkItem.found) {
            CheckTableItem checkItem2 = [Utilities findDevice:pUUID];
            if (checkItem2.found) {
//                return;
            }else{
                //add to deviceList
                AppDelegate* appDel = (AppDelegate*)[UIApplication sharedApplication].delegate;
                [appDel addDevice:peripheral];
            }
            
            return;
        }
        
        BOOL existed = NO;
        for (CBPeripheral* p in self.discoveredDeviceList) {
            NSString* theUUID = [Utilities UUIDofPeripheral:p];
            if ([theUUID isEqualToString:pUUID]) {
                existed = YES;
                break;
            }
        }
        
        if (!existed) {
            [self.discoveredDeviceList addObject:peripheral];
            
            if (self.BLEDiscoveryHelperDelegate && [_BLEDiscoveryHelperDelegate respondsToSelector:@selector(discoveryDidRefresh)]) {
                [_BLEDiscoveryHelperDelegate discoveryDidRefresh];
            }
        }
        
    }
}

- (void)centralManager:(CBCentralManager *)central didRetrievePeripherals:(NSArray *)peripherals{
//            NSLog(@"Got a callback from didRetrievePeripherals");
}


- (void) centralManager:(CBCentralManager *)central didFailToRetrievePeripheralForUUID:(CFUUIDRef)UUID error:(NSError *)error
{
    NSLog(@"++ didFailToRetrievePeripheralForUUID");
    if (error) {
        NSLog(@"Error: %@", [error description]);
    }
	/* Nuke from plist. */
    //	[self removeSavedDevice:UUID];
}


- (void) centralManager:(CBCentralManager *)central didConnectPeripheral:(CBPeripheral *)peripheral
{
    NSLog(@"++ didConnectPeripheral %@", peripheral/*pUUID*/);
    
    
    NSArray	*serviceArray	= [NSArray arrayWithObjects:
                               [CBUUID UUIDWithString:SERVICE_UUID],
                               nil];
    
    [peripheral discoverServices:serviceArray];
}

- (void) centralManager:(CBCentralManager *)central didDisconnectPeripheral:(CBPeripheral *)peripheral error:(NSError *)error
{ 
    NSLog(@"++ didDisconnectPeripheral %@", peripheral/*.UUID*/);
    if (error) {
        NSLog(@"Error Disconnect: %@", [error description]);
    }
    
//    CheckTableItem checkItem = [self findUnregisteredBike:[Utilities UUIDofPeripheral:peripheral]];
//    if (checkItem.found) {
//        Device* device = (Device*)[_discoveredDeviceList objectAtIndex:checkItem.index];
//        if (device.updateInfoDelegate) {
//            [device.updateInfoDelegate didDisconnect];
//        }
//        
//        [_discoveredDeviceList removeObjectAtIndex:checkItem.index];
//        if (self.BLEDiscoveryHelperDelegate) {
//            [_BLEDiscoveryHelperDelegate discoveryDidRefresh];
//        }
//    }
}

#pragma mark - notifyBTServerCrashing
-(void) notifyBTServerCrashing
{
    //alert
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"WARNING!!"
                                                    message:@"Bluetooth Central powered off"
                                                   delegate:nil cancelButtonTitle:@"Dismiss"
                                          otherButtonTitles:nil];
//    [alert show];
    [alert release];

    //notify
    //NSLog(@"auto lock ==============");
    UILocalNotification *localNotif = [[UILocalNotification alloc] init];
    if (localNotif == nil)
        return;
    localNotif.fireDate = [NSDate date];
    localNotif.timeZone = [NSTimeZone defaultTimeZone];
    localNotif.repeatInterval = 0;//2
    // Notification details
    localNotif.alertBody = @"BTServer crashes";
    // Set the action button
    localNotif.hasAction = NO;
    
    localNotif.soundName = UILocalNotificationDefaultSoundName;
    
    // Schedule the notification
    [[UIApplication sharedApplication] scheduleLocalNotification:localNotif];
    [localNotif release];

}
//===================================================

#pragma mark - private methods

/*samthui7*/
/*- (void)writeValueForCommand:(int)command toBike:(Bike *)bike
{
    if (bike.peripheral==nil || bike.readCharacteristic==nil || bike.writeCharacteristic==nil || ![bike.peripheral isConnected]) {
        NSLog(@"peripheral or characteristic is null 2");
        //        [self reScan];
        [self loadSavedDevice];
        return;
    }
    //    NSLog(@"write command to bike: %@", (NSString*)bike.peripheral.UUID);
    unsigned char byteData[IO_CHARACTERISTIC_LENGTH];
    [bike.readCharacteristic.value getBytes:&byteData length:IO_CHARACTERISTIC_LENGTH];
    
    unsigned char generatedData[IO_CHARACTERISTIC_LENGTH];
    generatedData[0] = (byteData[0] * (byteData[3] >> (byteData[2] % 8))) % 256;
    generatedData[1] = (byteData[1] * (byteData[0] >> (byteData[3] % 8))) % 256;
    generatedData[2] = (byteData[2] * (byteData[1] >> (byteData[0] % 8))) % 256;
    generatedData[3] = (byteData[3] * (byteData[2] >> (byteData[1] % 8))) % 256;
    
    unsigned char phoneKey[4];
    
    CheckTableItem checkItem = [self :[Utilities UUIDofPeripheral:bike.peripheral]];
    if(checkItem.found)
    {
        StoredBike* storedBike = (StoredBike*)[[UserDefaultsHelper arrayFromUserDefaultWithKey:(NSString*)kStoredBikesList] objectAtIndex:checkItem.index];
        
        NSString* key = storedBike.key;
        
        for(int i = 0; i < 4; i++)
        {
            phoneKey[i] = [key characterAtIndex:i];
        }
    }
    else {
        AppDelegate* appDel = (AppDelegate*)[UIApplication sharedApplication].delegate;
        
        NSString* key = appDel.tempInputBikeKey;
        
        for(int i = 0; i < 4; i++)
        {
            phoneKey[i] = [key  characterAtIndex:i];
        }
    }
    //    for (int i = 0; i < 4; i++) {
    //        NSLog(@"%c", phoneKey[i]);
    //    }
    
    generatedData[0] = generatedData[0] ^ (~phoneKey[0]);
    generatedData[1] = generatedData[1] ^ (~phoneKey[1]);
    generatedData[2] = generatedData[2] ^ (~phoneKey[2]);
    generatedData[3] = generatedData[3] ^ (~phoneKey[3]);
    
    generatedData[4] = command;
    
    //    for (int i = 4; i >=0; i--) {
    //        NSLog(@".. %i ..", generatedData[i]);
    //    }
    
    //try to send command
    NSData *data = [NSData dataWithBytes:generatedData length:IO_CHARACTERISTIC_LENGTH];
    [bike.peripheral writeValue:data forCharacteristic:bike.writeCharacteristic type:CBCharacteristicWriteWithResponse];
}
*/

//-(CheckTableItem) findUnregisteredBike:(NSString *)UUID
//{
//    CheckTableItem ret = {-1, NO};
//    int index = 0;
//    for(Device* device in _discoveredDeviceList)
//    {
//        if([UUID isEqual:[Utilities UUIDofPeripheral:device.peripheral]])
//        {
//            ret.found = YES;
//            ret.index = index;
//            
//            return ret;
//        }
//        index++;
//    }
//    
//    return ret;
//}


@end
