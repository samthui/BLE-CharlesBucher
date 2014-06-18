//
//  MySwitchesTableViewController.m
//  Light Bulbs Project
//
//  Created by Ngoc Phuong Thanh Nguyen on 6/19/14.
//  Copyright (c) 2014 KeyStoneSolar. All rights reserved.
//

#import "MySwitchesTableViewController.h"
#import "AddTableViewController.h"
#import "AppDelegate.h"
#import "DeviceConfig.h"
#import "SavedDeivceTableViewCell.h"

#define SAVED_DEVICE_CELL_ID @"SavedDeviceCell"

@interface MySwitchesTableViewController () <SavedDeivceTableViewCellDelegate>

@end

@implementation MySwitchesTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.    
    UIImage *logo = [UIImage imageNamed:@"hometronx"];
    UIImageView *imageView = [[UIImageView alloc] initWithImage:logo];
    [imageView setFrame:(CGRect){CGPointZero, CGSizeMake(115, 30)}];
    UIBarButtonItem *imageButton = [[UIBarButtonItem alloc] initWithCustomView:imageView];
    
    self.navigationItem.leftBarButtonItem = imageButton;
    
    //register Cell
    [self.tableView registerNib:[UINib nibWithNibName:@"SavedDeivceTableViewCell" bundle:nil] forCellReuseIdentifier:SAVED_DEVICE_CELL_ID];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.tableView reloadData];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    AppDelegate* appDel = (AppDelegate*)[UIApplication sharedApplication].delegate;
    return appDel.deviceArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SavedDeivceTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:SAVED_DEVICE_CELL_ID forIndexPath:indexPath];
    cell.delegate = self;
    
    // Configure the cell...
    AppDelegate* appDel = (AppDelegate*)[UIApplication sharedApplication].delegate;
    NSArray* deviceArray = appDel.deviceArray;
    DeviceConfig* deviceConfig = (DeviceConfig*)[deviceArray objectAtIndex:indexPath.row];
    [cell.nameLabel setText:deviceConfig.name];
    
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
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - IBActions
-(IBAction)addBtnClicked:(id)sender
{
    AddTableViewController* addViewController = [[AddTableViewController alloc] initWithNibName:@"AddTableViewController" bundle:nil];
    [self.navigationController pushViewController:addViewController animated:YES];
}

#pragma mark - SavedDeivceTableViewCellDelegate
- (void) onBtnClickedInCell:(SavedDeivceTableViewCell*)cell
{
    UITableView* table = self.tableView;//(UITableView *)[buttonCell superview];
    NSIndexPath* pathOfTheCell = [table indexPathForCell:cell];
    NSInteger rowOfTheCell = [pathOfTheCell row];
    DBLog(@"%i ON", rowOfTheCell);
}

- (void) offBtnClickedInCell:(SavedDeivceTableViewCell*)cell
{
    UITableView* table = self.tableView;//(UITableView *)[buttonCell superview];
    NSIndexPath* pathOfTheCell = [table indexPathForCell:cell];
    NSInteger rowOfTheCell = [pathOfTheCell row];
    DBLog(@"%i OFF", rowOfTheCell);
}


@end
