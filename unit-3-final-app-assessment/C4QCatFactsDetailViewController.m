//
//  C4QCatFactDetailViewController.m
//  unit-3-final-app-assessment
//
//  Created by Michael Kavouras on 12/18/15.
//  Copyright © 2015 Michael Kavouras. All rights reserved.
//

#import "C4QCatFactsDetailViewController.h"
#import <AFNetworking/AFNetworking.h>

#define CAT_GIF_URL @"http://api.giphy.com/v1/gifs/search?q=funny+cat&api_key=dc6zaTOxFJmzC"

@interface C4QCatFactsDetailViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *catImageView;
@property (weak, nonatomic) IBOutlet UILabel *catFactLabel;

@end

@implementation C4QCatFactsDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.catFactLabel.text = self.catFact;
    self.catImageView.clipsToBounds = YES;
    
    [self fetchImageData];
    
    
    
}


- (void)fetchImageData {
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];

    
    [manager GET:CAT_GIF_URL
      parameters:nil
        progress:nil
         success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
             
             NSError *error;
             NSDictionary *jsonDict = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:&error];
             
             NSArray *results = [jsonDict objectForKey:@"data"];
             
             NSUInteger randomIndex = (0 + arc4random() % (results.count - 0));
             
             NSDictionary *randomCat = [results objectAtIndex:randomIndex];
             
             NSDictionary *images =[randomCat objectForKey:@"images"];
             
             NSDictionary *originalStill = [images objectForKey:@"original_still"];
             NSString *imageURL = [originalStill objectForKey:@"url"];
             
             
             dispatch_async(dispatch_get_global_queue(0,0), ^{
                 NSData * data = [[NSData alloc] initWithContentsOfURL: [NSURL URLWithString: imageURL]];
                 if ( data == nil )
                     return;
                 dispatch_async(dispatch_get_main_queue(), ^{
                     self.catImageView.image = [UIImage imageWithData:data];
                     
                 });
             });

         } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
             NSLog(@"fail:%@", error);
         }];

    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
