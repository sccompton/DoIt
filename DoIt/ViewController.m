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
}

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    items = [NSMutableArray arrayWithObjects:
             @"One", @"Two",
             @"Three", nil];
    
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

- (IBAction)onSwipeDelete:(id)sender {
   
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
