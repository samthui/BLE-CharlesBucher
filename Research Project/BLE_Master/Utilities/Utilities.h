//
//  Utilities.h
//  MasterLocking
//
//  Created by admin on 12/29/12.
//  Copyright (c) 2012 Golden Key. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreBluetooth/CoreBluetooth.h>

#import "Defines.h"

#define STEP_0_5m    1
#define RANGE_5m    5
#define STEP_5_20m    5
#define RANGE_20m    20
#define STEP_20_30m    10
#define RANGE_30m    30

@interface Utilities : NSObject

+(NSString*) UUIDfromCFUUID:(NSString*)CFUUID;
+(NSString*) UUIDofPeripheral:(CBPeripheral*)peripheral;

+(float) convertToDistanceFromRSSI:(int)RSSI;
+(NSString*) describeDistanceFromRSSI:(int)RSSI;
+(NSRange) convertToRangeDistanceFromRSSI:(int)RSSI;
+(NSString*) describeDistanceFromRange:(NSRange)range;

+(int) averageOfInts:(NSMutableArray*)integersArray;

+(void) createStoredRSSIFile;
+(void) addData:(NSString*)data;
+ (UIButton*)commonBackButtonv1_5:(NSString*)title;
+ (UIButton*)squareButtonv1_5:(NSString *)title;


+ (BOOL)isRetinaVersion;
//+(UIImage *)resizeImage:(UIImage *)image destinationSize:(CGSize)destionationSize;
+(NSString *)convertString:(NSString *)inputText;
//+(NSString *)convertMeterToKilometer:(NSString *)meter;
+(void)startLoading;
+(void)endLoading;

+(NSMutableArray*) arrayFromUserDefaultWithKey:(NSString*)key;
+(void) saveToUserDefaultWithKey:(NSString*) key forArray:(NSMutableArray*)array;
+(CheckTableItem) findSavedObject:(NSString *)UUID;

@end
