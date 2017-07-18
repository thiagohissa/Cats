//
//  ViewController.m
//  Cats (P*)
//
//  Created by Thiago Hissa on 2017-07-17.
//  Copyright © 2017 Thiago Hissa. All rights reserved.
//

#import "ViewController.h"
#import "MyTableViewCell.h"
#import "Photo.h"
#import "DetailViewController.h"

@interface ViewController () <UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *mytable;
@property (nonatomic) NSMutableArray *objects;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.objects = [[NSMutableArray alloc]init];
    [self loadData];
}



-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.objects.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    MyTableViewCell *cell = [self.mytable dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    Photo *photo = self.objects[indexPath.row];
    
    cell.cellTitle.text = photo.title;
    cell.cellSubtitle.text = photo.idAPI;
    

    UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:photo.photoImageName]]];
    cell.cellImage.image = image;

    return cell;
    
}







-(void)loadData{
    
    
    NSURL *url = [NSURL URLWithString:@"https://api.flickr.com/services/rest/?method=flickr.photos.search&format=json&nojsoncallback=1&api_key=db3e12fd37ab1610f43df6372788eb9d&tags=surf"];
    NSURLRequest *request = [[NSURLRequest alloc]initWithURL:url];
    
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration];
    
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        if(error){
            NSLog(@"Error...");
            return;
        }
        
        NSError *jsonError = nil;
        NSDictionary *info = [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonError];
        
        
        NSDictionary *dict = [info valueForKeyPath:@"photos.photo"];
        NSMutableArray *temp = [[NSMutableArray alloc] init];
        for (NSDictionary *apiData in dict) {
            Photo *photo = [[Photo alloc] initWithServer:apiData[@"server"] andFarm:apiData[@"farm"] andID:apiData[@"id"] andSecret:apiData[@"secret"] andTitle:apiData[@"title"]];
            [temp addObject:photo];
        }
        
        
        self.objects = [NSMutableArray arrayWithArray:temp];
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            [self.mytable reloadData];
        }];
        
    }];
    
    [dataTask resume];
    
}






- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
        NSIndexPath *indexPath = [self.mytable indexPathForSelectedRow];
     Photo *photo = self.objects[indexPath.row];
        UINavigationController *nav = (UINavigationController *)[segue destinationViewController];
    DetailViewController *controller = [nav.viewControllers firstObject];
        [controller setDetailItem:photo];
}






@end
