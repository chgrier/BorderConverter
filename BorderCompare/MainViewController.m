//
//  ViewController.m
//  BorderCompare
//
//  Created by Charles Grier on 2/24/14.
//  Copyright (c) 2014 com.charlesgrier. All rights reserved.
//

#import "MainViewController.h"
#import "Currency.h"
#import "Item.h"
#import "Reachability.h"

#define kCategoryComponent 0
#define kItemComponent 1
#define kComponentCount 2

@interface MainViewController ()
//<UIPickerViewDataSource, UIPickerViewDelegate>
@end

@implementation MainViewController
{
    float _fxValue;
    float _minValue;
    float _maxValue;
    float _fxUpdatedRate;
    float _roundedValue;
    
    float _initialValue;
   
    
    NSMutableArray *_userData;
    
    NSString * _holder;
    
    BOOL _pickerVisible;
    
    NSMutableArray *_items;
    NSMutableArray *_itemCategories;
    
    NSMutableArray *_produceArray;
    
    Item *_newItem;
    
    NSString * _codeName;

    
    NSString *_currencyName;
    
    

    
}


-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    
    
}
/*
-(void)cancelNumberPad{
    [_priceTextField resignFirstResponder];
    _priceTextField.text = @"";
}

-(void)doneWithNumberPad{
    NSString *numberFromTheKeyboard = _priceTextField.text;
    [_priceTextField resignFirstResponder];
}
*/
- (void)viewDidLoad
{
    [super viewDidLoad];

    
    
    CGSize result = [[UIScreen mainScreen] bounds].size;
    if(result.height == 480)
    {
        // iPhone Classic
        self.exchangeRateField.frame = CGRectMake(140, 376, 159, 17);
        
    } else {
        
    }
    
    /*
    UIToolbar* numberToolbar = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, 320, 50)];
    numberToolbar.barStyle = UIBarStyleBlackTranslucent;
    numberToolbar.items = [NSArray arrayWithObjects:
                           [[UIBarButtonItem alloc]initWithTitle:@"Cancel" style:UIBarButtonItemStyleBordered target:self action:@selector(cancelNumberPad)],
                           [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil],
                           [[UIBarButtonItem alloc]initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(doneWithNumberPad)],
                           nil];
    [numberToolbar sizeToFit];
    _priceTextField.inputAccessoryView = numberToolbar;
*/


    
    Reachability *reach = [Reachability reachabilityForInternetConnection];
    NetworkStatus status = [reach currentReachabilityStatus];
    
    
    if (status == NotReachable) {
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"No Internet Connection"
                                                        message:[self stringFromStatus:status] delegate:nil
                                              cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        
       
        
    }

    
    
    //self.sliderBar.value = (self.sliderBar.maximumValue - self.sliderBar.minimumValue);
     self.sliderBar.value = .5;
    
    
    
    if (self.code != nil){
        self.title = @"Border Compare";
        //_codeName = self.code.codeName;
        NSLog(@"***Codename: %@", self.code.fromCodeName);
        
    }
    
    
    
    /*
     currency = [[Currency alloc]init];
     currency.name = @"United States Dollar";
     currency.code = @"USD";
     currency.imageName = @"USD.png";
     [_currencies addObject:currency];
     */
    
   NSString *myListPath = [[NSBundle mainBundle] pathForResource:@"ItemDict" ofType:@"plist"];
   _items = [[NSMutableArray alloc]initWithContentsOfFile:myListPath];
    NSLog(@"%@",_items);
    
   // _items = [[NSMutableArray alloc]initWithCapacity:20];
    //Item *item;
    
    
    /*
    item = [[Item alloc]init];
    item.name = @"Bannanas";
    item.price = [NSNumber numberWithFloat:0.60];
    item.fromUnit = @"kg";
    item.toUnit = @"lb";
    [_items addObject:item];
    
    item = [[Item alloc]init];
    item.name = @"Lemons";
    item.price = [NSNumber numberWithFloat:1.67];
    item.fromUnit = @"kg";
    item.toUnit = @"lb";
    [_items addObject:item];
    
    item = [[Item alloc]init];
    item.name = @"Oranges";
    item.price = [NSNumber numberWithFloat:1.14];
    item.fromUnit = @"kg";
    item.toUnit = @"lb";
    [_items addObject:item];
    
    item = [[Item alloc]init];
    item.name = @"Gasoline, unleaded regular";
    item.price = [NSNumber numberWithFloat:3.36];
    item.fromUnit = @"ℓ";
    item.toUnit = @"gal";
    [_items addObject:item];
    
    */
    /*
     _itemNames = @[@"Bannanas",@"Lemons",@"Oranges"];
     _itemAvgPrice = @[@0.60f, @1.67f, @1.14f];
     _itemMetricUnits = @[@"kg", @"kg", @"kg"];
     _itemImperialUnits = @[@"lb", @"lb", @"lb"];
     
     _itemCategory = @[@"Produce",@"Meat",@"Fuel"];
     */
    
    /*
    // get path for plist
    NSBundle *bundle = [NSBundle mainBundle];
    NSURL *plistURL = [bundle URLForResource:@"ItemListPrices" withExtension:@"plist"];
    
    // define NSDictionary *itemList
    _itemList = [NSDictionary dictionaryWithContentsOfURL:plistURL];
    
    NSLog(@"itemList dictionary : %@", _itemList);
    
    
    _itemCategory = [_itemList allKeys];
    
    // create array to hold dictionary's keys
    
    NSString *selectedItem = self.itemCategory[0];
    self.items = self.itemList[selectedItem];
    */
    
    
    
    
    /*
     // get path for plist
     NSBundle *bundle = [NSBundle mainBundle];
     NSURL *plistURL = [bundle URLForResource:@"ItemList" withExtension:@"plist"];
     
     // define NSDictionary *itemList
     self.itemList = [NSDictionary dictionaryWithContentsOfURL:plistURL];
     NSLog(@"Item list array : %@", self.itemList);
     
     // create array to hold dictionary's keys
     //NSArray *allCategories = [self.itemList allKeys];
     //if need to sort categories
     //NSArray *sortedCategories = [allCategories sortedArrayUsingSelector:@selector(compare:)];
     //self.category = allCategories;
     
     self.category = [self.itemList allKeys];
     NSLog(@"Category array: %@", self.category);
     
     // what does the [0] do?
     NSString *selectedCategory = self.category[0];
     self.items = self.itemList[selectedCategory];
     NSLog(@"Items array: %@", self.items);
     // get prices into an array
     */
    
    /*
     //plist path
     NSBundle *bundle = [NSBundle mainBundle];
     NSURL *plistURL = [bundle URLForResource:@"ItemListPrices" withExtension:@"plist"];
     // get categories (same as above -- from arrays)
     self.itemList = [NSDictionary dictionaryWithContentsOfURL:plistURL];
     NSLog(@"Item list array : %@", self.itemList);
     
     // get categories from dictionary keys?
     self.category = [self.itemList allKeys];
     NSLog(@"Category array: %@", self.category);
     
     NSString *str = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"ItemListPrices.plist"];
     NSDictionary *tempDict = [[NSDictionary alloc] initWithContentsOfFile:str];
     
     
     NSArray *meatArray = [tempDict objectForKey:@"Meat"];
     NSLog(@"Meat Array : %@", meatArray);
     */
    
    /*
     
     NSString *path = [[NSBundle mainBundle] pathForResource:@"ItemListPrices" ofType:@"plist"];
     self.itemList = [[NSDictionary alloc] initWithContentsOfFile:path];
     
     NSArray *produceArray = [myDict objectForKey:@"Produce"];
     NSArray *meatArray = [myDict objectForKey:@"Meat"];
     
     //This goes in tableView: cellForRowAtIndexPath:
     
     cell.text = [[tableArray objectAtIndex:row]objectForKey:@"Obj Name"];
     
     
     
     
     */
    
    
    
    
    /*
     //Get the bundle path for the plist file
     NSString *str = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"ItemListPrices.plist"];
     
     //Read the contents from plist dictionary
     NSDictionary *tempDict = [[NSDictionary alloc] initWithContentsOfFile:str];
     
     //Dictionary to nsarray
     NSArray *produceArray = [tempDict objectForKey:@"Produce"];
     
     //Display array data
     NSLog(@"Produce Array : %@", produceArray);
     
     NSArray *meatArray = [tempDict objectForKey:@"Meat"];
     NSLog(@"Meat Array : %@", meatArray);
     
     self.items = @[produceArray, meatArray];
     NSLog(@"all items: %@", self.items);
     
     NSString *selectedCategory = self.category[0];
     self.items = self.itemList[selectedCategory];
     NSLog(@"Items: %@", self.items);
    */
    
    /*
     // get path for plist
     NSBundle *bundle = [NSBundle mainBundle];
     NSURL *plistURL = [bundle URLForResource:@"ItemListPrices" withExtension:@"plist"];
     
     // define NSDictionary *itemList
     _itemList = [NSDictionary dictionaryWithContentsOfURL:plistURL];
     
     NSLog(@"itemList dictionary : %@", _itemList);
     
     
     _itemCategory = [_itemList allKeys];
     
     // create array to hold dictionary's keys
     
     NSString *selectedItem = self.itemCategory[0];
     self.items = self.itemList[selectedItem];
     */
     
    
    UITapGestureRecognizer *gestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(closePicker)];
    //gestureRecognizer.cancelsTouchesInView = NO;
    [self.view addGestureRecognizer:gestureRecognizer];
    

    
    
}


