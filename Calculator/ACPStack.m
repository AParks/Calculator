//
//  ACPStack.m
//  Calculator
//
//  Created by Anna Parks on 2/8/13.
//  Copyright (c) 2013 Anna Parks. All rights reserved.
//

#import "ACPStack.h"

@implementation ACPStack




- (id)init
{
    if( self=[super init] )
    {
        m_array = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void)push:(id)anObject
{
    [m_array addObject:anObject];
}

- (void)clear
{
    [m_array removeAllObjects];
}

- (id)pop
{
    id topOfStack = [m_array lastObject];
    if (topOfStack)
        [m_array removeLastObject];

    return topOfStack;
}

-(BOOL)isEmpty{
    return ([m_array count] == 0 );
}

- (id)peek
{
    return[m_array lastObject];    
}


@end
