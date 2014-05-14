//
//  MLKCreateTodoViewController.h
//  ToDoList
//
//  Created by Michael Kosmicki on 5/7/14.
//  Copyright (c) 2014 ___kozi___. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Todo;

@protocol MLKCreateTodoViewControllerDelegate
- (void)createTodo:(NSString *)todo withDueDate:(NSDate *)dueDate;
- (void)updateTodo:(NSString *)toto withDueDate:(NSDate *)dueDate atRow:(NSUInteger)row;
- (void)didCancelCreatingNewTodo;
- (void) shareTodo:(NSString *)todo withDueDate: (NSDate *) dueDate  atRow: (NSInteger) row;
@end












@interface MLKCreateTodoViewController : UIViewController<UITextFieldDelegate>

@property (weak, nonatomic) id<MLKCreateTodoViewControllerDelegate>delegate;
@property (strong, nonatomic) Todo *todo;
@property (assign, nonatomic) NSUInteger row;
- (instancetype)initWithTodo:(Todo *)todo atRow:(NSUInteger)row;
@end