- (NSString *)stringFromStatus:(NetworkStatus) status {
    
    NSString *string;
    switch(status) {
        case NotReachable:
            string = @"Please connect to the internet to download current exchange rates. \n \n Historical exchange rates are available for currencies when USD is set as the base currency.";
            
            
            break;
        case ReachableViaWiFi:
            string = @"Reachable via WiFi";
            break;
        case ReachableViaWWAN:
            string = @"Reachable via WWAN";
            break;
        default:
            string = @"Unknown";
            break;
    }
    return string;
}




- (void) reachabilityChanged: (NSNotification *)notification {
    Reachability *reach = [notification object];
    if( [reach isKindOfClass: [Reachability class]]) {
        NetworkStatus status = [reach currentReachabilityStatus];
        if (status == NotReachable){
           NSLog(@"**********************NOT REACHABLE");
        }}
}

- (IBAction)updateExchangeRateButton:(id)sender {
    [self updateExchangeRate];
    [self updateLabel];
}

-(void)updateExchangeRate{
    
    
    if (self.code.fromCodeName != nil && self.baseCode.toCodeName != nil) {
        
        NSLog(@"BASE CODE: %@", self.baseCode.toCodeName);
    NSString *fromCurr = self.code.fromCodeName;
    NSString *toCurr = self.baseCode.toCodeName;
        
        
    // URL request get exchange rate for currencies
    NSString *urlAsString = @"http://finance.yahoo.com/d/quotes.csv?s=";
    
    urlAsString = [urlAsString stringByAppendingString:fromCurr];
    urlAsString = [urlAsString stringByAppendingString:toCurr];
        
    
    
    urlAsString = [urlAsString stringByAppendingString:@"=X&f=sl1d1t1c1ohgv&e=.csv"];
        
    NSURL *url = [NSURL URLWithString:urlAsString];
    
    NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:url];
    [urlRequest setTimeoutInterval:1.0f];
    [urlRequest setHTTPMethod:@"GET"];
    
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    
    [NSURLConnection
     sendAsynchronousRequest:urlRequest
     queue:queue
     completionHandler:^(NSURLResponse *response,
                         NSData *data,
                         NSError *error
                         
                         )
                         {
         
         if ([data length] >0  &&
             error == nil){
             NSString *html = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
             NSArray *substrings = [html componentsSeparatedByString:@","];
             NSString *value = substrings[1];
             
            
             // create string to hold value of exchange rate
             //NSString *holder = [NSString stringWithFormat:@"%@",value];
             
             _holder = [NSString stringWithFormat:@"%@",value];
             
             float inverse = 1/ [value floatValue];
             NSLog(@"INVERSE: %.2f", inverse);
             
             
             //self.slider.value = (self.slider.minimumValue /2);
             
             NSLog(@"****value %@", _holder);
         
             self.code.rate = [_holder floatValue];
             NSLog(@"*****Float value of exchange rate %f", self.code.rate);
             
            
                 float minimumValue = self.code.rate * .9;  // slider min value to 20% less than initial exchange rate
                 float maximumValue = self.code.rate * 1.1;  // slider max value to 20% greater than initial exchange rate
                 float initialValue = maximumValue - minimumValue;
             _sliderBar.minimumValue = minimumValue;   // sets min value
             _sliderBar.maximumValue = maximumValue;    // sets max value
             _sliderBar.value = initialValue;
             
             //[_slider setValue:self.code.rate animated:YES];

             
         /* dispatch back to the main queue for UI */
         
             // initialize variable to hold new value
             //ExchangeValue *newExchange = [[ExchangeValue alloc] init];
             
             // pass holder value to
             //[newExchange setFxvalue:holder];
             
             //NSLog(@"Secor says new value is: %@",  newExchange.fxvalue);
             
             // NSLog(@"Exchange rate set to fxvalue object in ExchangeValue class:%@",currentExchange);
             
             _exchangeRateField.text = [NSString stringWithFormat:@"%@",value];
             
             //_exchangeRateHolder.text = [NSString stringWithFormat:@"%@",value];
    
             
             //_exchangeField.text = [NSString stringWithFormat:@"1 %@ =", fromCurr];
             // toCurrField.text = toCurr
             //NSLog(@"1 %@ = %@ %@",fromCurr,value,toCurr);
             
             
             
         }
         else if ([data length] == 0 &&
                  error == nil){
             
             NSLog(@"Nothing was downloaded.");
             _holder = [NSString stringWithFormat:@"%@",self.code.oldRateToUSD];
             //_holder = self.code.oldRateToUSD;
             self.code.rate = [_holder floatValue];
             
             
             
             
              //self.code.rate = [self.code.oldRateToUSD floatValue];
             
             
             float minimumValue = self.code.rate * .9;  // slider min value to 20% less than initial exchange rate
             float maximumValue = self.code.rate * 1.1;  // slider max value to 20% greater than initial exchange rate
             float initialValue = maximumValue - minimumValue;
             _sliderBar.minimumValue = minimumValue;   // sets min value
             _sliderBar.maximumValue = maximumValue;    // sets max value
             _sliderBar.value = initialValue;

         }
         else if (error != nil){
             NSLog(@"Error happened = %@", error);
             
             _holder = [NSString stringWithFormat:@"%@",self.code.oldRateToUSD];
             //_holder = self.code.oldRateToUSD;
             self.code.rate = [_holder floatValue];
             
             //self.code.rate = [self.code.oldRateToUSD floatValue];
             
             float minimumValue = self.code.rate * .9;  // slider min value to 20% less than initial exchange rate
             float maximumValue = self.code.rate * 1.1;  // slider max value to 20% greater than initial exchange rate
             float initialValue = maximumValue - minimumValue;
             _sliderBar.minimumValue = minimumValue;   // sets min value
             _sliderBar.maximumValue = maximumValue;    // sets max value
             _sliderBar.value = initialValue;
             
             NSLog(@"Old Code is equal to : %@", self.code.oldRateToUSD);
    
         }
         else {
              _fromCurrencyCodeField.text = @"select";
             
             
         }
         
         
        
         
    
    //self.stepperValue.value = 0;
    [self updateLabel];
    [self calculate];
    [self performSelectorOnMainThread:@selector(updateLabel) withObject:nil waitUntilDone:YES];
    [self performSelectorOnMainThread:@selector(calculate) withObject:nil waitUntilDone:YES];
    [self performSelectorOnMainThread:@selector(self) withObject:nil waitUntilDone:YES];
    
     }];
}
    }


