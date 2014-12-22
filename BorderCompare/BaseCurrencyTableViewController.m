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
    
    NSString *myListPath = [[NSBundle mainBundle] pathForResource:@"CurrencyDict" ofType:@"plist"];
    _baseCurrencies = [[NSMutableArray alloc]initWithContentsOfFile:myListPath];

}

#pragma mark - Table view search predicate

// search predicate for tableview currency search
- (void)filterContentForSearchText:(NSString*)searchText scope:(NSString*)scope
{
    NSPredicate *resultPredicate = [NSPredicate predicateWithFormat:@"currencyName matches[c] %@ OR currencyName contains[c] %@ OR currencyCode contains[c] %@", searchText, searchText, searchText];

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
        
        [self.delegate baseCurrencyPicker:self didPickBaseCurrency:baseCurrency];
        
    } else {
        BaseCurrency *baseCurrency = _baseCurrencies[indexPath.row];
        baseCurrency = [[BaseCurrency alloc]init];
        baseCurrency.toFullName = [[_baseCurrencies objectAtIndex:indexPath.row]objectForKey:@"currencyName"];
        baseCurrency.toCodeName = [[_baseCurrencies objectAtIndex:indexPath.row]objectForKey:@"currencyCode"];
        
        baseCurrency.imageName = [[_baseCurrencies objectAtIndex:indexPath.row]objectForKey:@"imageName"];
        
        [self.delegate baseCurrencyPicker:self didPickBaseCurrency:baseCurrency];
    }
    
}

@end
