//
//  CurrencyPickerViewController.m
//  BorderCompare
//
//  Created by Charles Grier on 5/7/14.
//  Copyright (c) 2014 com.charlesgrier. All rights reserved.
//

#import "CurrencyPickerViewController.h"
#import "Currency.h"
#import "MainViewController.h"
#import "Item.h"

@interface CurrencyPickerViewController ()
{

    NSArray *_currencies;
    NSArray *_searchResults;
}

@end

@implementation CurrencyPickerViewController

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
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
    NSString *myListPath = [[NSBundle mainBundle] pathForResource:@"CurrencyDict" ofType:@"plist"];
    _currencies = [[NSMutableArray alloc]initWithContentsOfFile:myListPath];
 
}

#pragma mark - Table view search predicate

// search predicate
- (void)filterContentForSearchText:(NSString*)searchText scope:(NSString*)scope
{
    NSPredicate *resultPredicate = [NSPredicate predicateWithFormat:@"currencyName matches[c] %@ OR currencyName contains[c] %@ OR currencyCode contains[c] %@", searchText, searchText, searchText];
    
    //NSPredicate *resultPredicate = [NSPredicate predicateWithFormat:@"currencyName contains[c] %@ ", searchText];
    
    _searchResults = [_currencies filteredArrayUsingPredicate:resultPredicate];
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
        return [_currencies count];
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"CurrencyName" forIndexPath:indexPath];
    
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
        label.text = [[_currencies objectAtIndex:indexPath.row]objectForKey:@"currencyName"];
        
        UILabel *labelCode = (UILabel *)[cell viewWithTag:1001];
        labelCode.text = [[_currencies objectAtIndex:indexPath.row]objectForKey:@"currencyCode"];
        
        UIImageView *imageName = (UIImageView *) [cell viewWithTag:1002];
        imageName.image =  [UIImage imageNamed:[[_currencies objectAtIndex:indexPath.row]objectForKey:@"imageName"]];
        
        return cell;
    }
    
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (self.searchDisplayController.active){
        
        indexPath = [self.searchDisplayController.searchResultsTableView indexPathForSelectedRow];
        Currency *currency = _searchResults[indexPath.row];
        currency = [[Currency alloc]init];
        currency.fromFullName = [[_searchResults objectAtIndex:indexPath.row]objectForKey:@"currencyName"];
        currency.fromCodeName = [[_searchResults objectAtIndex:indexPath.row]objectForKey:@"currencyCode"];

        currency.imageName = [[_searchResults objectAtIndex:indexPath.row]objectForKey:@"imageName"];
        currency.oldRateToUSD = [[_searchResults objectAtIndex:indexPath.row]objectForKey:@"oldRateToUSD"];
    
        currency.toCodeName = @"USD";
    
        [self.delegate currencyPicker:self didPickCurrency:currency];
        
    
    } else {
        Currency *currency = _currencies[indexPath.row];
        currency = [[Currency alloc]init];
        currency.fromFullName = [[_currencies objectAtIndex:indexPath.row]objectForKey:@"currencyName"];
        currency.fromCodeName = [[_currencies objectAtIndex:indexPath.row]objectForKey:@"currencyCode"];
        
        currency.imageName = [[_currencies objectAtIndex:indexPath.row]objectForKey:@"imageName"];
        currency.oldRateToUSD = [[_currencies objectAtIndex:indexPath.row]objectForKey:@"oldRateToUSD"];
        
        [self.delegate currencyPicker:self didPickCurrency:currency];
    }
    
}



@end