-(void)showAlert
{
    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"HI" message:@"Test" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"ok", nil];
    [alertView show];
}
     
/*
-(void)loadUserData{
    NSString *path = [self dataFilePath];
    if ([[NSFileManager defaultManager] fileExistsAtPath:path]) {
        NSData *data = [[NSData alloc] initWithContentsOfFile:path];
        NSKeyedUnarchiver *unarchiver = [[NSKeyedUnarchiver alloc]
                                         initForReadingWithData:data];
        _code = [unarchiver decodeObjectForKey:@"UserItems"];
        [unarchiver finishDecoding];
    }
}


- (id)initWithCoder:(NSCoder *)aDecoder
{
    if ((self = [super initWithCoder:aDecoder])) {
        _currencyName = @"MXN";
    }
    return self;
}


- (NSString *)documentsDirectory{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    NSString *documentsDirectory = [paths firstObject];
    return documentsDirectory;
}


- (NSString *)dataFilePath
{
    return [[self documentsDirectory]
            stringByAppendingPathComponent:@"UserSettings.plist"];
}

-(void)saveUserData{
    NSMutableData *data = [[NSMutableData alloc]init];
    NSKeyedArchiver *archiver = [[NSKeyedArchiver alloc]initForWritingWithMutableData:data];
    [archiver encodeObject:_code forKey:@"UserItems"];
    [archiver finishEncoding];
    [data writeToFile:[self dataFilePath] atomically:YES];
}
 */

