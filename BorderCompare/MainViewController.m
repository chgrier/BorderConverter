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
    NSString * _sliderHolder;
    
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

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.yourPriceLabel.textColor = [UIColor lightGrayColor];
    self.avgPriceUSA.textColor = [UIColor lightGrayColor];
    
    
    if ([UIScreen mainScreen].bounds.size.height<568)
    {
        NSLog(@"3.5 inch screen");
            }
    else
    {
        NSLog(@"4.0 inch screen");
    }
    

        CGRect frame = CGRectMake(0.0, 0.0, 200.0, 10.0);
        UISlider *sliderSmall = [[UISlider alloc] initWithFrame:frame];
                [sliderSmall setBackgroundColor:[UIColor clearColor]];
                [self.view addSubview:sliderSmall];
        

    NSString *myListPath = [[NSBundle mainBundle] pathForResource:@"ItemDict" ofType:@"plist"];
    _items = [[NSMutableArray alloc]initWithContentsOfFile:myListPath];
    
    
    // close picker if user taps anywhere on screen (excluding buttons)
    UITapGestureRecognizer *gestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(closePicker)];
    
    [self.view addGestureRecognizer:gestureRecognizer];
    
}

#pragma mark - Reachability 

// get network status messages
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
           NSLog(@"****NOT REACHABLE");
        }}
}

// button to update rates
- (IBAction)updateExchangeRateButton:(id)sender {
    [self updateExchangeRate];
    [self updateLabel];
}

