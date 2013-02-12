//
//  ACPViewController.m
//  Calculator
//
//  Created by Anna Parks on 2/2/13.
//  Copyright (c) 2013 Anna Parks. All rights reserved.
//
#import <QuartzCore/QuartzCore.h>
#import "ACPViewController.h"
#import "ACPStack.h"



@interface ACPViewController ()

@property (nonatomic) BOOL equalsPreviouslyPressed;

@property (nonatomic) NSMutableString * currentNumber;
@property (nonatomic) NSMutableArray * infix;
@property (nonatomic) NSMutableArray * postfix;
@property (nonatomic) ACPStack * stack;
@property float result;

-(BOOL)higherPrecedence:(NSString *) stackOp :(NSString *) currentOp;
-(void )handleOperator:(NSString *) operator;
-(void)infixToPostFix;
-(void)calculate;
 

@end

@implementation ACPViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    UIImage *patternImage = [UIImage imageNamed:@"honey_im_subtle"];
    self.view.backgroundColor = [UIColor colorWithPatternImage:patternImage];
    self.stack = [[ACPStack alloc] init];
    self.infix = [[NSMutableArray alloc] init];
    self.postfix = [[NSMutableArray alloc] init];
    self.currentNumber = [[NSMutableString alloc] init];
    self.screenView.layer.cornerRadius = 8;
    
    for (UIButton *button in self.opButtons)
        [button setEnabled:NO];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)clear{
    [self.currentNumber setString:@""];
    self.result = 0;
    self.calculatorScreen.text = @"0";
    [self.infix removeAllObjects];
    [self.postfix removeAllObjects];
    [self.stack clear];
}

#pragma mark - calculator logic

// returns true if the stackOp has higher precedence than the current op
-(BOOL)higherPrecedence:(NSString *) stackOp :(NSString *) currentOp{
    
        if( [stackOp isEqualToString:@"^" ])
			if(![currentOp isEqualToString:@"^"])
				return true;
    
        if( [stackOp isEqualToString:@"/" ]|| [stackOp isEqualToString:@"*" ])
			if(![currentOp isEqualToString:@"^"])
				return true;
            
		if( [stackOp isEqualToString:@"+" ]|| [stackOp isEqualToString:@"-" ])
			if ([currentOp isEqualToString:@"-"] || [ currentOp isEqualToString:@"+"] ||
                [currentOp isEqualToString:@"("] ){
				return true;
			}
    return false;
}

-(void )handleOperator:(NSString *) operator {
    while (![self.stack isEmpty]) {
        id top = [self.stack peek];
        
        if ([self higherPrecedence:top :operator]) {
            [self.postfix addObject:top];
            [self.stack pop];
        } else
            break;
    }
    [self.stack push:operator];
}


-(void)infixToPostFix{
    for (id elem in self.infix) {

        if ([elem isKindOfClass:[NSNumber class]])
            [self.postfix addObject:elem];
        
        else if ([elem isKindOfClass:[NSString class]])
            [self handleOperator:elem];        
    }
    
    while (![self.stack isEmpty])
        [self.postfix addObject:[self.stack pop]];
    
    [self calculate];

}


-(void)calculate{
    for (id obj in self.postfix) {

        if ([obj isKindOfClass:[NSNumber class]])
            [self.stack push:obj];
        
        else if ([obj isKindOfClass:[NSString class]]){
            float first = [[self.stack pop] floatValue];
            float second;
            id s = [self.stack pop];
            if (s == nil)
                second = first;
            else
                second = [s floatValue];
            
            if ([obj isEqualToString:@"+"])
                self.result = first + second;
            
            else if ([obj isEqualToString:@"-"])
                self.result = second - first;
            
            else if ([obj isEqualToString:@"*"])
                self.result = first * second;

            else if ([obj isEqualToString:@"/"])
                self.result = second/first;
            
            else if ([obj isEqualToString:@"^"])
                self.result = pow (second, first);
                     
            [self.stack push:[NSNumber numberWithFloat:self.result]];
        }
    }
    
    [self.stack clear];
}

#pragma mark - UI Logic

-(IBAction)buttonOperationPressed:(id)sender{
    switch ([sender tag]) {
        case 10:
            [self infixToPostFix ];
            [self.infix removeAllObjects];
            [self.postfix removeAllObjects];
            self.calculatorScreen.text = [NSString stringWithFormat:@"%2f", self.result];
            [self.currentNumber setString:self.calculatorScreen.text];
            [self.infix addObject:[NSNumber numberWithFloat:[self.currentNumber floatValue]]];
            self.equalsPreviouslyPressed = YES;
            return;
        case 11:
            [self.infix addObject:@"+"];
            break;
        case 12:
            [self.infix addObject:@"-"];
            break;
        case 13:
            [self.infix addObject:@"*"];
            break;
        case 14:
            [self.infix addObject:@"/"];
            break;
        case 15:
            [self.infix addObject:@"^"];
    }
    self.equalsPreviouslyPressed = NO;
    for (UIButton *button in self.opButtons)
        [button setEnabled:NO];
    [self.currentNumber setString:@""];
    self.calculatorScreen.text = [self.infix componentsJoinedByString:@" "] ;

}

-(IBAction)buttonDigitPressed:(id)sender{
    for (UIButton *button in self.opButtons)
        [button setEnabled:YES];
    
    
    if(self.equalsPreviouslyPressed && [sender tag] != 11){
        [self.currentNumber setString:@""];
        [self.infix removeAllObjects];
        self.equalsPreviouslyPressed = NO;
    }
    
        
    switch([sender tag]){
        case 10:
            [self.currentNumber appendString:@"."];
            break;
        case 11:{
            //remove negative sign
            if ([self.currentNumber hasPrefix:@"-"])
                [self.currentNumber setString:[self.currentNumber substringFromIndex:1]];
            
            //add negative sign
            else{
                NSString * temp = [[NSString alloc] initWithString:self.currentNumber];
                [self.currentNumber setString:@""];
                [self.currentNumber appendString:@"-"];
                [self.currentNumber appendString:temp];
            }
            break;
        }
        default:
            [self.currentNumber appendString:[NSString stringWithFormat:@"%d", [sender tag]]];
    }
    
    id lastObject = [self.infix lastObject];
    if ([lastObject isKindOfClass:[NSNumber class]])
        [self.infix removeLastObject];
    
    [self.infix addObject:[NSNumber numberWithFloat:[self.currentNumber floatValue]]];
    self.calculatorScreen.text = [self.infix componentsJoinedByString:@" "] ;
}

@end
