//
//  AddTableViewController.m
//  Light Bulbs Project
//
//  Created by Ngoc Phuong Thanh Nguyen on 6/19/14.
//  Copyright (c) 2014 KeyStoneSolar. All rights reserved.
//

#import "AddTableViewController.h"
#import "BLEDiscoveryHelper.h"
#import "Utilities.h"
#import "AppDelegate.h"
#import "DeviceConfig.h"


@interface AddTableViewController () <BLEDiscoveryHelperDelegate>

@end

@implementation AddTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    
    BLEDiscoveryHelper* centralBLEHelper = [BLEDiscoveryHelper sharedInstance];
    centralBLEHelper.BLEDiscoveryHelperDelegate = self;
    [centralBLEHelper startScanning];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    BLEDiscoveryHelper* centralBLEHelper = [BLEDiscoveryHelper sharedInstance];
    return centralBLEHelper.discoveredDeviceList.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString* cellID = @"DiscoveredDeviceCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID forIndexPath:indexPath];
    
    // Configure the cell...
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    
        //addBtn
        UIButton* addBtn = [[UIButton alloc] initWithFrame:CGRectMake(250, 7, 50, 30)];
        [addBtn setTitle:@"Add" forState:UIControlStateNormal];
        [addBtn addTarget:self action:@selector(addDevice:) forControlEvents:UIControlEventTouchUpInside];
        [cell addSubview:addBtn];
    }
    
    BLEDiscoveryHelper* centralBLEHelper = [BLEDiscoveryHelper sharedInstance];
    NSArray* discoveredDeviceArray= centralBLEHelper.discoveredDeviceList;
    CBPeripheral* peripheral = (CBPeripheral*)[discoveredDeviceArray objectAtIndex:indexPath.row];
    [cell.textLabel setText:[Utilities UUIDofPeripheral:peripheral]];
    
    return cell;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Table view delegate

// In a xib-based application, navigation from a table can be handled in -tableView:didSelectRowAtIndexPath:
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here, for example:
    // Create the next view controller.
    <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:<#@"Nib name"#> bundle:nil];
    
    // Pass the selected object to the new view controller.
    
    // Push the view controller.
    [self.navigationController pushViewController:detailViewController animated:YES];
}
*/

#pragma mark - BLEDiscoveryHelperDelegate
-(void)discoveryDidRefresh
{
    [self.tableView reloadData];
}

-(void)discoveryStatePoweredOff
{}

#pragma mark -
-(void)addDevice:(id)sender
{
    UIButton *senderButton = (UIButton *)sender;
    UITableViewCell *buttonCell = (UITableViewCell *)[senderButton superview];
    UITableView* table = self.tableView;//(UITableView *)[buttonCell superview];
    NSIndexPath* pathOfTheCell = [table indexPathForCell:buttonCell];
    NSInteger rowOfTheCell = [pathOfTheCell row];
    DBLog(@"rowofthecell %d", rowOfTheCell);
    
    BLEDiscoveryHelper* centralBLEHelper = [BLEDiscoveryHelper sharedInstance];
    NSMutableArray* discoveredDeviceArray= centralBLEHelper.discoveredDeviceList;
    CBPeripheral* peripheral = (CBPeripheral*)[discoveredDeviceArray objectAtIndex:rowOfTheCell];
    NSString* pUUID = [Utilities UUIDofPeripheral:peripheral];
    
    //add to saved list and reload MySwitchesTable
    AppDelegate* appDel = (AppDelegate*)[UIApplication sharedApplication].delegate;
    DeviceConfig* deviceConfig = [DeviceConfig new];
    deviceConfig.UUID = pUUID;
    deviceConfig.name = pUUID;
    deviceConfig.state = OFF;
    [appDel.deviceArray addObject:deviceConfig];    
    [Utilities saveToUserDefaultWithKey:(NSString*)kStoredDeviceList forArray:appDel.deviceArray];
    
    //remove added devices and reload table
    [discoveredDeviceArray removeObjectAtIndex:rowOfTheCell];
    [self.tableView reloadData];
}

@end
