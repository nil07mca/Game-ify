//
//  HomeViewController.h
//  Game-ify
//
//  Created by sadmin on 8/12/15.
//  Copyright (c) 2015 Niladri. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DataManager.h"


@interface HomeViewController : UIViewController<DataManagerDelegate>

@property (nonatomic,weak) IBOutlet UIActivityIndicatorView *loadIndicator;
@property (nonatomic,weak) IBOutlet UIProgressView *progressView;
@property (nonatomic,weak) IBOutlet UIView *progressViewContainer;
@property (nonatomic,weak) IBOutlet UIView *loaderView;

-(IBAction)tapGiveUp:(id)sender;
-(IBAction)tapAnswer:(id)sender;
-(void)loadNextQuestion;
@end
