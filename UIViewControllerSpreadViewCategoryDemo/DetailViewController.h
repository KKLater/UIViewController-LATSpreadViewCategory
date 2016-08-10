//
//  DetailViewController.h
//  UIViewControllerSpreadViewCategoryDemo
//
//  Created by Later on 16/8/10.
//  Copyright © 2016年 Later. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController

@property (strong, nonatomic) id detailItem;
@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;

@end

