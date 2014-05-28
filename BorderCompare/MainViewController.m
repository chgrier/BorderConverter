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
   
    
    NSMutableArray *_userData;
    
    NSString * _holder;
    
    BOOL _pickerVisible;
    
    NSMutableArray *_items;
    
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
    
    
    
     _fxValue = _code.rate;
     ;
     _fxUpdatedRate = .4;
     self.slider.value = _fxValue;
     
    
    
    
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
    
    _items = [[NSMutableArray alloc]initWithCapacity:20];
    Item *item;
    
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
     
     //self.items = @[produceArray, meatArray];
     //NSLog(@"all items: %@", self.items);
     
     //NSString *selectedCategory = self.category[0];
     //self.items = self.itemList[selectedCategory];
     //NSLog(@"Items: %@", self.items);
     
     */
    
    UITapGestureRecognizer *gestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(closePicker)];
    //gestureRecognizer.cancelsTouchesInView = NO;
    [self.view addGestureRecognizer:gestureRecognizer];
    
    
}





-(void)updateExchangeRate{
    
    
    if (self.code.fromCodeName != nil) {
        
    NSString *fromCurr = self.code.fromCodeName;
    NSString *toCurr = @"USD";
        
        
    // URL request get exchange rate for currencies
    NSString *urlAsString = @"http://finance.yahoo.com/d/quotes.csv?s=";
    
    urlAsString = [urlAsString stringByAppendingString:fromCurr];
    urlAsString = [urlAsString stringByAppendingString:toCurr];
    
    urlAsString = [urlAsString stringByAppendingString:@"=X&f=sl1d1t1c1ohgv&e=.csv"];
    
    NSURL *url = [NSURL URLWithString:urlAsString];
    
    NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:url];
    //[urlRequest setTimeoutInterval:30.0f];
    [urlRequest setHTTPMethod:@"GET"];
    
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    
    [NSURLConnection
     sendAsynchronousRequest:urlRequest
     queue:queue
     completionHandler:^(NSURLResponse *response,
                         NSData *data,
                         NSError *error) {
         
         if ([data length] >0  &&
             error == nil){
             NSString *html = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
             NSArray *substrings = [html componentsSeparatedByString:@","];
             NSString *value = substrings[1];
             
            
             // create string to hold value of exchange rate
             //NSString *holder = [NSString stringWithFormat:@"%@",value];
             
             _holder = [NSString stringWithFormat:@"%@",value];
             
             NSLog(@"****value %@", _holder);
         
             self.code.rate = [_holder floatValue];
             NSLog(@"*****Float value of exchange rate %f", self.code.rate);
             
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
         }
         else if (error != nil){
             NSLog(@"Error happened = %@", error);
         }
         else {
              _fromCurrencyCodeField.text = @"select";
         }
         
     
    
    
    [self updateLabel];
    [self calculate];
    [self performSelectorOnMainThread:@selector(updateLabel) withObject:nil waitUntilDone:YES];
    [self performSelectorOnMainThread:@selector(calculate) withObject:nil waitUntilDone:YES];
    [self performSelectorOnMainThread:@selector(self) withObject:nil waitUntilDone:YES];
    
     }];
}
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
    return _items.count;
    
    /*
    if (component == kCategoryComponent) {
        return [self.category count];
    } else {
        return [self.items count];
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
    item = [_items objectAtIndex:row];
    
    return item.name;
    
   /* if(component == kCategoryComponent) {
        return self.category[row];
    } else {
        return self.items[row];
    }
*/
}



#pragma mark PickerView Delegate
-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row
      inComponent:(NSInteger)component
{
    
    //Item *selectedItem = [[Item alloc]init];
    //selectedItem = [_items objectAtIndex:row];
    self.item = [_items objectAtIndex:row];
    
    float rate = [self.item.price floatValue];
    NSString *avgPriceString = [[NSString alloc] initWithFormat:
                                @"$%.2f", rate];
    _avgPriceLabel.text = avgPriceString;
    
    self.itemName.text = self.item.name;
    
    _fromUnitField.text = self.item.fromUnit;
    _toUnitField.text = self.item.toUnit;
    
    [self calculate];
    
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
    
    [UIView animateWithDuration:0.3 animations:^{
        _pickerViewHolder.frame = CGRectMake(65, 112,
                                       _pickerViewHolder.frame.size.width,
                                       _pickerViewHolder.frame.size.height);
    }];
    
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
    [UIView animateWithDuration:0.3 animations:^{
        _pickerViewHolder.frame = CGRectMake(_pickerViewHolder.frame.origin.x,
                                       800, //Displays the view off the screen
                                       _pickerViewHolder.frame.size.width,
                                       _pickerViewHolder.frame.size.height);
    }];
    
    
}


