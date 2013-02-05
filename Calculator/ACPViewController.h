//
//  ACPViewController.h
//  Calculator
//
//  Created by Anna Parks on 2/2/13.
//  Copyright (c) 2013 Anna Parks. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ACPViewController : UIViewController{
    IBOutlet UILabel *calculatorScreen;
    float result;
    int currentOperation;
    float currentNumber;
}

- (IBAction) calculate;
- (IBAction) clear;
- (IBAction) buttonDigitPressed:(id)sender;
- (IBAction) buttonOperationPressed:(id)sender;



@end
