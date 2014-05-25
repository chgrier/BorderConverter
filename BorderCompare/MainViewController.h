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

@interface MainViewController : UIViewController <CurrencyPickerViewControllerDelegate, UIPickerViewDelegate, UIPickerViewDataSource>



//@property (strong, nonatomic) IBOutlet UIPickerView *itemPicker;

@property (strong, nonatomic) Currency *code;
@property (strong, nonatomic) Currency *fullName;

@property (strong, nonatomic) Item *item;

@property (strong, nonatomic) NSArray *itemNames;
@property (strong, nonatomic) NSArray *itemMetricUnits;
@property (strong, nonatomic) NSArray *itemImperialUnits;
@property (strong, nonatomic) NSArray *itemAvgPrice;
@property (strong, nonatomic) NSArray *itemCategory;

@property (strong, nonatomic) NSDictionary *itemList;
@property (strong, nonatomic) NSArray *category;
@property (strong, nonatomic) NSArray *items;



@property (weak, nonatomic) IBOutlet UITextField *currencyCodeLabel;
@property (weak, nonatomic) IBOutlet UITextField *currencyCodeLabelTwo;
@property (weak, nonatomic) IBOutlet UITextField *baseCurrencyCodeLabel;
@property (weak, nonatomic) IBOutlet UITextField *fromUnitField;
@property (weak, nonatomic) IBOutlet UITextField *toUnitField;



@property (weak, nonatomic) IBOutlet UITextField *fxRate;
@property (weak, nonatomic) IBOutlet UILabel *fxRateTime;
@property (nonatomic, weak) IBOutlet UISlider *slider;

@property (nonatomic, strong) NSString *currencyType;

- (IBAction)sliderMoved:(UISlider *)slider;
- (IBAction)updateRate;
- (IBAction)selectItem:(id)sender;

@property (weak, nonatomic) IBOutlet UIView *pickerViewHolder;

-(void)saveUserData;

@property (weak, nonatomic) IBOutlet UIPickerView *itemPicker;
@property (weak, nonatomic) IBOutlet UITextField *avgPriceLabel;
@property (weak, nonatomic) IBOutlet UITextField *itemName;



@end
