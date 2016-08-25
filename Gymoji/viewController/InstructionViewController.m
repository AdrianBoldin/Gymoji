//
//  InstructionViewController.m
//  Gymoji
//
//  Created by Adrian on 7/5/16.
//  Copyright © 2016 bodytech. All rights reserved.
//

#import "InstructionViewController.h"

@interface InstructionViewController ()
@property (nonatomic,strong)NSMutableArray *imagesArray;
@end

@implementation InstructionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNeedsStatusBarAppearanceUpdate];
    
//    self.imagesArray = [[NSMutableArray alloc]init];
//    NSUserDefaults *userDefaults = [[NSUserDefaults alloc] initWithSuiteName:@"group.bodytech.gymoji"];
//    for(int i = 0;i<2 ;i++){
//      
//        NSMutableArray *array = [NSMutableArray arrayWithArray:[userDefaults objectForKey:[NSString stringWithFormat:@"imagePath%d",i]]];
//        NSMutableArray *imageArray = [[NSMutableArray alloc]init];
//        for(int j=1;j<array.count;j++){
//            UIImage *image = [UIImage imageWithData:[array objectAtIndex:j]];
//            [imageArray addObject:image];
//        }
//        [self.imagesArray addObject:imageArray];
//    }
//    
//    UIImageView *iamgeView = [[UIImageView alloc]initWithFrame:CGRectMake(50, 50, 50, 50)];
//    NSMutableArray *tempArray = [self.imagesArray objectAtIndex:0];
//    iamgeView.image = [tempArray objectAtIndex:0];
//    [self.view addSubview:iamgeView];
    
       // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)backToLandingPage:(id)sender {
    
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (IBAction)openSettins:(id)sender {
    
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"prefs:root=Settings"]];
    
}

-(UIStatusBarStyle)preferredStatusBarStyle {
    
    return UIStatusBarStyleLightContent;
}


@end