-(void)updateExchangeRate{
    
    Reachability *reach = [Reachability reachabilityForInternetConnection];
    NetworkStatus status = [reach currentReachabilityStatus];
    
    if (self.code.fromCodeName != nil && self.baseCode.toCodeName != nil && status != NotReachable) {
        
    NSLog(@"Update Exchange Rate: FROM CODE: %@", self.code.fromCodeName);
    NSLog(@"Update Exchange Rate: BASE CODE: %@", self.baseCode.toCodeName);

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
             
             NSLog(@"VALUE of downloaded exchange rate data %@", value);
            
             // create string to hold value of exchange rate
             _holder = [NSString stringWithFormat:@"%@",value];
             
             float inverse = 1 / [_holder floatValue];
             NSLog(@"INVERSE of downloaded exchange rate data: %.2f", inverse);
             
             // set self.code.rate to downloaded rate
             self.code.rate = [_holder floatValue];
             NSLog(@"FLOAT VALUE of exchange rate %f", self.code.rate);
             
             // set slider value
             float minimumValue = self.code.rate * .9;  // slider min value to 20% less than initial exchange rate
             float maximumValue = self.code.rate * 1.1;  // slider max value to 20% greater than initial exchange rate
             float initialValue = maximumValue - minimumValue;
             _sliderBar.minimumValue = minimumValue;   // sets min value
             _sliderBar.maximumValue = maximumValue;    // sets max value
             _sliderBar.value = initialValue;
             
             // set exchange rate field to downloaded value
             self.exchangeRateField.text = [NSString stringWithFormat:@"%.2f",self.code.rate];
             
             // set inverse exchange rate field to inverse of downloaded value
             self.exchangeRateFieldInverse.text = [NSString stringWithFormat:@"%.2f", inverse];
             
             _sliderHolder = @"1";
         }
                             
         else if ([data length] == 0 &&
                  error == nil){
             
             NSLog(@"Nothing was downloaded.");
             
             if ([self.baseCode.toCodeName  isEqual: @"USD"]){
        
             _sliderHolder = @"1";
             _holder = [NSString stringWithFormat:@"%@",self.code.oldRateToUSD];
             self.code.rate = [_holder floatValue];

             float minimumValue = self.code.rate * .9;  // slider min value to 20% less than initial exchange rate
             float maximumValue = self.code.rate * 1.1;  // slider max value to 20% greater than initial exchange rate
             float initialValue = maximumValue - minimumValue;
             _sliderBar.minimumValue = minimumValue;   // sets min value
             _sliderBar.maximumValue = maximumValue;    // sets max value
             _sliderBar.value = initialValue;
                 
            // check network status using Apple Reachability classes
                 Reachability *reach = [Reachability reachabilityForInternetConnection];
                 NetworkStatus status = [reach currentReachabilityStatus];
                 
                 // alert user of exchange rates if not reachable when starting
                 if (status == NotReachable) {
                     
                     UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"No Internet Connection"
                                                                     message:[self stringFromStatus:status] delegate:nil
                                                           cancelButtonTitle:@"OK" otherButtonTitles:nil];
                     [alert show];
                 }

             }
             
         } else if (error != nil){
             if ([self.baseCode.toCodeName  isEqual: @"USD"]){
             NSLog(@"Error happened = %@", error);
             
            _sliderHolder = @"1";
             _holder = [NSString stringWithFormat:@"%@",self.code.oldRateToUSD];
             self.code.rate = [_holder floatValue];
             
             float minimumValue = self.code.rate * .9;  // slider min value to 20% less than initial exchange rate
             float maximumValue = self.code.rate * 1.1;  // slider max value to 20% greater than initial exchange rate
             float initialValue = maximumValue - minimumValue;
             _sliderBar.minimumValue = minimumValue;   // sets min value
             _sliderBar.maximumValue = maximumValue;    // sets max value
             _sliderBar.value = initialValue;
                 
                 
                 Reachability *reach = [Reachability reachabilityForInternetConnection];
                 NetworkStatus status = [reach currentReachabilityStatus];
            if (status == NotReachable){
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"No Internet Connection"
                                                                     message:[self stringFromStatus:status] delegate:nil
                                                           cancelButtonTitle:@"OK" otherButtonTitles:nil];
                     [alert show];
                 }
             
             NSLog(@"Old Code is equal to : %@", self.code.oldRateToUSD);
             } else {
                 
                 _sliderHolder = @"0";
                 _holder = @"1";
                 self.code.rate = 0;
                 self.code.inverseRate = 0;
                 _sliderBar.minimumValue = 0;
                 _sliderBar.maximumValue = 100;
                 _sliderBar.value = 0;
                 
                 self.exchangeRateInverseField.text =@"";
             }
         } else {
              _fromCurrencyCodeField.text = @"select";
             
         }
                            
    [self updateLabel];
    [self calculate];
    [self updateExchangeTime];
    [self performSelectorOnMainThread:@selector(updateLabel) withObject:nil waitUntilDone:YES];
    [self performSelectorOnMainThread:@selector(calculate) withObject:nil waitUntilDone:YES];
    [self performSelectorOnMainThread:@selector(self) withObject:nil waitUntilDone:YES];
    [self performSelectorOnMainThread:@selector(updateExchangeTime) withObject:nil waitUntilDone:YES];
    }];
        
    } else if (status == NotReachable) {

        if ([self.baseCode.toCodeName  isEqual: @"USD"]){
           
            _sliderHolder = @"1";
            _holder = [NSString stringWithFormat:@"%@",self.code.oldRateToUSD];
            self.code.rate = [_holder floatValue];
            
            float minimumValue = self.code.rate * .9;  // slider min value to 20% less than initial exchange rate
            float maximumValue = self.code.rate * 1.1;  // slider max value to 20% greater than initial exchange rate
            float initialValue = maximumValue - minimumValue;
            _sliderBar.minimumValue = minimumValue;   // sets min value
            _sliderBar.maximumValue = maximumValue;    // sets max value
            _sliderBar.value = initialValue;

            
        } else {
            
            Reachability *reach = [Reachability reachabilityForInternetConnection];
            NetworkStatus status = [reach currentReachabilityStatus];
            
            if (status == NotReachable){
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"No Internet Connection"
                                                            message:@"Historical exchange rates are provided when the 'to' currency is set to USD. Please connect to the internet to access current rates. "delegate:nil
                                                  cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alert show];
                
            }
            
            _sliderHolder = @"0";
            _holder = @"1";
            self.code.rate = 1;
            self.code.inverseRate = 1;
            _sliderBar.minimumValue = 0;   // sets min value
            _sliderBar.maximumValue = 100;    // sets max value
            _sliderBar.value = 0;
            
            self.exchangeRateInverseField.text =@"";
        }
    }
}


