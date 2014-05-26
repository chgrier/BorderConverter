//
//  ViewController.h
//  BorderCompare
//
//  Created by Charles Grier on 2/24/14.
//  Copyright (c) 2014 com.charlesgrier. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CurrencyPickerViewController.h"
#import "Currency.h"
#import "Item.h"

@interface MainViewController : UIViewController <CurrencyPickerViewControllerDelegate, UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate>



//@property (strong, nonatomic) IBOutlet UIPickerView *itemPicker;

@property (strong, nonatomic) Currency *code;

@property (strong, nonatomic) Item *item;

// selected item arrays and dictionary variables
@property (strong, nonatomic) NSArray *itemNames;
@property (strong, nonatomic) NSArray *itemMetricUnits;
@property (strong, nonatomic) NSArray *itemImperialUnits;
@property (strong, nonatomic) NSArray *itemAvgPrice;
@property (strong, nonatomic) NSArray *itemCategory;
@property (strong, nonatomic) NSDictionary *itemList;
@property (strong, nonatomic) NSArray *category;
@property (strong, nonatomic) NSArray *items;
- (IBAction)selectItem:(id)sender;

// currency code text fields
@property (weak, nonatomic) IBOutlet UITextField *fromCurrencyCodeField;
@property (weak, nonatomic) IBOutlet UITextField *fromCurrencyCodeFieldTwo;
@property (weak, nonatomic) IBOutlet UITextField *toCurrencyCodeField;
@property (weak, nonatomic) IBOutlet UITextField *toCurrencyCodeFieldTwo;
- (IBAction)switchCurrency:(id)sender;


// unit text fields
@property (weak, nonatomic) IBOutlet UITextField *fromUnitField;
@property (weak, nonatomic) IBOutlet UITextField *toUnitField;
- (IBAction)switchUnits:(id)sender;


// entered price text fields
@property (weak, nonatomic) IBOutlet UITextField *priceTextField;
@property (nonatomic, strong) NSString *priceText;
// entered price float variable
@property float priceFloat;


//result price field
@property (weak, nonatomic) IBOutlet UITextField *resultTextField;
@property (weak, nonatomic) IBOutlet UITextField *resultTextFieldCompare;

// exchange rate fields, labels and slider
@property (weak, nonatomic) IBOutlet UITextField *exchangeRateField;
@property (weak, nonatomic) IBOutlet UILabel *exchangeRateTimeLabel;
@property (nonatomic, weak) IBOutlet UISlider *slider;
- (IBAction)sliderMoved:(UISlider *)slider;
- (IBAction)updateRate;



@property (weak, nonatomic) IBOutlet UIView *pickerViewHolder;

-(void)saveUserData;

@property (weak, nonatomic) IBOutlet UIPickerView *itemPicker;
@property (weak, nonatomic) IBOutlet UITextField *avgPriceLabel;
@property (weak, nonatomic) IBOutlet UITextField *itemName;



@end
