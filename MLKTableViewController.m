//
//  MLKTableViewController.m
//  ToDoList
//
//  Created by Michael Kosmicki on 5/4/14.
//  Copyright (c) 2014 ___kozi___. All rights reserved.
//

#import "MLKTableViewController.h"
#import "Todo.h" 


@interface MLKTableViewController ()
@property (strong, nonatomic) NSMutableArray *todos;
@end

@implementation MLKTableViewController

-(void) shareTodo:(NSString *)todo withDueDate: (NSDate *) dueDate  atRow: (NSInteger) row {
    NSString *message = todo;
    NSDate *date = dueDate;
    NSArray *todoMail = @[message,date];
    UIActivityViewController *activityVC = [[UIActivityViewController alloc] initWithActivityItems:todoMail applicationActivities:nil];
    [self.navigationController presentViewController:activityVC animated:YES completion:nil];

}
- (void)updateTodo:(NSString *)todo withDueDate:(NSDate *)dueDate atRow:(NSUInteger)row {
    Todo *item = [[Todo alloc] init];
    item.text = todo;
    item.dueDate = dueDate;
    [self.todos replaceObjectAtIndex:row withObject:item];
    
    
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"dueDate" ascending:YES];
    [self.todos sortUsingDescriptors:@[sortDescriptor]];
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSData *todoData = [NSKeyedArchiver archivedDataWithRootObject:self.todos];
    [userDefaults setObject:todoData forKey:@"todos"];
    [userDefaults synchronize];
    
    
    [self.tableView reloadData];
    [self.navigationController popViewControllerAnimated:YES];
   }

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    Todo *todo = self.todos[indexPath.row];
    MLKCreateTodoViewController *createVC = [[MLKCreateTodoViewController alloc] initWithTodo:todo atRow:indexPath.row];
    createVC.delegate = self;
    [self.navigationController pushViewController:createVC animated:YES];
}
- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        self.navigationItem.title = @"To-Do List";
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(didTapAddButton)];
      self.todos = [NSKeyedUnarchiver unarchiveObjectWithFile:self.resourcePath];
        
        if (!self.todos) {
            self.todos = [[NSMutableArray alloc] init];
        }
    }
    return self;
}
- (void)didTapAddButton {
    
    MLKCreateTodoViewController *createVC = [[MLKCreateTodoViewController alloc] init];
    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:createVC];
    createVC.delegate = self;
    [self.navigationController presentViewController:navController animated:YES completion:nil];
}
- (void)didCancelCreatingNewTodo; {
    NSLog(@"you hit cancel ahh!");
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}
- (void)createTodo:(NSString *)todo withDueDate:(NSDate *)dueDate {
    Todo *item = [[Todo alloc] init];
    item.text = todo;
    item.dueDate = dueDate;
    [self.todos addObject:item];
    
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"dueDate" ascending:YES];
    [self.todos sortUsingDescriptors:@[sortDescriptor]];
    
    [NSKeyedArchiver archiveRootObject:self.todos toFile:self.resourcePath];
    
    [self.tableView reloadData];
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}

- (NSString *)resourcePath {
    return [NSBundle.mainBundle.resourcePath  stringByAppendingPathComponent:@"todos"];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.todos.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"Cell"];
    }
    
    Todo *todo = self.todos[indexPath.row];
    cell.textLabel.text = todo.text;
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateStyle = NSDateFormatterMediumStyle;
    
    cell.detailTextLabel.text = [NSString stringWithFormat:@"Due %@",
                                 [dateFormatter stringFromDate:todo.dueDate]];
    return cell;
}/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/


- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [self.todos removeObjectAtIndex:indexPath.row];
        
        [NSKeyedArchiver archiveRootObject:self.todos toFile:self.resourcePath];
        
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
}

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
