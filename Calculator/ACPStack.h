//
//  ACPStack.h
//  Calculator
//
//  Created by Anna Parks on 2/8/13.
//  Copyright (c) 2013 Anna Parks. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ACPStack : NSObject{
    NSMutableArray* m_array;
}

- (void)push:(id)anObject;
- (id)pop;
- (id)peek;
- (void)clear;
- (BOOL)isEmpty;


@end
