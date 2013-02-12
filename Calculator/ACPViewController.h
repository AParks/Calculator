//
//  ACPViewController.h
//  Calculator
//
//  Created by Anna Parks on 2/2/13.
//  Copyright (c) 2013 Anna Parks. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ACPStack;

@interface ACPViewController : UIViewController <UITextFieldDelegate>
    @property (weak, nonatomic) IBOutlet UILabel *calculatorScreen;
    @property (weak, nonatomic) IBOutlet UIView *screenView;
    @property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *opButtons;

    @property (nonatomic) NSMutableString * currentNumber;
    @property (nonatomic) NSMutableArray * infix;
    @property (nonatomic) NSMutableArray * postfix;
    @property (nonatomic) ACPStack * stack;
    @property float result;

- (void) calculate;
- (IBAction) clear;
- (IBAction) buttonDigitPressed:(id)sender;
- (IBAction) buttonOperationPressed:(id)sender;



@end