- (IBAction)convert:(id)sender {
    [self updateExchangeRate];
    
   
}



#pragma mark PickerView DataSource




- (NSInteger)numberOfComponentsInPickerView:
(UIPickerView *)pickerView
{
    //return kComponentCount;
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView
numberOfRowsInComponent:(NSInteger)component
{

    
        //return _itemNames.count;
    return self.items.count;
    
   /*
    if (component == kCategoryComponent) {
        return [_itemCategory count];
    } else {
        return [_items count];
    }
    */
    
}


- (NSString *)pickerView:(UIPickerView *)pickerView
             titleForRow:(NSInteger)row
            forComponent:(NSInteger)component
{
    //return _itemNames[row];
    //Currency *currency = _currencies[indexPath.row];
    
    
    Item *item = [[Item alloc]init];
    //item = [_items objectAtIndex:row];
    item.name = [[_items objectAtIndex:row]objectForKey:@"itemName"];
    return item.name;
    
    /*
   if(component == kCategoryComponent) {
        return self.itemCategory[row];
    } else {
        
        item.name = [[_items objectAtIndex:row]objectForKey:@"Item"];
        return item.name;
    }
     */

}
/*
if (component == kStateComponent) {
    return self.states[row];
} else {
    return self.zips[row];
}
*/

#pragma mark PickerView Delegate
-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row
      inComponent:(NSInteger)component
{
    /*
    if (component == kStateComponent) {
        NSString *selectedState = self.states[row];
        self.zips = self.stateZips[selectedState];
        [self.dependentPicker reloadComponent:kZipComponent];
        [self.dependentPicker selectRow:0
                            inComponent:kZipComponent
                               animated:YES];
     
     
     NSString *selectedItem = self.itemCategory[0];
     self.items = self.itemList[selectedItem];
    }

    if (component == kCategoryComponent) {
        //NSString *selectedItem = self.itemCategory[row];
       
        //self.items = self.itemList[row];
        
        [self.itemPicker reloadComponent:kItemComponent];
        [self.itemPicker selectRow:0
                       inComponent:kItemComponent
                         animated:YES];
        */
        self.item = [[Item alloc]init];
        
        self.item.name = [[self.items objectAtIndex:row]objectForKey:@"itemName"];
        self.item.price = [[self.items objectAtIndex:row]objectForKey:@"itemPrice"];
        self.item.fromUnit = [[self.items objectAtIndex:row]objectForKey:@"itemFromUnit"];
        self.item.toUnit = [[self.items objectAtIndex:row]objectForKey:@"itemToUnit"];
        

    

    
    //Item *selectedItem = [[Item alloc]init];
    //selectedItem = [_items objectAtIndex:row];
    //self.item = [_items objectAtIndex:row];
    
    float rate = [self.item.price floatValue];
    NSString *avgPriceString = [[NSString alloc] initWithFormat:
                                @"$%.2f", rate];
    _avgPriceLabel.text = avgPriceString;
    
    self.itemName.text = self.item.name;
    
    _fromUnitField.text = [NSString stringWithFormat:@"per %@", self.item.fromUnit];
    _toUnitField.text = [NSString stringWithFormat:@"per %@", self.item.toUnit];
    
    if ([self.toCurrencyCodeField isEqual:@"USD"])
    {
        self.avgPriceUnit.text = [NSString stringWithFormat:@"per %@", self.item.toUnit];
        
    }
    
    [self calculate];
    
    //[self.priceTextField becomeFirstResponder];
    
    NSLog(@"item.fromUnit: %@; item.toUnit: %@", self.item.fromUnit, self.item.toUnit);
    
}

/*
- (CGFloat)pickerView:(UIPickerView *)pickerView
    widthForComponent:(NSInteger)component
{
    if (component == kCategoryComponent) {
        return 120;
    } else {
        return 200;
    }
}
*/
-(IBAction)dismissUIPickerView:(id)sender{
    
    [self closePicker];
    
}

-(IBAction)selectItem:(id)sender{
    //open picker view
    
    [self.priceTextField resignFirstResponder];
    
    
    //[_pickerViewHolder setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"chalkboardSmall.png"]]];
    
    
    
    //UIPickerView has 8 subviews like, background, rows, container etc.
    // hide unnecessary subview
    
    
    
    CGSize result = [[UIScreen mainScreen] bounds].size;
    if(result.height == 480)
    {
        // iPhone Classic
        [UIView animateWithDuration:0.3 animations:^{
            _pickerViewHolder.frame = CGRectMake(10, 270,
                                                 _pickerViewHolder.frame.size.width,
                                                 _pickerViewHolder.frame.size.height);
            
            
        }];

        
    } else {
    
    [UIView animateWithDuration:0.3 animations:^{
        _pickerViewHolder.frame = CGRectMake(10, 350,
                                       _pickerViewHolder.frame.size.width,
                                       _pickerViewHolder.frame.size.height);
        
        
    }];
    }
}

- (IBAction)switchUnits:(id)sender {
    
    /*if ([self.item.unitMetric isEqualToString:@"kg"]) {
        self.item.unitMetric = @"lb";
        self.item.unitImperial = @"kg";
    }
    
    else if ([self.item.unitMetric isEqualToString:@"lb"]) {
        self.item.unitMetric = @"kg";
        self.item.unitImperial = @"lb";
    }
    */
    [self.item toggleUnits];
    [self updateLabel];
 
    
}

-(void)closePicker
{
    [UIView animateWithDuration:0.2 animations:^{
        _pickerViewHolder.frame = CGRectMake(-300,
                                       150, //Displays the view off the screen
                                       _pickerViewHolder.frame.size.width,
                                       _pickerViewHolder.frame.size.height);
        
    }];
    
}

- (IBAction)cancel:(id)sender {
    [UIView animateWithDuration:0.2 animations:^{
        _pickerViewHolder.frame = CGRectMake(-300,
                                             150, //Displays the view off the screen
                                             _pickerViewHolder.frame.size.width,
                                             _pickerViewHolder.frame.size.height);
        _resultTextFieldCompare.text = @"";
        _avgPriceLabel.text = @"";
        self.itemName.text = @"";
        _fromUnitField.text = @"";
        _toUnitField.text = @"";
        _resultCompareUnit.text = @"";
        _avgPriceUnit.text = @"";
        
        
        self.item.name = nil;
        self.item.price = nil;
        self.item.fromUnit = nil;
        self.item.toUnit = nil;
        
        
        [self calculate];
        
    }];
    
    
}

-(void)updateLabel
{
    
    //[self.priceTextField becomeFirstResponder];
     //_exchangeRateField.text =  [NSString stringWithFormat:@"%@",_holder];
    
    float inverseHolder = self.code.rate;
    float inverseRate = 1 / inverseHolder;
    
    self.exchangeRateFieldInverse.text = [NSString stringWithFormat:@"%.4f", inverseRate];
    
    if (self.toCurrencyCodeField == nil)
    {
        self.toCurrencyCodeField.text = self.code.toCodeName;
    }
    
    if (self.code.fromCodeName != nil){
        [self.fromCurrencyCodeField setText:[self.code fromCodeName]];
        [self.fromCurrencyCodeFieldTwo setText:[self.code fromCodeName]];
        [self.toCurrencyCodeField setText:[self.baseCode toCodeName]];
        
        [self.toCurrencyCodeFieldTwo setText:[self.baseCode toCodeName]];
        
        [self.currencyCodeFromInverse setText:[self.code fromCodeName]];
        [self.currencyCodeToFromInverse setText:[self.baseCode toCodeName]];
       
        // inverse exchange rate field
        self.exchangeRateInverseField.text = [NSString stringWithFormat:@"1 %@ = %.4f %@", [self.baseCode toCodeName], inverseRate, [self.code fromCodeName]];
        
        if (self.code.rate < .02) {
            self.exchangeRateField.text = [NSString stringWithFormat:@"1 %@ = %.4f %@", [self.code fromCodeName], [_holder floatValue], [self.baseCode toCodeName]];
        } else {
            self.exchangeRateField.text = [NSString stringWithFormat:@"1 %@ = %.4f %@", [self.code fromCodeName], [_holder floatValue], [self.baseCode toCodeName]];
        }
        //self.exchangeRateField.text = [NSString stringWithFormat:@"1 %@ = %.2f %@", [self.code fromCodeName], [_holder floatValue], [self.code toCodeName]];
        
       // self.fromCurrencyImageButton = [UIImage imageNamed:self.code.imageName];
        
        [self.fromCurrencyImageButton setImage:[UIImage imageNamed:self.code.imageName]
                          forState:UIControlStateNormal];
        
        [self.toCurrencyImageButton setImage:[UIImage imageNamed:self.baseCode.imageName]
                                      forState:UIControlStateNormal];
        
        
        
        
        //UIImage *button = UIButtonTypeCustom
        
        

        
        NSString *textValue =  [NSString stringWithFormat:@"%@",_holder];
        float value = [textValue floatValue];
        
       // reset slider
        
      
        
        
            float minimumValue = value * .9;  // slider min value to 20% less than initial exchange rate
            float maximumValue = value * 1.1;  // slider max value to 20% greater than initial exchange rate
            float initialValue = maximumValue - minimumValue;
            
            //_sliderBar.value = initialValue;
            //self.sliderBar.value = self.code.rate;
            float val = self.sliderBar.value;
            self.code.rate = val;
 
        
        if (value != 0) {
            
        
        float currentValue;
        currentValue = value;
        self.sliderBar.value = currentValue;
        } else {
            self.sliderBar.value = .5;
         
            
            
            
            float inverse = 1/ [_holder floatValue];
            NSLog(@"INVERSE: %.2f", inverse);
            
            
            //self.slider.value = (self.slider.minimumValue /2);
            
            NSLog(@"****value %@", _holder);
            
            NSLog(@"*****Float value of exchange rate %f", self.code.rate);
        }

        
        
    } else {
        [_fromCurrencyCodeField setText:@"select"];
        [_fromCurrencyCodeField setTextColor:[UIColor grayColor]];
        [_fromCurrencyCodeFieldTwo setText:@"currency"];
        [_fromCurrencyCodeFieldTwo setTextColor:[UIColor grayColor]];
    }
    
    _itemName.text = _item.name;
    
    /*
    if (![self.code.fromCodeName isEqual:@"USD"]){
        
        _fromUnitField.text = self.item.fromUnit;
        _toUnitField.text = self.item.toUnit;
        
    } else {
        
        _fromUnitField.text = self.item.toUnit;
        _toUnitField.text = self.item.fromUnit;
        
    }
    
    NSLog(@"UNIT METRIC: %@", self.item.fromUnit);
*/
    
    
    Reachability *reach = [Reachability reachabilityForInternetConnection];
    NetworkStatus status = [reach currentReachabilityStatus];
    
    
    if (status == NotReachable) {
        
        _exchangeRateTimeLabel.text = (@"Last updated: June 11, 2014");
        
        
        
    } else {
    
    NSDate *today = [NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    //[formatter setDateFormat:@"hh:mm a"];
    //[formatter setDateFormat:@"MMM dd, YYYY"];
    [formatter setDateStyle:NSDateFormatterLongStyle];
    [formatter setTimeStyle:NSDateFormatterMediumStyle];
    [formatter setTimeZone:[NSTimeZone defaultTimeZone]];
    NSLog(@"Formatted date: %@ in time zone %@", [formatter stringFromDate:today], [formatter timeZone]);
    
    _exchangeRateTimeLabel.text = [NSString stringWithFormat:@"Last updated: %@", [formatter stringFromDate:today]];
    
    }
    
    }




- (void)currencyPickerViewController:(CurrencyPickerViewController *)controller didSelectCurrency:(NSString *)currency{

    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

- (void)baseCurrencyTableViewController:(BaseCurrencyTableViewController *)controller didSelectBaseCurrency:(NSString *)currency{
    
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}



- (IBAction)stepperRate:(UIStepper *)stepper {
    
    NSString *textValue =  [NSString stringWithFormat:@"%@",_holder];
    float value = [textValue floatValue];
    //[stepper setDecrementImage:[UIImage imageNamed:@"CY.png"] forState:UIControlStateNormal];
    
    float val = stepper.value + value;
    self.exchangeRateField.text = [NSString stringWithFormat:@"%.2f", val];
    //float minimumValue = stepper.value * .8;  // slider min value to 20% less than initial exchange rate
    //float maximumValue = stepper.value * 1.2;
    
    //stepper.minimumValue = minimumValue;
    //stepper.maximumValue = maximumValue;
    
    
    
    NSLog(@"%.4f", val);
    
    float adjustedRate = val;
    
    self.code.rate = adjustedRate;
    self.code.inverseRate = 1 / adjustedRate;
    float inverseRate = self.code.inverseRate;
    
    self.exchangeRateFieldInverse.text = [NSString stringWithFormat:@"%.2f", inverseRate];
    
    [self calculate];
}

#pragma mark Slider
// sliderMoved method called when user moves the slider
-(IBAction)sliderMoved:(UISlider *)slider{
   
    
  
    
    
    
    
    
    NSString *textValue =  [NSString stringWithFormat:@"%@",_holder];
    float value = [textValue floatValue];
    
    if (value > 0) {
        float minimumValue = value * .9;  // slider min value to 20% less than initial exchange rate
        float maximumValue = value * 1.1;  // slider max value to 20% greater than initial exchange rate
        float initialValue = maximumValue - minimumValue;
        
        //_sliderBar.value = initialValue;
        //slider.value = self.code.rate;
        float val = slider.value;
        self.code.rate = val;
        
        float adjustedRate = val;
        self.code.rate = adjustedRate;
        self.code.inverseRate = 1 / adjustedRate;
        float inverseRate = self.code.inverseRate;
        
        // exchange rate field
        if (self.code.rate < .02) {
             self.exchangeRateField.text = [NSString stringWithFormat:@"1 %@ = %.4f %@", [self.code fromCodeName], self.code.rate, [self.baseCode toCodeName]];
        } else {
             self.exchangeRateField.text = [NSString stringWithFormat:@"1 %@ = %.2f %@", [self.code fromCodeName], self.code.rate, [self.baseCode toCodeName]];
        }
       
            
        //self.exchangeRateFieldInverse.text = [NSString stringWithFormat:@"%.2f", inverseRate];
        
        // inverse rate field
        
        self.exchangeRateInverseField.text = [NSString stringWithFormat:@"1 %@ = %.2f %@", [self.baseCode toCodeName], inverseRate, [self.code fromCodeName]];
        
        
        slider.minimumValue = minimumValue;   // sets min value
        slider.maximumValue = maximumValue;    // sets max value
        //slider.value = initialValue;
        //_sliderBar.value = slider.value;
        
        NSLog(@"min is %f and max is %f",minimumValue,maximumValue);
        
        NSLog(@"NEW rate is: %.2f", self.code.rate);
    }
    [self updateRate];
    [self calculate];
    
    /*
     _exchangeRate.text = [NSString stringWithFormat:@"%.2f", [sender value]];
     
       Here is what I'm trying to do using a static text field to hold the exchange rate value .  I set the exchangeRateHolder text field in the exchange rate calculation method (around line 428)
     
    
    
    NSString *textValue =  [NSString stringWithFormat:@"%@",_holder];
    float value = [textValue floatValue];
    
    if (value > 0) {
        float minimumValue = value * .8;  // slider min value to 20% less than initial exchange rate
        float maximumValue = value * 1.2;  // slider max value to 20% greater than initial exchange rate
        //mySlider.value = value;
        mySlider.minimumValue = minimumValue;   // sets min value
        mySlider.maximumValue = maximumValue;    // sets max value
        NSLog(@"min is %f and max is %f",minimumValue,maximumValue);
    }
    else
    {
        
        float minimumValue = value + 0;  // slider min value to 20% less than initial exchange rate
        float maximumValue = value + 100;  // slider max value to 20% greater than initial exchange rate
        mySlider.value = value + 50;
        mySlider.minimumValue = minimumValue;   // sets min value
        mySlider.maximumValue = maximumValue;    // sets max value
        NSLog(@"min is %f and max is %f",minimumValue,maximumValue);
    }
     
     
     
     
     
     */

}

- (IBAction)updateRate {
    // Create a Core Animation transition. This will crossfade from what is
    // currently on the screen to the changes that you're making below.
    CATransition *transition = [CATransition animation];
    transition.type = kCATransitionFade;
    
    transition.duration = .1;
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    
    
    [self.view.layer addAnimation:transition forKey:nil];
    
    
}






- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


/*
 
 // start calculating when textentered
 -(BOOL)textField:(UITextField *)theTextField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
 NSString *newText = [theTextField.text stringByReplacingCharactersInRange:range withString:string];
 self.doneBarButton.enabled = ([newText length] > 0);
 return YES;
 }

 
 
 */

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([segue.identifier isEqualToString:@"PickCurrency"] || [segue.identifier isEqualToString:@"SelectCurrency"] ){
        CurrencyPickerViewController *controller = segue.destinationViewController;
        controller.delegate = self;
    }
    
    if ([segue.identifier isEqualToString:@"PickBaseCurrency"] || [segue.identifier isEqualToString:@"SelectBaseCurrency"] ){
        BaseCurrencyTableViewController *controller = segue.destinationViewController;
        controller.delegate = self;
    }

}



#pragma mark Delegate Callback Method

-(void)currencyPicker:(CurrencyPickerViewController *)controller didPickCurrency:(Currency *)currencyCode{
    
    // set selected code passed from picker to code object
    self.code = currencyCode;
    
    
    // set field names for 'from currency'
    self.fromCurrencyCodeField.text = self.code.fromCodeName;
    self.fromCurrencyCodeFieldTwo.text = self.code.fromCodeName;
    self.fromCurrencyFullNameField.text = self.code.fromFullName;
    
    
   // if ([self.baseCode.toCodeName isEqual:nil])
    //{
    //self.baseCode.toCodeName = @"USD";
    
    NSLog(@"----to Code: %@----", self.code.toCodeName);
    //self.toCurrencyCodeField.text = self.baseCode.toCodeName;
    //self.toCurrencyCodeField.text = @"USD";
    //[self.toCurrencyImageButton setImage:[UIImage imageNamed:@"USD"] forState:UIControlStateNormal];
   // }
    
    NSLog(@"**currencyCode.codeName: %@",currencyCode.fromCodeName);
    NSLog(@"***code.fullName %@", self.code.fromFullName);
    NSLog(@"****item.name: %@", self.item.name);
    NSLog(@"----to Code: %@----", self.baseCode.toCodeName);
    
    [self updateExchangeRate];
    
    [self calculate];
    [self performSelectorOnMainThread:@selector(calculate) withObject:nil waitUntilDone:YES];
    [self updateLabel];
    [self performSelectorOnMainThread:@selector(updateLabel) withObject:nil waitUntilDone:YES];
    
    [self.navigationController popViewControllerAnimated:YES];
    
    
}

-(void)baseCurrencyPicker:(BaseCurrencyTableViewController *)controller didPickBaseCurrency:(BaseCurrency *)baseCurrency{
    
    // set selected code passed from picker to code object
    //self.code = currencyCode;
    // set field names for 'from currency'
    //self.fromCurrencyCodeField.text = self.code.fromCodeName;
    //self.fromCurrencyCodeFieldTwo.text = self.code.fromCodeName;
    //self.fromCurrencyFullNameField.text = self.code.fromFullName;
    
    self.baseCode = baseCurrency;
    
  
        //self.baseCode.toCodeName = @"USD";
    
        self.toCurrencyCodeField.text = self.baseCode.toCodeName;
        //self.baseCode.toCodeName = self.code.toCodeName;
        //[self.toCurrencyImageButton setImage:[UIImage imageNamed:@"USD"] forState:UIControlStateNormal];
    
    
    //NSLog(@"**currencyCode.codeName: %@",currencyCode.fromCodeName);
    //NSLog(@"***code.fullName %@", self.code.fromFullName);
    //NSLog(@"****item.name: %@", self.item.name);
    //NSLog(@"----to Code: %@----", self.code.toCodeName);
    
    [self updateExchangeRate];
    
    [self calculate];
    [self performSelectorOnMainThread:@selector(calculate) withObject:nil waitUntilDone:YES];
    [self updateLabel];
    [self performSelectorOnMainThread:@selector(updateLabel) withObject:nil waitUntilDone:YES];
    
    [self.navigationController popViewControllerAnimated:YES];
    
    
}

-(void)hideKeyboard {
    [self resignFirstResponder];
    
}


-(void)calculate
{
    
    NSLog(@"Calculated price float value %f", self.priceFloat);
    float result;
    NSLog(@"%@", self.fromUnitField.text);
    
   
    
    if ([self.item.fromUnit isEqual:@"kg"]){
        result =  (self.priceFloat * self.code.rate) / 2.20462;
        NSLog(@"Result: %.2f", result);
        self.resultTextField.text = [NSString stringWithFormat:@"%.2f", result];
        
        if ([self.item.toUnit isEqual:@"lb"] && [self.baseCode.toCodeName isEqual:@"USD"])
        {
            self.resultTextFieldCompare.text = [NSString stringWithFormat:@"$%.2f", result];
            self.resultCompareUnit.text = [NSString stringWithFormat:@"per %@", self.item.toUnit];
            self.avgPriceUnit.text = [NSString stringWithFormat:@"per %@", self.item.toUnit];
            
            if (result < [self.item.price floatValue]) {
                self.resultTextFieldCompare.textColor = [UIColor colorWithRed:0.31 green:0.53 blue:0.21 alpha:1.0];
                self.resultTextFieldCompare.font = [UIFont boldSystemFontOfSize:20];
                self.yourPriceLabel.textColor = [UIColor colorWithRed:0.31 green:0.53 blue:0.21 alpha:1.0];
                self.yourPriceLabel.font = [UIFont boldSystemFontOfSize:20];
                
            } else if (result > [self.item.price floatValue]) {
                self.resultTextFieldCompare.textColor = [UIColor redColor];
                self.yourPriceLabel.textColor = [UIColor redColor];
            }
        } else {
            self.resultTextFieldCompare.textColor = [UIColor grayColor];
            self.yourPriceLabel.textColor = [UIColor grayColor];
        }
    }
    
    if ([self.item.fromUnit isEqual:@"ℓ"]){
        result =  (self.priceFloat * self.code.rate) / 0.264172052;
        NSLog(@"Result: %.2f", result);
        self.resultTextField.text = [NSString stringWithFormat:@"%.2f", result];
        
        if ([self.item.toUnit isEqual:@"gal"] && [self.baseCode.toCodeName isEqual:@"USD"])
        {
            self.resultTextFieldCompare.text = [NSString stringWithFormat:@"$%.2f", result];
           self.resultCompareUnit.text = [NSString stringWithFormat:@"per %@", self.item.toUnit];
            self.avgPriceUnit.text = [NSString stringWithFormat:@"per %@", self.item.toUnit];
            
            if (result < [self.item.price floatValue]) {
                self.resultTextFieldCompare.textColor = [UIColor colorWithRed:0.31 green:0.53 blue:0.21 alpha:1.0];
                self.resultTextFieldCompare.font = [UIFont boldSystemFontOfSize:20];
                self.yourPriceLabel.textColor = [UIColor colorWithRed:0.31 green:0.53 blue:0.21 alpha:1.0];
                self.yourPriceLabel.font = [UIFont boldSystemFontOfSize:20];
                
            } else if (result > [self.item.price floatValue]) {
                self.resultTextFieldCompare.textColor = [UIColor redColor];
                self.yourPriceLabel.textColor = [UIColor redColor];
            }
        } else {
            self.resultTextFieldCompare.textColor = [UIColor grayColor];
            self.yourPriceLabel.textColor = [UIColor grayColor];
        }
        
        
    
        
    }
    
    if ([self.fromUnitField.text isEqual:@""]){
        result =  (self.priceFloat * self.code.rate);
        NSLog(@"Result: %.2f", result);
        self.resultTextField.text = [NSString stringWithFormat:@"%.2f", result];
    }
    

    [self performSelectorOnMainThread:@selector(self) withObject:nil waitUntilDone:YES];
    
}


-(BOOL)textField:(UITextField *)theTextField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    NSString *newText = [theTextField.text stringByReplacingCharactersInRange:range withString:string];
    if ([newText length] > 0) {
        self.priceTextField.textColor = [UIColor redColor];
        self.priceText = newText;
        NSLog(@"Typed text = %@", self.priceText);
        self.priceFloat = [self.priceText floatValue];
        NSLog(@"price float value %.2f", self.priceFloat);
        
        
        [self calculate];
        
    // set result to zero if there is no value in priceTextField
    }
    
    if ([newText length] == 0) {
        //self.priceTextField.textColor = [UIColor redColor];
        self.priceText = 0;
        NSLog(@"Typed text = %@", self.priceText);
        self.priceFloat = [self.priceText floatValue];
        NSLog(@"price float value %.2f", self.priceFloat);
    }
    
    [self calculate];

    return YES;
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}


- (IBAction)switchCurrency:(id)sender {
    [self.code toggleCurrency];
    [self updateLabel];
    
    //[self performSelectorOnMainThread:@selector(switchCurrency:) withObject:nil waitUntilDone:YES];
    
}


@end
