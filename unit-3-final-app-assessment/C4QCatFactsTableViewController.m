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

}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
    [self fetchCatData];
    
}



- (void)fetchCatData {
    
   // NSString *urlString = [NSString stringWithFormat:CAT_API_URL];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"application/javascript"];
//    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
//    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    
    [manager GET:CAT_API_URL
      parameters:nil
        progress:nil
         success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
             
              //NSLog(@"response object: %@", responseObject);
             
//             NSError *error;
//             NSDictionary *jsonDictionary = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:&error];
             
         //    NSArray *resultsArray = [jsonDictionary objectForKey:@"facts"];
             
             NSArray *resultsArray = [responseObject objectForKey:@"facts"];
             
             
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
    
    cell.catFactLabel.text = results;
    
    return cell;
}



@end
