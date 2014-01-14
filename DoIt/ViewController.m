//
//  ViewController.m
//  DoIt
//
//  Created by gule on 1/13/2014.
//  Copyright (c) 2014 gule. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <UITableViewDataSource, UITableViewDelegate>
{
    
    __weak IBOutlet UITextField *myTextField;
    __weak IBOutlet UITableView *myTableView;
    NSMutableArray *items;
    BOOL isEditMode;
    __weak IBOutlet UIButton *isEditButton;
    NSIndexPath *rowToSelect;
    
}

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    items = [NSMutableArray arrayWithObjects:
             @"One", @"Two",
             @"Three", nil];
    
    UISwipeGestureRecognizer *swipeRight = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(onSwipeColorChange:)];
    swipeRight.direction = UISwipeGestureRecognizerDirectionRight;
    
    [myTableView addGestureRecognizer:swipeRight]; //to change colors on swipe
    
    [myTableView setEditing:YES animated:YES]; //to call the reorder list
    
	// Do any additional setup after loading the view, typically from a nib.
}


- (IBAction)onAddButtonPressed:(id)sender
{
    
    [items addObject:myTextField.text];

    [myTableView reloadData];
    myTextField.text = @"";
}

- (IBAction)onEditButtonPressed:(id)sender
{
    if (isEditMode) {
        isEditMode = NO;
        [isEditButton setTitle:@"Edit" forState:UIControlStateNormal];        
    } else {
        isEditMode = YES;
        [isEditButton setTitle:@"Done" forState:UIControlStateNormal];
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (isEditMode) {
        
        [items removeObjectAtIndex:indexPath.row];
        [myTableView reloadData];
        
         
    } else {
        UITableViewCell *cellColor = [tableView cellForRowAtIndexPath:indexPath];
        cellColor.textLabel.textColor = [UIColor greenColor];
    }
}
- (IBAction)onSwipeColorChange:(UISwipeGestureRecognizer *)swipe
{
    
   NSArray *colors = @[[UIColor blackColor], [UIColor redColor], [UIColor yellowColor], [UIColor greenColor], [UIColor blackColor]];
    
    CGPoint swipeLoction = [swipe locationInView:myTableView];
    NSIndexPath *swipeLocationPath = [myTableView indexPathForRowAtPoint:swipeLoction];
    UITableViewCell *swipeCell = [myTableView cellForRowAtIndexPath:swipeLocationPath];
    
    for (int i = 0; i < colors.count; i++)
    {
        if (colors[i]== swipeCell.textLabel.textColor)
        {
            swipeCell.textLabel.textColor = colors[i+1];
            i= colors.count;
        }
    }
}

- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    
    //if (isEditMode)
    return YES;
    //else return NO;
    
}


- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath {
    NSLog(@"reorder data");
    
}
- (NSIndexPath *)tableView:(UITableView *)tableView
targetIndexPathForMoveFromRowAtIndexPath:(NSIndexPath *)sourceIndexPath
       toProposedIndexPath:(NSIndexPath *)proposedDestinationIndexPath {
    //reorder list on editModeOn
/*    NSDictionary *section = [items objectAtIndex:sourceIndexPath.section];
    NSUInteger sectionCount = [[section valueForKey:@"content"] count];
    if (sourceIndexPath.section != proposedDestinationIndexPath.section) {
        NSUInteger rowInSourceSection =
        (sourceIndexPath.section > proposedDestinationIndexPath.section) ?
        0 : sectionCount - 1;
        return [NSIndexPath indexPathForRow:rowInSourceSection inSection:sourceIndexPath.section];
    } else if (proposedDestinationIndexPath.row >= sectionCount) {
        return [NSIndexPath indexPathForRow:sectionCount - 1 inSection:sourceIndexPath.section];
    }*/
    // Allow the proposed destination.
   
    return proposedDestinationIndexPath;
}




- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return items.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"myReuseIdentifier"];
    
    NSString *item = [items objectAtIndex: indexPath.row];
    
    cell.textLabel.text = [NSString stringWithFormat:@"%@", item ];
    return cell;
    
}

-(void)tableView:(UITableView*)tableView willBeginEditingRowAtIndexPath:(NSIndexPath *)indexPath {
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle
forRowAtIndexPath:(NSIndexPath *)indexPath {
    // If row is deleted, remove it from the list.
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        NSInteger row = [indexPath row];
        [items removeObjectAtIndex:row];
        [myTableView reloadData];
    }
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
