//
//  MLKCreateTodoViewController.h
//  ToDoList
//
//  Created by Michael Kosmicki on 5/7/14.
//  Copyright (c) 2014 ___kozi___. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol MLKCreateTodoViewControllerDelegate
//methods
-(void)sayHello;
- (void)createTodo:(NSString *)todo withDueDate:(NSDate *)dueDate;
- (void)didCancelCreatingNewTodo;

@end












@interface MLKCreateTodoViewController : UIViewController<UITextFieldDelegate>

@property (weak, nonatomic) id<MLKCreateTodoViewControllerDelegate>delegate;

@end