-(void)updateLabel
{
     _exchangeRateField.text =  [NSString stringWithFormat:@"%@",_holder];
    
    if (self.code.fromCodeName != nil){
        [self.fromCurrencyCodeField setText:[self.code fromCodeName]];
        [self.fromCurrencyCodeFieldTwo setText:[self.code fromCodeName]];
        [self.toCurrencyCodeField setText:[self.code toCodeName]];
        [self.toCurrencyCodeFieldTwo setText:[self.code toCodeName]];
        
       // self.fromCurrencyImageButton = [UIImage imageNamed:self.code.imageName];
        
        [self.fromCurrencyImageButton setImage:[UIImage imageNamed:self.code.imageName]
                          forState:UIControlStateNormal];
        
        
        //UIImage *button = UIButtonTypeCustom
        
        NSDate *today = [NSDate date];
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        //[formatter setDateFormat:@"hh:mm a"];
        //[formatter setDateFormat:@"MMM dd, YYYY"];
        [formatter setDateStyle:NSDateFormatterLongStyle];
        [formatter setTimeStyle:NSDateFormatterMediumStyle];
        [formatter setTimeZone:[NSTimeZone defaultTimeZone]];
        NSLog(@"Formatted date: %@ in time zone %@", [formatter stringFromDate:today], [formatter timeZone]);
        
        _exchangeRateTimeLabel.text = [NSString stringWithFormat:@"%@", [formatter stringFromDate:today]];
        
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
    
}




- (void)currencyPickerViewController:(CurrencyPickerViewController *)controller didSelectCurrency:(NSString *)currency{

    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}



#pragma mark Slider
// sliderMoved method called when user moves the slider
-(IBAction)sliderMoved:(UISlider *)slider{
   
    _fxValue = (slider.value);
    
    _code.rate = _fxUpdatedRate;
    _minValue = _fxUpdatedRate * .8;
    _maxValue = _fxUpdatedRate * 1.2;
    
    slider.minimumValue = _minValue;    // sets min value
    slider.maximumValue = _maxValue;    // sets max value
    
    NSLog(@"min is %f and max is %f",_minValue,_maxValue);
    NSLog(@"Slider value = %.2f", _fxValue);
    
    [self updateRate];
    
    
    
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
    transition.duration = .5;
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    
    [self updateFxLabel];
    [self.view.layer addAnimation:transition forKey:nil];
}





- (void) updateFxLabel{
    self.exchangeRateField.text = [NSString stringWithFormat:@"%.1f", _fxValue];
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
}

#pragma mark Delegate Callback Method

-(void)currencyPicker:(CurrencyPickerViewController *)controller didPickCurrency:(Currency *)currencyCode{
    
    // set selected code passed from picker to code object
    self.code = currencyCode;
    // set field names for 'from currency'
    self.fromCurrencyCodeField.text = self.code.fromCodeName;
    self.fromCurrencyCodeFieldTwo.text = self.code.fromCodeName;
    self.fromCurrencyFullNameField.text = self.code.fromFullName;
    
    if (![self.code.toCodeName isEqual:@"USD"])
    {
    self.code.toCodeName = @"USD";
    NSLog(@"----to Code: %@----", self.code.toCodeName);
    self.toCurrencyCodeField.text = self.code.toCodeName;
    [self.toCurrencyImageButton setImage:[UIImage imageNamed:@"USD"] forState:UIControlStateNormal];
    }
    
    NSLog(@"**currencyCode.codeName: %@",currencyCode.fromCodeName);
    NSLog(@"***code.fullName %@", self.code.fromFullName);
    NSLog(@"****item.name: %@", self.item.name);
    NSLog(@"----to Code: %@----", self.code.toCodeName);
    
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
    result =  (self.priceFloat * self.code.rate) / 2.2 ;
    NSLog(@"Rate: %.2f", self.code.rate);
    NSLog(@"Result: %.2f", result);
    self.resultTextField.text = [NSString stringWithFormat:@"%.2f", result];
    if ([self.item.toUnit isEqual:@"lb"] && [self.code.toCodeName isEqual:@"USD"])
    {
        self.resultTextFieldCompare.text = [NSString stringWithFormat:@"$%.2f", result];
        
        if (result < [self.item.price floatValue]) {
            self.resultTextFieldCompare.textColor = [UIColor greenColor];
            self.resultTextFieldCompare.font = [UIFont boldSystemFontOfSize:20];
        } else if (result > [self.item.price floatValue]) {
            self.resultTextFieldCompare.textColor = [UIColor redColor];
        }
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
        
        
    }
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