-(void)updateExchangeTime{
    
    Reachability *reach = [Reachability reachabilityForInternetConnection];
    NetworkStatus status = [reach currentReachabilityStatus];
    
    if (status == NotReachable) {
        
        self.exchangeRateTimeLabel.text = (@"Last updated: June 11, 2014");
        
    } else {

    NSDate *today = [NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterLongStyle];
    [formatter setTimeStyle:NSDateFormatterMediumStyle];
    [formatter setTimeZone:[NSTimeZone defaultTimeZone]];
    NSLog(@"Formatted date: %@ in time zone %@", [formatter stringFromDate:today], [formatter timeZone]);
    
    self.exchangeRateTimeLabel.text = [NSString stringWithFormat:@"Last updated: %@", [formatter stringFromDate:today]];
    }
}

// saving user data methods
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

    
    //number of items in list;
    if ([self.baseCode.toCodeName isEqual:@"USD"] || self.baseCode.toCodeName == nil){
        return self.items.count;
    } else {
        return 4;
    }
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
    
    
    // get item names for pickerView
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


#pragma mark PickerView Delegate
-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row
      inComponent:(NSInteger)component
{

    // set items from plist to item object
    self.item = [[Item alloc]init];
        
    self.item.name = [[self.items objectAtIndex:row]objectForKey:@"itemName"];
    self.item.price = [[self.items objectAtIndex:row]objectForKey:@"itemPrice"];
    self.item.fromUnit = [[self.items objectAtIndex:row]objectForKey:@"itemFromUnit"];
    self.item.toUnit = [[self.items objectAtIndex:row]objectForKey:@"itemToUnit"];
    
    // set average price label as a float for calculations
    float avgPrice = [self.item.price floatValue];
    NSString *avgPriceString = [[NSString alloc] initWithFormat:
                                @"$%.2f", avgPrice];
    
    self.avgPriceLabel.text = avgPriceString;
    if (self.baseCode.toCodeName  == nil) {
        self.avgPriceLabel.textColor = [UIColor lightGrayColor];
    }
    if (![self.baseCode.toCodeName isEqual:@"USD"]){
        self.avgPriceLabel.text = @"";
    }
    
    // set itemName field for the selected item
    self.itemName.text = self.item.name;
    
   
    // set unit fields based on selected item
    self.fromUnitField.text = [NSString stringWithFormat:@"per %@", self.item.fromUnit];
    self.toUnitField.text = [NSString stringWithFormat:@"per %@", self.item.toUnit];
    
    // if base currency is USD, then populate the average price field
    if ([self.toCurrencyCodeField isEqual:@"USD"])
    {
        self.avgPriceUnit.text = [NSString stringWithFormat:@"per %@", self.item.toUnit];
    } else {
        self.resultCompareUnit.text = @"";
        self.resultTextFieldCompare.text = @"";
    }
    
    NSLog(@"FROM UNIT: %@; TO UNIT: %@", self.item.fromUnit, self.item.toUnit);
    
    // recalculate prices based on new units
    [self calculate];
    
}

-(IBAction)dismissUIPickerView:(id)sender{
    
    [self closePicker];
    
}

-(IBAction)selectItem:(id)sender{
    
    //open picker view and resign keyboard if open
    [self.priceTextField resignFirstResponder];
    
    // adjust position of picker if on a 3.5 inch iPhone
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
    
        // position for 4 inch iPhone
        [UIView animateWithDuration:0.3 animations:^{
        _pickerViewHolder.frame = CGRectMake(10, 350,
                                       _pickerViewHolder.frame.size.width,
                                       _pickerViewHolder.frame.size.height);
    }];
    }
}


-(void)closePicker
{
    //Displays the picker view off the screen
    [UIView animateWithDuration:0.2 animations:^{
        _pickerViewHolder.frame = CGRectMake(-300,
                                       150,
                                       _pickerViewHolder.frame.size.width,
                                       _pickerViewHolder.frame.size.height);
    
    }];
    
}

    // Displays the picker view off the screen and clears the units and item from text fields and from objects
