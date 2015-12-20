//
//  C4QCatsTableViewController.m
//  unit-3-final-assessment
//
//  Created by Michael Kavouras on 12/17/15.
//  Copyright © 2015 Michael Kavouras. All rights reserved.
//

#import "C4QCatFactsTableViewController.h"
#import <AFNetworking/AFNetworking.h>
#import "TableViewCell.h"
#import "C4QCatFactsDetailViewController.h"
#import "C4QSavedCatFactsViewController.h"

#define CAT_API_URL @"http://catfacts-api.appspot.com/api/facts?number=100"

@interface C4QCatFactsTableViewController ()

@property (nonatomic) NSMutableArray *results;

@end

@implementation C4QCatFactsTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // register nib with table view
    
    UINib *nib = [UINib nibWithNibName:@"TableViewCell" bundle:nil];
    
    
    //register the nib for the cell identifier
    [self.tableView registerNib:nib forCellReuseIdentifier:@"CatFactIdentifier"];
    
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 20.0;

}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
    [self fetchCatData];
    
}



- (void)fetchCatData {
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
 //   manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"application/javascript"];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    
    [manager GET:CAT_API_URL
      parameters:nil
        progress:nil
         success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
             
              //NSLog(@"response object: %@", responseObject);
             
             NSError *error;
             NSDictionary *jsonDictionary = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:&error];
             
             NSArray *resultsArray = [jsonDictionary objectForKey:@"facts"];
             
           //  NSArray *resultsArray = [responseObject objectForKey:@"facts"];
             
             
             self.results = [[NSMutableArray alloc] init];
             
             for (NSString *result in resultsArray) {
                // NSLog(@"result: %@",result);
                 
                 [self.results addObject:result];
                 
             }
             
             [self.tableView reloadData];
         }
         failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
             
             NSLog(@"%@", error.userInfo);
             
         }];

    
}


- (IBAction)savedButtonTapped:(UIBarButtonItem *)sender {
    C4QSavedCatFactsViewController *savedVC = (C4QSavedCatFactsViewController *)[self.storyboard instantiateViewControllerWithIdentifier: @"SavedCatFactsVC"];
    UINavigationController *navVC = [[UINavigationController alloc] initWithRootViewController:savedVC];
    navVC.navigationBar.topItem.title = @"Saved Cat Facts";
    navVC.navigationBar.topItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(dismissView:)];
    
    UIBarButtonItem *deleteButton = [[UIBarButtonItem alloc] initWithTitle:@"Delete" style:UIBarButtonItemStylePlain target:self action:@selector(delete:)];
    navVC.navigationBar.topItem.rightBarButtonItem = deleteButton;
    [self.navigationController presentViewController:navVC animated:YES completion:nil];

}
                                                     
- (void) dismissView:(id)sender {
    [self.presentedViewController dismissViewControllerAnimated:YES completion:nil];
}

- (void) delete:(id)sender {
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"savedFacts"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    [self.presentedViewController dismissViewControllerAnimated:YES completion:nil];
}


#pragma mark - Table view data source



- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.results.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CatFactIdentifier" forIndexPath:indexPath];
    
    NSString *results = self.results[indexPath.row];
    
    cell.selectedCatFact = results;
    
    cell.catFactLabel.text = results;
    
    cell.catFactLabel.textAlignment = NSTextAlignmentJustified;
    
    [cell.catFactLabel sizeToFit];
    
    [cell.button setImage:[UIImage imageNamed:@"add_icon"] forState:UIControlStateNormal];
    
    NSArray *savedFacts = [[NSUserDefaults standardUserDefaults] objectForKey:@"savedFacts"];
    
    if (savedFacts != nil) {
        for (NSString *fact in savedFacts) {
            if ([fact isEqualToString:cell.catFactLabel.text]) {
                [cell.button setImage:[UIImage imageNamed:@"Check_mark"] forState:UIControlStateNormal];
            }
        }
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    C4QCatFactsDetailViewController *vc = (C4QCatFactsDetailViewController *)[self.storyboard instantiateViewControllerWithIdentifier: @"CatFactDetailVC"];
    vc.catFact = [self.results objectAtIndex:indexPath.row];
    [self.navigationController pushViewController:vc animated:YES];
    
}







@end
