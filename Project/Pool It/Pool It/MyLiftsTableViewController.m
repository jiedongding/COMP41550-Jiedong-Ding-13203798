//
//  MyLiftsTableViewController.m
//  Pool It
//
//  Created by Jaden on 05/04/2014.
//  Copyright (c) 2014 Jaden. All rights reserved.
//

#import "MyLiftsTableViewController.h"
#import <Parse/Parse.h>
#import "GiveLiftTableViewController.h"
#import "LiftTableViewCell.h"

@interface MyLiftsTableViewController ()

@end

@implementation MyLiftsTableViewController

- (IBAction)refresh:(UIRefreshControl *)sender {
    [self getMyLiftList];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated
{
    [self getMyLiftList];
}

- (void)getMyLiftList
{
    [self.refreshControl beginRefreshing];
    
    // Get My Lifts List
    PFQuery *myLiftsQuery = [PFQuery queryWithClassName:@"Lift"];
    [myLiftsQuery whereKey:@"liftUser" equalTo:[PFUser currentUser]];
    [myLiftsQuery findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            self.myLiftsArray = [NSMutableArray arrayWithArray:objects];
            [self.tableView reloadData];
            
            [self.refreshControl endRefreshing];
        }
    }];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return self.myLiftsArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LiftTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"My Lifts Cell" forIndexPath:indexPath];
    
    // get the lift object
    PFObject *lift = [self.myLiftsArray objectAtIndex:indexPath.row];
    
    // set the address
    cell.cellFromLabel.text = [NSString stringWithFormat:@"From: %@", lift[@"fromAddress"]];
    cell.cellToLabel.text = [NSString stringWithFormat:@"To: %@", lift[@"toAddress"]];
    
    // get the bool of isDaily
    BOOL isDaily = [lift[@"isDaily"] boolValue];
    // set daily or not
    if (isDaily) {
        cell.cellDailyLabel.text = @"Daily: YES";
    }
    else {
        cell.cellDailyLabel.text = @"Daily: NO";
    }
    
    // set time
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    if (isDaily) {
        [dateFormatter setDateFormat:@"HH:mm"];
    }
    else {
        [dateFormatter setDateFormat:@"dd-MM-yy HH:mm"];
    }
    cell.cellTimeLabel.text = [NSString stringWithFormat:@"Time: %@",[dateFormatter stringFromDate:lift[@"liftDate"]]];
    
    // set seat left
    cell.cellSeatLeftLabel.text = [NSString stringWithFormat:@"Seat Left: %ld", (long)[lift[@"seatLeft"] integerValue]];
    
    return cell;
}



// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}



// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        PFObject *lift = [self.myLiftsArray objectAtIndex:indexPath.row];
        [self.myLiftsArray removeObjectAtIndex:indexPath.row];
        [lift deleteInBackground];
        // Update the table view
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}


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


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.destinationViewController isKindOfClass:[GiveLiftTableViewController class]]) {
        NSIndexPath *indexPath = [self.tableView indexPathForCell:sender];
        PFObject *editLift = [self.myLiftsArray objectAtIndex:indexPath.row];

        GiveLiftTableViewController *editLiftTVC = (GiveLiftTableViewController *)segue.destinationViewController;
        editLiftTVC.title = @"Edit My Lift";
        [editLiftTVC setEditLift:editLift];
    }
}


@end