- (IBAction)cancel:(id)sender {
    [UIView animateWithDuration:0.2 animations:^{
        _pickerViewHolder.frame = CGRectMake(-300,
                                             150,
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
        
        // recalculate without unit conversion
        [self calculate];
        
    }];
    
    
}

-(void)updateLabel{
    
    [self updateExchangeTime];
    
    if (self.code.imageName == nil){
        [self.fromCurrencyImageButton setImage:[UIImage imageNamed:@"MXN.png"]
                                      forState:UIControlStateNormal];
    } else {
    self.fromCurrencyCodeField.text = self.code.fromCodeName;
    [self.fromCurrencyImageButton setImage:[UIImage imageNamed:self.code.imageName]
                                  forState:UIControlStateNormal];
    self.fromCurrencyFullNameField.text = self.code.fromFullName;
    
    
    // to or base currency field and image
    self.toCurrencyCodeField.text = self.baseCode.toCodeName;
    [self.toCurrencyImageButton setImage:[UIImage imageNamed:self.baseCode.imageName]
                                  forState:UIControlStateNormal];
    self.toCurrencyFullNameField.text = self.baseCode.toFullName;
    
    // updated currency codes
    [self.fromCurrencyCodeFieldTwo setText:[self.code fromCodeName]];
    [self.toCurrencyCodeFieldTwo setText:[self.baseCode toCodeName]];

    // update unit
    
        if (self.item.fromUnit != nil){
            self.fromUnitField.text = [NSString stringWithFormat:@"per %@", self.item.fromUnit];
            self.toUnitField.text = [NSString stringWithFormat:@"per %@", self.item.toUnit];
        }
    
    // update exchange rate fields
    self.code.inverseRate = 1 / self.code.rate;
    float inverseRate = self.code.inverseRate;
    
    self.exchangeRateInverseField.text = [NSString stringWithFormat:@"1 %@ = %.2f %@", [self.baseCode toCodeName], inverseRate, [self.code fromCodeName]];
    
    if (self.code.rate < .10) {
        self.exchangeRateField.text = [NSString stringWithFormat:@"1 %@ = %.4f %@", [self.code fromCodeName], self.code.rate, [self.baseCode toCodeName]];
    } else {
        self.exchangeRateField.text = [NSString stringWithFormat:@"1 %@ = %.2f %@", [self.code fromCodeName], self.code.rate, [self.baseCode toCodeName]];
    }

    // set slider value in middle after new exchange rate

        
        NSString *textValue =  [NSString stringWithFormat:@"%@",_holder];
        float value = [textValue floatValue];
        
        if (value > 0) {
            
            self.sliderBar.value = value;
        
        }
    }
    
}

#pragma mark Slider
// sliderMoved method called when user moves the slider
-(IBAction)sliderMoved:(UISlider *)slider{
    
   
    
    if ([_sliderHolder isEqual:@"0"]){
        
        
        float minimumValue = 0;  // slider min value to 20% less than initial exchange rate
        float maximumValue = 100;  // slider max value to 20% greater than initial exchange rate
        
        float val = slider.value;
        self.code.rate = val;
        
        float adjustedRate = val;
        self.code.rate = adjustedRate;
        self.code.inverseRate = 1 / adjustedRate;
        float inverseRate = self.code.inverseRate;
        
        self.exchangeRateFieldInverse.text = @"";
        
        // exchange rate field
        if (self.code.rate < .02) {
             self.exchangeRateField.text = [NSString stringWithFormat:@"1 %@ = %.2f %@", [self.code fromCodeName], self.code.rate, [self.baseCode toCodeName]];
        } else {
             self.exchangeRateField.text = [NSString stringWithFormat:@"1 %@ = %.2f %@", [self.code fromCodeName], self.code.rate, [self.baseCode toCodeName]];
        }

        // inverse rate field
        
        self.exchangeRateInverseField.text = [NSString stringWithFormat:@"1 %@ = %.2f %@", [self.baseCode toCodeName], inverseRate, [self.code fromCodeName]];
        
        slider.minimumValue = minimumValue;   // sets min value
        slider.maximumValue = maximumValue;    // sets max value
        
        NSLog(@"min is %f and max is %f",minimumValue,maximumValue);
        
        NSLog(@"NEW rate is: %.2f", self.code.rate);
    
    } else {
        NSString *textValue =  [NSString stringWithFormat:@"%@",_holder];
        float value = [textValue floatValue];
        
        if (value > 0) {
            float minimumValue = value * .9;  // slider min value to 20% less than initial exchange rate
            float maximumValue = value * 1.1;  // slider max value to 20% greater than initial exchange rate
 
            float val = slider.value;
            self.code.rate = val;
            
            float adjustedRate = val;
            self.code.rate = adjustedRate;
            self.code.inverseRate = 1 / adjustedRate;
            float inverseRate = self.code.inverseRate;
            
            // exchange rate field
            if (self.code.rate < .02) {
                self.exchangeRateField.text = [NSString stringWithFormat:@"1 %@ = %.2f %@", [self.code fromCodeName], self.code.rate, [self.baseCode toCodeName]];
            } else {
                self.exchangeRateField.text = [NSString stringWithFormat:@"1 %@ = %.2f %@", [self.code fromCodeName], self.code.rate, [self.baseCode toCodeName]];
            }
            
            self.exchangeRateInverseField.text = [NSString stringWithFormat:@"1 %@ = %.2f %@", [self.baseCode toCodeName], inverseRate, [self.code fromCodeName]];
            
            
            slider.minimumValue = minimumValue;   // sets min value
            slider.maximumValue = maximumValue;    // sets max value
            
            NSLog(@"min is %f and max is %f",minimumValue,maximumValue);
            
            NSLog(@"NEW rate is: %.2f", self.code.rate);
        }
    }
    
    [self updateRate];
    [self calculate];
    
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
    
    [self updateExchangeRate];
    
    [self calculate];
    [self performSelectorOnMainThread:@selector(calculate) withObject:nil waitUntilDone:YES];
    [self updateLabel];
    [self performSelectorOnMainThread:@selector(updateLabel) withObject:nil waitUntilDone:YES];
    [self.navigationController popViewControllerAnimated:YES];
    
    
    // ***if base currency has not yet been set, set it to USD**
    if (self.baseCode.toCodeName == nil)
    {
        self.baseCode = [[BaseCurrency alloc]init];
        [self.baseCode setToCodeName:@"USD"];
        [self.baseCode setImageName:@"USD"];
        [self.baseCode setToFullName:@"United States Dollar"];
        self.avgPriceUSA.textColor = [UIColor blackColor];
        self.yourPriceLabel.textColor = [UIColor blackColor];
        
        NSLog(@"BASE CODE: %@", self.baseCode.toCodeName);
        NSLog(@"FULL NAME BASE CODE: %@", self.baseCode.toFullName);
        NSLog(@"FROM CODE: %@",currencyCode.fromCodeName);
        NSLog(@"FULL NAME FROM CODE %@", self.code.fromFullName);
    
    
        [self updateExchangeRate];
    
        [self calculate];
        [self performSelectorOnMainThread:@selector(calculate) withObject:nil waitUntilDone:YES];
        [self updateLabel];
        [self performSelectorOnMainThread:@selector(updateLabel) withObject:nil waitUntilDone:YES];
    
        [self.navigationController popViewControllerAnimated:YES];
    }
    
    }

-(void)baseCurrencyPicker:(BaseCurrencyTableViewController *)controller didPickBaseCurrency:(BaseCurrency *)baseCurrency{
    
    // set selected baseCode passed from picker to code object
    self.baseCode = baseCurrency;
    
    // set field names and image for 'to currency / base currency
    self.toCurrencyCodeField.text = self.baseCode.toCodeName;
    self.toCurrencyCodeFieldTwo.text = self.baseCode.toCodeName;
    self.toCurrencyFullNameField.text = self.baseCode.toFullName;
    [self.toCurrencyImageButton setImage:[UIImage imageNamed:self.baseCode.imageName]
                                forState:UIControlStateNormal];
  
    if ([self.baseCode.toCodeName  isEqual: @"USD"] || [self.toCurrencyCodeField.text isEqual: @"USD"]) {
        self.avgPriceUSA.textColor = [UIColor blackColor];
        self.avgPriceUSA.text = @"Avg. Price in USA:";
        self.avgPriceLabel.text = [NSString stringWithFormat:@"$%.2f", [self.item.price floatValue]];
        self.avgPriceLabel.textColor = [UIColor blackColor];
        self.yourPriceLabel.textColor = [UIColor blackColor];
        self.yourPriceLabel.text = @"Your price:";
        self.resultTextFieldCompare.placeholder = @"$0.00";
        self.resultCompareUnit.placeholder = @"per unit";
        self.itemName.text = @"Select item to compare or units";
        
    } else {
        self.avgPriceUSA.textColor = [UIColor lightGrayColor];
        self.avgPriceLabel.textColor = [UIColor lightGrayColor];
        self.yourPriceLabel.textColor = [UIColor lightGrayColor];
        self.yourPriceLabel.font = [UIFont systemFontOfSize:20];
        self.yourPriceLabel.text = @"Set 'to' currency to USD ";
        self.avgPriceUSA.text = @"to see price comparisons";
        
        self.avgPriceLabel.placeholder = @"";
        self.avgPriceLabel.text = @"";
        self.avgPriceUnit.placeholder = @"";
        self.avgPriceUnit.text = @"";
        self.resultCompareUnit.placeholder = @"";
        self.resultTextFieldCompare.placeholder = @"";
        self.resultCompareUnit.text = @"";
        self.resultTextFieldCompare.text = @"";
        self.itemName.text = @"Select units";

    }
    
    [self updateExchangeRate];
    
    [self calculate];
    [self performSelectorOnMainThread:@selector(calculate) withObject:nil waitUntilDone:YES];
    [self updateLabel];
    [self performSelectorOnMainThread:@selector(updateLabel) withObject:nil waitUntilDone:YES];
    
    [self.navigationController popViewControllerAnimated:YES];
    
    [self.itemPicker reloadAllComponents];
    
    
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
            self.avgPriceUSA.textColor = [UIColor blackColor];
            
            self.avgPriceUnit.textColor = [UIColor blackColor];
            self.avgPriceLabel.textColor = [UIColor blackColor];
            
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
            self.resultTextFieldCompare.textColor = [UIColor lightGrayColor];
            self.yourPriceLabel.textColor = [UIColor lightGrayColor];
            self.avgPriceUSA.textColor = [UIColor lightGrayColor];
        }
    }
    
    
    if ([self.item.fromUnit isEqual:@"lb"]){
        result =  (self.priceFloat * self.code.rate) / 0.45359237;
        NSLog(@"Result: %.2f", result);
        self.resultTextField.text = [NSString stringWithFormat:@"%.2f", result];
        
        self.resultTextFieldCompare.textColor = [UIColor lightGrayColor];
        self.yourPriceLabel.textColor = [UIColor lightGrayColor];
        self.avgPriceUSA.textColor = [UIColor lightGrayColor];
        self.avgPriceUnit.textColor = [UIColor lightGrayColor];
        self.avgPriceLabel.textColor = [UIColor lightGrayColor];
        
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
            self.avgPriceUnit.textColor = [UIColor blackColor];
            self.avgPriceLabel.textColor = [UIColor blackColor];
            self.avgPriceUSA.textColor = [UIColor blackColor];
            
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
            self.resultTextFieldCompare.textColor = [UIColor lightGrayColor];
            self.yourPriceLabel.textColor = [UIColor lightGrayColor];
            //self.avgPriceUSA.textColor = [UIColor lightGrayColor];
        }
        
    }
    
    if ([self.item.fromUnit isEqual:@"gal"]){
        result =  (self.priceFloat * self.code.rate) / 3.78541178;
        NSLog(@"Result: %.2f", result);
        self.resultTextField.text = [NSString stringWithFormat:@"%.2f", result];
        

            self.resultTextFieldCompare.textColor = [UIColor lightGrayColor];
            self.yourPriceLabel.textColor = [UIColor lightGrayColor];
            self.avgPriceUSA.textColor = [UIColor lightGrayColor];
            self.avgPriceUnit.textColor = [UIColor lightGrayColor];
            self.avgPriceLabel.textColor = [UIColor lightGrayColor];
        

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
        self.priceTextField.textColor = [UIColor blackColor];
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
    
}


@end
