//
//  LiftListTableViewController.m
//  Pool It
//
//  Created by Jaden on 31/03/2014.
//  Copyright (c) 2014 Jaden. All rights reserved.
//

#import "LiftListTableViewController.h"
#import <Parse/Parse.h>
#import "LiftDetailViewController.h"
#import "LiftTableViewCell.h"

@interface LiftListTableViewController () <UISearchBarDelegate>

@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;

@end

@implementation LiftListTableViewController

- (IBAction)refresh:(UIRefreshControl *)sender {
    [self getAllLiftList];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.searchBar.delegate = self;
    [self getAllLiftList];
}

- (void)getAllLiftList
{
    [self.refreshControl beginRefreshing];
    // Get all lift
    PFQuery *liftListQuery = [PFQuery queryWithClassName:@"Lift"];
    [liftListQuery findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            self.liftListArray = [NSMutableArray arrayWithArray:objects];
            self.searchedLiftListArray = [NSMutableArray arrayWithArray:objects];
            [self.tableView reloadData];
            [self.refreshControl endRefreshing];
        }
    }];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return self.searchedLiftListArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LiftTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Lift List Cell" forIndexPath:indexPath];
    
    // get the lift object
    PFObject *lift = [self.searchedLiftListArray objectAtIndex:indexPath.row];
    
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

// click cancel button of search bar
- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    searchBar.text = @"";
    [searchBar resignFirstResponder];
    [self getAllLiftList];
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    // remove searched array
    [self.searchedLiftListArray removeAllObjects];
    // searching
    for (PFObject *lift in self.liftListArray) {
        // search both in from address and to address
        NSString *searchStr = [NSString stringWithFormat:@"%@,%@", lift[@"fromAddress"], lift[@"toAddress"]];
        NSRange range = [searchStr rangeOfString:self.searchBar.text options:NSCaseInsensitiveSearch];
        if (range.length > 0) {
            [self.searchedLiftListArray addObject:lift];
        }
    }
    // reload table view
    [self.tableView reloadData];
    [searchBar resignFirstResponder];
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    if ([segue.destinationViewController isKindOfClass:[LiftDetailViewController class]]) {
        NSIndexPath *indexPath = [self.tableView indexPathForCell:sender];
        PFObject *detailLift = [self.searchedLiftListArray objectAtIndex:indexPath.row];
        
        // set detail lift for detail vc
        [segue.destinationViewController setDetailLift:detailLift];
        
        // set destinationViewController
        LiftDetailViewController *liftDetailVC = (LiftDetailViewController *)segue.destinationViewController;
        liftDetailVC.title = @"Lift Detail";
    }
}


@end
