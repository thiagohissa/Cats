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
#import "SearchViewController.h"
#import "ShowAllViewController.h"

@interface ViewController () <UITableViewDelegate, UITableViewDataSource, SearchItemDelegate>
@property (weak, nonatomic) IBOutlet UITextField *searchTextField;
@property (weak, nonatomic) IBOutlet UITableView *mytable;
@property (nonatomic) NSMutableArray *objects;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.objects = [[NSMutableArray alloc]init];
    [self loadData:@"surf"];
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





#pragma Search (NO Location)

-(void)loadData:(NSString*)search{
    
//  Searc location by id = https://api.flickr.com/services/rest/?method=flickr.photos.geo.getLocation&api_key=db3e12fd37ab1610f43df6372788eb9d&photo_id=4256176301&format=json&nojsoncallback=1
// key = db3e12fd37ab1610f43df6372788eb9d
    
    
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"https://api.flickr.com/services/rest/?method=flickr.photos.search&api_key=db3e12fd37ab1610f43df6372788eb9d&tags=%@&has_geo=1&extras=url_m&format=json&nojsoncallback=1", search]];
    
    
   
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





#pragma Search By Location

-(void)loadData:(NSString*)search withLat:(double)lat andLon:(double)lon{
    
    //  Searc by id = https://api.flickr.com/services/rest/?method=flickr.photos.geo.getLocation&api_key=db3e12fd37ab1610f43df6372788eb9d&photo_id=4256176301&format=json&nojsoncallback=1
    // key = db3e12fd37ab1610f43df6372788eb9d
    
    // https://api.flickr.com/services/rest/?method=flickr.places.findByLatLon&api_key=db3e12fd37ab1610f43df6372788eb9d&lat=%f&lon=%f&format=json&nojsoncallback=1
    
    
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"https://api.flickr.com/services/rest/?method=flickr.photos.geo.photosForLocation&api_key=db3e12fd37ab1610f43df6372788eb9d&lat=%f&lon=%f&format=json&nojsoncallback=1&auth_token=72157684196964440-49f543050c32d51d&api_sig=27c69255a1fd8c71b9e45ea361f20e08",lat,lon]];
    
    
    NSURLRequest *request = [[NSURLRequest alloc]initWithURL:url];
    
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration];
    
    NSURLSessionDataTask *dataTaskSearch = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
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
    
    [dataTaskSearch resume];
    
}







- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    
    if([segue.identifier isEqualToString:@"segue"]){
    
    NSIndexPath *indexPath = [self.mytable indexPathForSelectedRow];
    Photo *photo = self.objects[indexPath.row];
    
    
    // This url search image location by id - START
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"https://api.flickr.com/services/rest/?method=flickr.photos.geo.getLocation&api_key=db3e12fd37ab1610f43df6372788eb9d&photo_id=%@&format=json&nojsoncallback=1", photo.idAPI]];
    // This url search image location by id - END
    
    
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
        
        
        NSDictionary *dict = [info valueForKeyPath:@"photo.location"];
        photo.tempLAT = [dict[@"latitude"] doubleValue];
        photo.tempLON = [dict[@"longitude"] doubleValue];
        photo.coordinate = CLLocationCoordinate2DMake(photo.tempLAT,photo.tempLON);
        
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            UINavigationController *nav = (UINavigationController *)[segue destinationViewController];
            DetailViewController *controller = [nav.viewControllers firstObject];
            [controller setDetailItem:photo];
        }];
        
    }];
    
    [dataTask resume];
        
    }
    
    else if([segue.identifier isEqualToString:@"showAllSegue"]){
        UINavigationController *nav = (UINavigationController *)[segue destinationViewController];
        ShowAllViewController *controller = [nav.viewControllers firstObject];
        [controller setMap:self.objects];
    }
    
    else{
        UINavigationController *nav = segue.destinationViewController;
        SearchViewController *addVC = nav.viewControllers[0];
        addVC.delegate = self;
    }
   
}





- (IBAction)searchButton:(id)sender {
    [self loadData:self.searchTextField.text];
}
    



// Search Delegate Method

-(void)searchString:(NSString *)string{
    [self loadData:string];
}

-(void)searchString:(NSString *)string withLat:(double)lat andLon:(double)lon{
    [self loadData:string withLat:lat andLon:lon];
}





- (IBAction)showAllButton:(id)sender {
}






@end
