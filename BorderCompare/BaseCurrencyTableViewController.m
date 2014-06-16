//
//  BaseCurrencyTableViewController.m
//  BorderCompare
//
//  Created by Charles Grier on 6/15/14.
//  Copyright (c) 2014 com.charlesgrier. All rights reserved.
//

#import "BaseCurrencyTableViewController.h"
#import "BaseCurrency.h"
#import "MainViewController.h"
#import "Item.h"

@interface BaseCurrencyTableViewController ()
{
    
    
    NSArray *_baseCurrencies;
    NSArray *_searchResults;
    
}

@end

@implementation BaseCurrencyTableViewController

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
    
    //_currencies = [[NSMutableArray alloc]initWithCapacity:20];
    
    //BaseCurrency *currency;
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    
    NSString *myListPath = [[NSBundle mainBundle] pathForResource:@"CurrencyDict" ofType:@"plist"];
    _baseCurrencies = [[NSMutableArray alloc]initWithContentsOfFile:myListPath];
    NSLog(@"%@",_baseCurrencies);
    
    
    
    
    
    
    //Plist example
    
    // Find out the path of CurrencyCodes.plist
    
    // Load the file content and read the data into arrays
    
    
    
    
    
    
    
    
}

// search predicate
- (void)filterContentForSearchText:(NSString*)searchText scope:(NSString*)scope
{
    NSPredicate *resultPredicate = [NSPredicate predicateWithFormat:@"currencyName matches[c] %@ OR currencyName contains[c] %@ OR currencyCode contains[c] %@", searchText, searchText, searchText];
    
    //NSPredicate *resultPredicate = [NSPredicate predicateWithFormat:@"currencyName contains[c] %@ ", searchText];
    
    _searchResults = [_baseCurrencies filteredArrayUsingPredicate:resultPredicate];
}

// automatically called every time when the search string changes
-(BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString
{
    [self filterContentForSearchText:searchString
                               scope:[[self.searchDisplayController.searchBar scopeButtonTitles]
                                      objectAtIndex:[self.searchDisplayController.searchBar
                                                     selectedScopeButtonIndex]]];
    
    return YES;
}

- (IBAction)cancel:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    // Return the number of sections.
    return 1;
    
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    // Return the number of rows in the section.
    if (tableView == self.searchDisplayController.searchResultsTableView) {
        return [_searchResults count];
        
    } else {
        return [_baseCurrencies count];
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"BaseCurrencyName" forIndexPath:indexPath];
    
    
    if (tableView == self.searchDisplayController.searchResultsTableView) {
        UILabel *label = (UILabel *)[cell viewWithTag:1000];
        label.text = [[_searchResults objectAtIndex:indexPath.row]objectForKey:@"currencyName"];
        
        
        
        UILabel *labelCode = (UILabel *)[cell viewWithTag:1001];
        labelCode.text = [[_searchResults objectAtIndex:indexPath.row]objectForKey:@"currencyCode"];
        
        
        UIImageView *imageName = (UIImageView *) [cell viewWithTag:1002];
        imageName.image =  [UIImage imageNamed:[[_searchResults objectAtIndex:indexPath.row]objectForKey:@"imageName"]];
        
        
        
        
        
        return cell;
        
    } else {
        
        UILabel *label = (UILabel *)[cell viewWithTag:1000];
        label.text = [[_baseCurrencies objectAtIndex:indexPath.row]objectForKey:@"currencyName"];
      
        
        
        UILabel *labelCode = (UILabel *)[cell viewWithTag:1001];
        labelCode.text = [[_baseCurrencies objectAtIndex:indexPath.row]objectForKey:@"currencyCode"];
        
        
        UIImageView *imageName = (UIImageView *) [cell viewWithTag:1002];
        imageName.image =  [UIImage imageNamed:[[_baseCurrencies objectAtIndex:indexPath.row]objectForKey:@"imageName"]];
        
        
        return cell;
    }
    
    
}




-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    if (self.searchDisplayController.active){
        
        indexPath = [self.searchDisplayController.searchResultsTableView indexPathForSelectedRow];
        BaseCurrency *baseCurrency = _searchResults[indexPath.row];
        baseCurrency = [[BaseCurrency alloc]init];
        baseCurrency.toFullName = [[_searchResults objectAtIndex:indexPath.row]objectForKey:@"currencyName"];
        baseCurrency.toCodeName = [[_searchResults objectAtIndex:indexPath.row]objectForKey:@"currencyCode"];
        
        baseCurrency.imageName = [[_searchResults objectAtIndex:indexPath.row]objectForKey:@"imageName"];
        //baseCurrency.oldRateToUSD = [[_searchResults objectAtIndex:indexPath.row]objectForKey:@"oldRateToUSD"];
        
        
        [self.delegate baseCurrencyPicker:self didPickBaseCurrency:baseCurrency];
        
    } else {
        BaseCurrency *baseCurrency = _baseCurrencies[indexPath.row];
        baseCurrency = [[BaseCurrency alloc]init];
        baseCurrency.toFullName = [[_baseCurrencies objectAtIndex:indexPath.row]objectForKey:@"currencyName"];
        baseCurrency.toCodeName = [[_baseCurrencies objectAtIndex:indexPath.row]objectForKey:@"currencyCode"];
        
        baseCurrency.imageName = [[_baseCurrencies objectAtIndex:indexPath.row]objectForKey:@"imageName"];
        //baseCurrency.oldRateToUSD = [[_baseCurrencies objectAtIndex:indexPath.row]objectForKey:@"oldRateToUSD"];
        //[_currencies addObject:currency];
        //Currency *currency = _currencies[indexPath.row];
        
        //NSString *codeName = currency.codeName;
        
        [self.delegate baseCurrencyPicker:self didPickBaseCurrency:baseCurrency];
    }

    
    
    
    
    
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

/*
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
 {
 
 if ([[segue identifier] isEqualToString:@"addCurrency"]) {
 MainViewController *mvc = [segue destinationViewController];
 
 NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
 
 Currency *c = [_currencies objectAtIndex:[indexPath row]];
 //Currency *c = [[_currencies objectAtIndex:indexPath.row]objectForKey:@"currencyCode"];
 [mvc setCode:c];
 
 
 
 
 }
 
 
 }
 
 */



/*
 DisplayViewController *dvc = [segue destinationViewController];
 //this tells us the table cell that we selected....
 NSIndexPath *path = [self.tableView indexPathForSelectedRow];
 //this gets the current photo from the array
 Photo *c = [photos objectAtIndex:[path row]];
 [dvc setCurrentPhoto:c]   ;    }
 
 
 */




@end
