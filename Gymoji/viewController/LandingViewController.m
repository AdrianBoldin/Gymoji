//
//  LandingViewController.m
//  Gymoji
//
//  Created by Adrian on 7/5/16.
//  Copyright © 2016 bodytech. All rights reserved.
//

#import "LandingViewController.h"
#import "AppDelegate.h"
@import FirebaseStorage;
@import FirebaseDatabase;

@interface LandingViewController ()
@property (strong, nonatomic) FIRStorageReference *storageRef;
@property (strong, nonatomic) FIRDatabaseReference *postRef;
@property (strong, nonatomic) FIRDatabaseReference *commentsRef;

@property (nonatomic,strong)NSMutableArray *imagesArray;
@property (nonatomic, strong)NSMutableArray *stickers;
@property (nonatomic, strong)NSDictionary *post;
@property (nonatomic)int progressActulNumber;
@property (nonatomic)int numberofimages;
@property (nonatomic)int increase;
@property (nonatomic, strong)UIProgressView *prgView;
@property (nonatomic, strong)UILabel *downloadText;
@end

@implementation LandingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [[self navigationController]setNavigationBarHidden:YES];
    [self setNeedsStatusBarAppearanceUpdate];
    
    self.increase = 0;

}

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    self.stickers = [[NSMutableArray alloc]init];
    self.post = [[NSDictionary alloc]init];
    self.progressActulNumber = 0;
    

    AppDelegate *appDelegat = (AppDelegate *)[[UIApplication sharedApplication]delegate];
    appDelegat.numberofLandingPageLoaded++;
    if(appDelegat.numberofLandingPageLoaded == 1){
        
        self.numberofimages = 0;
        
        self.prgView = [[UIProgressView alloc]initWithProgressViewStyle:UIProgressViewStyleBar];
        _prgView.frame = CGRectMake(self.view.frame.size.width * 0.2, self.view.frame.size.height * 0.8, self.view.frame.size.width * 0.6, 20);
        _prgView.backgroundColor = [UIColor whiteColor];
        [self.view addSubview:_prgView];
        
        _prgView.progress=0.0;
        _downloadText = [[UILabel alloc]initWithFrame:CGRectMake(self.view.frame.size.width * 0.2, self.view.frame.size.height * 0.83, self.view.frame.size.width * 0.6, 30)];
        _downloadText.textColor = [UIColor whiteColor];
        _downloadText.text = @"Prepare downloading...";
        _downloadText.textAlignment = NSTextAlignmentCenter;
        [_downloadText setFont:[UIFont systemFontOfSize:11]];
        
        [self.view addSubview:_downloadText];
        
        NSString *urlstring = @"https://body360-gymoji.firebaseio.com";
        
        
        FIRDatabaseReference *ref = [[FIRDatabase database] referenceFromURL:urlstring];
        [ref observeSingleEventOfType:FIRDataEventTypeValue withBlock:^(FIRDataSnapshot * _Nonnull snapshot) {
            NSDictionary *post = snapshot.value;
            NSLog(@"%@",snapshot.value);
            NSMutableArray *dicArrays = [[NSMutableArray alloc]initWithObjects : [post objectForKey:@"keyboard-equipment"],[post objectForKey:@"keyboard-workouts"],[post objectForKey:@"keyboard-muscles"],[post objectForKey:@"keyboard-bodybuilding"],[post objectForKey:@"keyboard-gymselfie"],nil];
            for(int n = 0; n<dicArrays.count; n++){
                NSMutableArray *array = [dicArrays objectAtIndex:n];
                _numberofimages = _numberofimages + array.count;
            }
            
            NSLog(@"%d",_numberofimages);
            self.imagesArray = [[NSMutableArray alloc]init];
            
            
            dispatch_queue_t q = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0ul);
            dispatch_async(q, ^{
                NSMutableArray *dicArrays = [[NSMutableArray alloc]initWithObjects : [post objectForKey:@"keyboard-equipment"],[post objectForKey:@"keyboard-workouts"],[post objectForKey:@"keyboard-muscles"],[post objectForKey:@"keyboard-bodybuilding"],[post objectForKey:@"keyboard-gymselfie"],nil];
                for(int i = 0; i<dicArrays.count ;i++){
                    
                    NSDictionary *dic = [[NSDictionary alloc]init];
                    dic = [dicArrays objectAtIndex:i];
                    
                    
                    for(int j = 1; j<dic.count + 1; j++){
                        
                        if(j<10){
                            
                            NSData * imageData = [[NSData alloc] initWithContentsOfURL: [NSURL URLWithString: [dic objectForKey:[NSString stringWithFormat:@"img0%d",j]]]];
                            UIImage *image = [UIImage imageWithData:imageData];
                            NSData *images = UIImagePNGRepresentation(image);
                            if(images){
                                
                                [self.imagesArray addObject:images];
                                self.progressActulNumber++;
                                
                                NSLog(@"%@",[NSURL URLWithString: [dic objectForKey:[NSString stringWithFormat:@"img0%d",j]]]);
                                
                                [self performSelectorOnMainThread:@selector(fetchResultsForGoogle:) withObject:[NSNumber numberWithFloat:self.progressActulNumber]  waitUntilDone:YES];
                                
                                
                            }
                        }else{
                            
                            NSData * imageData = [[NSData alloc] initWithContentsOfURL: [NSURL URLWithString: [dic objectForKey:[NSString stringWithFormat:@"img%d",j]]]];
                            UIImage *image = [UIImage imageWithData:imageData];
                            NSData *images = UIImagePNGRepresentation(image);
                            if(images){
                                [self.imagesArray addObject:images];
                                self.progressActulNumber++;
                                
                                NSLog(@"%@",[NSURL URLWithString: [dic objectForKey:[NSString stringWithFormat:@"img%d",j]]]);
                                [self performSelectorOnMainThread:@selector(fetchResultsForGoogle:) withObject:[NSNumber numberWithFloat:self.progressActulNumber]  waitUntilDone:YES];
                                
                            }
                        }
                    }
                    
                    dispatch_async(dispatch_get_main_queue(), ^{
                        NSLog(@"progressActulNumber%d",self.progressActulNumber);
                        
                        NSUserDefaults *userDefaults = [[NSUserDefaults alloc] initWithSuiteName:@"group.bodytech.gymoji"];
                        [userDefaults setObject:self.imagesArray forKey:[NSString stringWithFormat:@"imagePath%d",i]];
                        self.imagesArray = [[NSMutableArray alloc]init];
                        
                    });
                }
                
                
                
            });
            
        }];

    }
    
    
}

-(void)fetchResultsForGoogle:(NSNumber*)number{
    self.increase++;
    float percentage = [number floatValue];
    NSLog(@"number%f",number);
    _prgView.progress =((float)self.increase /self.numberofimages);
    _downloadText.text = [NSString stringWithFormat:@"Downloading %d%@%d%@",self.increase,@" of ",self.numberofimages,@" Gymoji's"];
    if(self.increase == self.numberofimages){
        [self.prgView removeFromSuperview];
        _downloadText.text = @"Download Completed!";
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(UIStatusBarStyle)preferredStatusBarStyle {
    
    return UIStatusBarStyleLightContent;
}

@end
