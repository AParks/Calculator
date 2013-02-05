//
//  ACPViewController.m
//  Calculator
//
//  Created by Anna Parks on 2/2/13.
//  Copyright (c) 2013 Anna Parks. All rights reserved.
//

#import "ACPViewController.h"

@interface ACPViewController ()

@end

@implementation ACPViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    UIImage *patternImage = [UIImage imageNamed:@"honey_im_subtle"];
    self.view.backgroundColor = [UIColor colorWithPatternImage:patternImage];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)calculate{
    calculatorScreen.text = @"";
}


- (IBAction)clear{
    currentNumber = 0;
    calculatorScreen.text = @"0";
}


-(IBAction)buttonDigitPressed:(id)sender{
    currentNumber = currentNumber*10 + (float)[sender tag];
    calculatorScreen.text = [NSString stringWithFormat:@"%2f", currentNumber];
}

-(IBAction)buttonOperationPressed:(id)sender{
    if(currentOperation == 0) result = currentNumber;
    
    else {
        switch (currentOperation) {
            case 1:
                result = result + currentNumber;
                break;
            case 2:
                result = result - currentNumber;
                break;
            case 3:
                result = result * currentNumber;
                break;
            case 4:
                result = result / currentNumber;
                break;
            case 5:
                currentNumber = 0 ;
                break;
        }
    }
    currentNumber = 0;
    calculatorScreen.text = [NSString stringWithFormat:@"%2f", result];
    if ([sender tag] == 0) result = 0;
    currentOperation =[sender tag];

}


@end
