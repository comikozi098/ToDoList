//
//  MLKCreateTodoViewController.m
//  ToDoList
//
//  Created by Michael Kosmicki on 5/7/14.
//  Copyright (c) 2014 ___kozi___. All rights reserved.
//

#import "MLKCreateTodoViewController.h"
#import "Todo.h"

@interface MLKCreateTodoViewController ()
@property (strong, nonatomic) UITextField *todoInput;
@property (strong, nonatomic) UITextField *dueDateInput;
@property (strong, nonatomic) NSDate *dueDate;
@end

@implementation MLKCreateTodoViewController



- (void)viewDidLoad
{
    
    [super viewDidLoad];
    
    
    self.navigationItem.title = @"New To-Do";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(didTapDoneButton)];
    if (!self.todo) {
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Cancel" style:UIBarButtonItemStyleDone target:self action:@selector(didTapCancelButton)];
    }
    [self createShareButton];
    [self renderTodoText];
    
    [self renderDueDate];
}
-(void)createShareButton {
    UIButton *share = [[UIButton alloc] initWithFrame:CGRectMake(30, 100, 50, 20)];
    [share setTitle:@"Share" forState:UIControlStateNormal];
    [share sizeToFit];
    [self.view addSubview:share];
    [share addTarget:self
               action:@selector(didTapShareButton)
     forControlEvents:UIControlEventTouchUpInside];
    
}
-(void)didTapShareButton {
    [self.delegate shareTodo:self.todoInput.text withDueDate:self.dueDate atRow:self.row];
    
}
- (void)didTapDoneButton {
    if (self.todo) {
        [self.delegate updateTodo:self.todoInput.text withDueDate:self.dueDate atRow:self.row];
    } else {
        [self.delegate createTodo:self.todoInput.text withDueDate:self.dueDate];
    }
}

- (void)didTapCancelButton {
    [self.delegate didCancelCreatingNewTodo];
}
- (void)renderTodoText {
    
    UILabel *todoLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 80, 0, 0)];
    todoLabel.text = @"To-do:";
    todoLabel.font = [UIFont boldSystemFontOfSize:UIFont.systemFontSize];
    [todoLabel sizeToFit];
    [self.view addSubview:todoLabel];
    
    self.todoInput = [[UITextField alloc] init];
    if (self.todo) {
        self.todoInput.text = self.todo.text;
    }
    self.todoInput.borderStyle = UITextBorderStyleRoundedRect;
    self.todoInput.placeholder = @"Enter a to-do here.";
    self.todoInput.clearButtonMode = UITextFieldViewModeUnlessEditing;
    self.todoInput.delegate = self;
    self.todoInput.frame = CGRectMake(CGRectGetMinX(todoLabel.frame),
                                      CGRectGetMaxY(todoLabel.frame) + 5,
                                      CGRectGetWidth(self.view.frame) - (40),
                                      40);
    [self.view addSubview:self.todoInput];

}

- (void)renderDueDate {
   
    CGRect dueDateLabelFrame = CGRectMake(CGRectGetMinX(self.todoInput.frame), CGRectGetMaxY(self.todoInput.frame) + 30, 0, 0);
    UILabel *dueDateLabel = [[UILabel alloc] initWithFrame:dueDateLabelFrame];
    dueDateLabel.text = @"Due date:";
    dueDateLabel.font = [UIFont boldSystemFontOfSize:UIFont.systemFontSize];
    [dueDateLabel sizeToFit];
    [self.view addSubview:dueDateLabel];
    
    self.dueDateInput = [[UITextField alloc] init];
    self.dueDateInput.borderStyle = UITextBorderStyleRoundedRect;
    self.dueDateInput.placeholder = @"Due date";
    self.dueDateInput.clearButtonMode = UITextFieldViewModeUnlessEditing;
    self.dueDateInput.delegate = self;
    
    CGRect dueDateFrame = self.todoInput.frame;
    dueDateFrame.origin.y = CGRectGetMaxY(dueDateLabel.frame) + 5;
    self.dueDateInput.frame = dueDateFrame;
    
    UIDatePicker *datePicker = [[UIDatePicker alloc] init];
    datePicker.datePickerMode = UIDatePickerModeDate;
    [datePicker addTarget:self action:@selector(didChangeDate:) forControlEvents:UIControlEventValueChanged];
    self.dueDateInput.inputView = datePicker;
    
    [self.view addSubview:self.dueDateInput];
    if (self.todo) {
        NSDateFormatter  *dateFormatter = [[NSDateFormatter alloc]init];
        dateFormatter.dateStyle = NSDateFormatterMediumStyle;
        self.dueDate = self.todo.dueDate;
        self.dueDateInput.text = [dateFormatter stringFromDate:self.dueDate];
        if (self.dueDate) {
             datePicker.date = self.dueDate;
        }
       
    }
  
}

-(void)didChangeDate:(UIDatePicker *)picker {
    
    self.dueDate = [picker date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    dateFormatter.dateStyle = NSDateFormatterMediumStyle;
    
    self.dueDateInput.text = [dateFormatter stringFromDate:self.dueDate];
    NSLog(@"date is %@",self.dueDate);
}



- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}
- (id)initWithTodo:(Todo *)todo atRow:(NSUInteger)row {
    if (self = [super init]) {
        self.todo = todo;
        self.row = row;
    }
    return self;
}

@end
