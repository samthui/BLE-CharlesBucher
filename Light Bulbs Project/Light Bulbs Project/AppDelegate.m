//
//  AppDelegate.m
//  Light Bulbs Project
//
//  Created by Ngoc Phuong Thanh Nguyen on 6/19/14.
//  Copyright (c) 2014 KeyStoneSolar. All rights reserved.
//

#import "AppDelegate.h"
#import "Utilities.h"
#import "BLEDiscoveryHelper.h"
#import "DeviceConfig.h"
#import "Device.h"

@implementation AppDelegate

@synthesize deviceArray = _deviceArray;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    self.deviceArray = [NSMutableArray array];
    /*
    DeviceConfig* deviceConfig = [DeviceConfig new];
    deviceConfig.UUID = @"123";
    deviceConfig.name = @"abc";
    deviceConfig.state = OFF;
    [self.deviceArray addObject:deviceConfig];
    DeviceConfig* deviceConfig2 = [DeviceConfig new];
    deviceConfig2.UUID = @"456";
    deviceConfig2.name = @"def";
    deviceConfig2.state = OFF;
    [self.deviceArray addObject:deviceConfig2];
    
     [Utilities saveToUserDefaultWithKey:(NSString*)kStoredDeviceList forArray:self.deviceArray];*/
    
    
//    BLEDiscoveryHelper* centralBLEHelper = [BLEDiscoveryHelper sharedInstance];
////    centralBLEHelper.BLEDiscoveryHelperDelegate = self;
//    [centralBLEHelper startScanning];
    
    return YES;
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

#pragma mark - public methods
-(void)addDevice:(CBPeripheral *)peripheral
{
    Device* device = [[Device alloc] initWithPeripheral:peripheral];
    [device connect];
    [self.deviceArray addObject:device];
}

@end
