//
//  Todo.h
//  ToDoList
//
//  Created by Michael Kosmicki on 5/13/14.
//  Copyright (c) 2014 ___kozi___. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Todo : NSObject<NSCoding>
@property (strong, nonatomic) NSString *text;
@property (strong, nonatomic) NSDate *dueDate;
@end
