//
//  KeyboardViewController.h
//  GymojiKeyboard
//
//  Created by Bart on 7/14/16.
//  Copyright © 2016 bodytech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KeyboardViewController : UIInputViewController 

@property (weak, nonatomic) IBOutlet UIView *equiment_view;
@property (weak, nonatomic) IBOutlet UIView *marcle_view;
@property (nonatomic) Boolean equimentflag;
@property (nonatomic) Boolean marcleflag;
@property (weak, nonatomic) IBOutlet UIButton *gymoji_1;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIPageControl *pageControll;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (strong, nonatomic) IBOutletCollection(UIView) NSArray *CategoryView;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *categoryButtons;

@end
