//
//  LandingViewController.m
//  Gymoji
//
//  Created by Adrian on 7/5/16.
//  Copyright © 2016 bodytech. All rights reserved.
//

#import "LandingViewController.h"
@import FirebaseStorage;
@import FirebaseDatabase;

@interface LandingViewController ()
@property (strong, nonatomic) FIRStorageReference *storageRef;
@property (strong, nonatomic) FIRDatabaseReference *postRef;
@property (strong, nonatomic) FIRDatabaseReference *commentsRef;

@property (nonatomic,strong)NSMutableArray *imagesArray;
@property (nonatomic, strong)NSMutableArray *stickers;
@property (nonatomic, strong)NSDictionary *post;
@property (nonatomic)int k;
@end

@implementation LandingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [[self navigationController]setNavigationBarHidden:YES];
    [self setNeedsStatusBarAppearanceUpdate];
    
    self.stickers = [[NSMutableArray alloc]init];
    self.post = [[NSDictionary alloc]init];
    self.k = 0;
    NSMutableArray *urlArray = [[NSMutableArray alloc]initWithObjects:@"https://body360-gymoji.firebaseio.com/keyboard-equipment",@"https://body360-gymoji.firebaseio.com/keyboard-bodybuilding",@"https://body360-gymoji.firebaseio.com/keyboard-muscles",@"https://body360-gymoji.firebaseio.com/keyboard-gymselfie",@"https://body360-gymoji.firebaseio.com/keyboard-workouts", nil];
    UIActivityIndicatorView *indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    for(int i = 0; i<5; i++){
        
        [indicator startAnimating];
        [indicator setCenter:self.view.center];
        [self.view addSubview:indicator];
        FIRDatabaseReference *ref = [[FIRDatabase database] referenceFromURL:[urlArray objectAtIndex:i]];
        [ref observeSingleEventOfType:FIRDataEventTypeValue withBlock:^(FIRDataSnapshot * _Nonnull snapshot) {
            NSDictionary *post = snapshot.value;
            self.imagesArray = [[NSMutableArray alloc]init];
            NSLog(@"%@",post);
            for(int j = 1; j<post.count; j++){
                
                if(j<10){
                    
                    NSData * imageData = [[NSData alloc] initWithContentsOfURL: [NSURL URLWithString: [post objectForKey:[NSString stringWithFormat:@"img0%d",j]]]];
                    UIImage *image = [UIImage imageWithData:imageData];
                    NSData *images = UIImagePNGRepresentation(image);
                    if(images){
                        
                        [self.imagesArray addObject:images];
                    }
                }else{
                    
                    NSData * imageData = [[NSData alloc] initWithContentsOfURL: [NSURL URLWithString: [post objectForKey:[NSString stringWithFormat:@"img%d",j]]]];
                    UIImage *image = [UIImage imageWithData:imageData];
                    NSData *images = UIImagePNGRepresentation(image);
                    if(images){
                        
                       [self.imagesArray addObject:images];
                    }
                }
            }
            NSUserDefaults *userDefaults = [[NSUserDefaults alloc] initWithSuiteName:@"group.bodytech.gymoji"];
            [userDefaults setObject:self.imagesArray forKey:[NSString stringWithFormat:@"imagePath%d",i]];
            self.k++;
            
            if(self.k == 5){
                [indicator stopAnimating];
                [indicator removeFromSuperview];
            }

        }];
        
        
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(UIStatusBarStyle)preferredStatusBarStyle {
    
    return UIStatusBarStyleLightContent;
}

@end
