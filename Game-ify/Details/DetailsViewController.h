//
//  DetailsViewController.h
//  Game-ify
//
//  Created by sadmin on 8/12/15.
//  Copyright (c) 2015 Niladri. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailsViewController : UIViewController

@property(nonatomic,strong) UIImage *questionImg;
@property (nonatomic,strong) NSString *questionStandFirst;
@property (nonatomic,strong) NSString *questionStoryUrl;
@property (assign) BOOL isWrongAnswer;
@property (assign) int totalPoint ;
@property (assign) int pointGained ;
@property (nonatomic,weak) IBOutlet UIImageView *imgView;
@property (nonatomic,weak) IBOutlet UILabel *standFirstLbl;
@property (nonatomic,weak) IBOutlet UILabel *totalScoreLbl;
@property (nonatomic,weak) IBOutlet UILabel *answerStatusLbl;

-(IBAction)nextQuestionAction:(id)sender;
-(IBAction)readArticleAction:(id)sender;

@end
