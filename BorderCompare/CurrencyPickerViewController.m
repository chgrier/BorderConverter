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

    
    NSMutableArray *_currencies;

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
    
   _currencies = [[NSMutableArray alloc]initWithCapacity:20];
    
    Currency *currency;
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    
    currency = [[Currency alloc]init];
    currency.fromFullName = @"United States Dollar";
    currency.fromCodeName = @"USD";
    currency.imageName = @"USD.png";
    [_currencies addObject:currency];
    
    currency = [[Currency alloc]init];
    currency.fromFullName = @"Mexican Peso";
    currency.fromCodeName = @"MXN";
    currency.imageName = @"MXN";
    [_currencies addObject:currency];
  
    currency = [[Currency alloc]init];
    currency.fromFullName = @"Canadian Dollar";
    currency.fromCodeName = @"CAD";
    currency.imageName = @"CAD";
    [_currencies addObject:currency];
    
    currency = [[Currency alloc]init];
    currency.fromFullName = @"European Union Euro";
    currency.fromCodeName = @"EUR";
    currency.imageName = @"EUR";
    [_currencies addObject:currency];
   
    
     //Plist example
     
     // Find out the path of CurrencyCodes.plist
     
     // Load the file content and read the data into arrays
   
    
    
    

    
     
//    NSString *myListPath = [[NSBundle mainBundle] pathForResource:@"CurrencyDict" ofType:@"plist"];
//    _currencies = [[NSMutableArray alloc]initWithContentsOfFile:myListPath];
//    NSLog(@"%@",_currencies);
    
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
    return [_currencies count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CurrencyName" forIndexPath:indexPath];
    
    // Configure the cell...
    Currency *currency = _currencies[indexPath.row];
   
    
    
    UILabel *label = (UILabel *)[cell viewWithTag:1000];
    label.text = currency.fromFullName;
    
    UILabel *labelCode = (UILabel *)[cell viewWithTag:1001];
    labelCode.text = currency.fromCodeName;
    
    UIImageView *imageName = (UIImageView *) [cell viewWithTag:1002];
    imageName.image = [UIImage imageNamed:currency.imageName];
   
    
    
    /*
    UILabel *label = (UILabel *)[cell viewWithTag:1000];
    label.text = [[_currencies objectAtIndex:indexPath.row]objectForKey:@"currencyName"];
    //label.text = currency.name;
    
    
    UILabel *labelCode = (UILabel *)[cell viewWithTag:1001];
    labelCode.text = [[_currencies objectAtIndex:indexPath.row]objectForKey:@"currencyCode"];
    //labelCode.text = currency.code;
    
    UIImageView *imageName = (UIImageView *) [cell viewWithTag:1002];
    imageName.image =  [UIImage imageNamed:[[_currencies objectAtIndex:indexPath.row]objectForKey:@"imageName"]];
    //imageName.image = [UIImage imageNamed:currency.imageName];
    */
    
    
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
   //[tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    //NSString *codeName = [_currencies[indexPath.row]objectForKey:@"codeName"];
    
    Currency *currency = _currencies[indexPath.row];
    //NSString *codeName = currency.codeName;
    
    [self.delegate currencyPicker:self didPickCurrency:currency];
    
    //Currency *code = [[_currencies objectAtIndex:indexPath.row]objectForKey:@"currencyCode"];
    
    
    //[self performSegueWithIdentifier:@"addCurrency"
     //                         sender:code];
    
    //[self dismissViewControllerAnimated:YES completion:nil];
    
    
    
    
    
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
