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
