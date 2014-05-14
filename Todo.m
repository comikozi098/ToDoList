//
//  Todo.m
//  ToDoList
//
//  Created by Michael Kosmicki on 5/13/14.
//  Copyright (c) 2014 ___kozi___. All rights reserved.
//

#import "Todo.h"

@implementation Todo
- (id)initWithCoder:(NSCoder *)decoder {
    self = [super init];
    if (!self) {
        return nil;
    }
    
    self.text = [decoder decodeObjectForKey:@"text"];
    self.dueDate = [decoder decodeObjectForKey:@"dueDate"];
    
    return self;
}

- (void)encodeWithCoder:(NSCoder *)encoder {
    [encoder encodeObject:self.text forKey:@"text"];
    [encoder encodeObject:self.dueDate forKey:@"dueDate"];
}

@end
