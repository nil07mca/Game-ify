//
//  HomeViewController.m
//  Game-ify
//
//  Created by sadmin on 8/12/15.
//  Copyright (c) 2015 Niladri. All rights reserved.
//

#import "HomeViewController.h"
#import "DetailsViewController.h"
#import "QuestionDataModel.h"

@interface HomeViewController ()<NSURLConnectionDelegate>{
    NSMutableData* responseData ;
    NSArray* arrRecords ;
    int counter ;
    int currentPoint ;
    int point ;
    NSInteger correctAnswerIndex ;
    DataManager* dataManager ;
    NSTimer* timer ;
    BOOL isFirstWrong ;
    BOOL isWrongAnswer ;
    __weak IBOutlet UIImageView *imgNews;
    
    __weak IBOutlet UIButton *btnOption1;
    
    __weak IBOutlet UIButton *btnOption2;
    
    __weak IBOutlet UIButton *btnOption3;
    
    __weak IBOutlet UILabel *lblPoint;
    QuestionDataModel *currentQuestion;
}
@end


#define SERVICE_URL @"https://dl.dropboxusercontent.com/u/30107414/game.json"
#define MAX_POINT 10
@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationController setNavigationBarHidden:YES];
    dataManager = [[DataManager alloc] initWithUrlString:SERVICE_URL];
    dataManager.delegate = self ;
    [dataManager fetchNews];
    counter = 0;
    correctAnswerIndex = -1 ;
    
    
    
    
    // Do any additional setup after loading the view from its nib.
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [_progressViewContainer.layer setBorderWidth:1.0];
    [_progressViewContainer.layer setBorderColor:[[UIColor whiteColor] CGColor]];
    
    _progressView.frame = CGRectMake(_progressView.frame.origin.x, _progressView.frame.origin.y, _progressView.frame.size.width, 27);
    
    UIImage *img = [UIImage imageNamed:@"progress_image.png"];
    img = [img resizableImageWithCapInsets:UIEdgeInsetsMake(0, 4, 0, 4)];
    _progressView.progressImage = img;
    
    img = [UIImage imageNamed:@"track_image.png"];
    img = [img resizableImageWithCapInsets:UIEdgeInsetsMake(0, 4, 0, 4)];
    _progressView.trackImage = img;
}
/*
 This method gets fired after pressing Skip! I give up button. It starts loading next question.
 */
-(IBAction)tapGiveUp:(id)sender{
    [timer invalidate];
    counter ++ ;
    if (counter<[arrRecords count]) {
        [self loadNewsForIndex:counter];
    }
}

/*
 This method gets fired after pressing any of the option provided. Point calculation and detail screen navigation initiation occurs in this method.
 */
-(IBAction)tapAnswer:(id)sender{
    UIButton* btn = (UIButton*)sender ;
    NSInteger tag = btn.tag;
    if (tag == correctAnswerIndex) {
        [timer invalidate];
        currentPoint = currentPoint + point ;
        [sender setBackgroundColor:[UIColor greenColor]];
        isWrongAnswer = NO;
        [self goToDetailsPage];
    }else{
        [self performSelector:@selector(resetButtonColor) withObject:nil afterDelay:0.25];
        [timer invalidate];
        isFirstWrong = YES ;
        isWrongAnswer = YES;
        [self goToDetailsPage];
        [sender setBackgroundColor:[UIColor redColor]];
    }
    
}
/*
This method navigate the user to the detail screen
*/
-(void)goToDetailsPage{
    
    DetailsViewController* details = [[DetailsViewController alloc] initWithNibName:@"DetailsViewController" bundle:[NSBundle mainBundle]];
    
    details.questionStoryUrl = currentQuestion.storyUrl;//[dictItem valueForKey:@"storyUrl"];
    details.questionImg = imgNews.image;
    details.questionStandFirst = currentQuestion.standFirst;//[dictItem valueForKey:@"standFirst"];
    if(isWrongAnswer){
        if (currentPoint >=2) {
            currentPoint = currentPoint - 2 ;
            details.pointGained = -2 ;
        }else{
            details.pointGained = 0;
        }
        
    }else
        details.pointGained = point ;
    details.isWrongAnswer = isWrongAnswer;
    details.totalPoint = currentPoint;
    [self.navigationController pushViewController:details animated:YES];
}
#pragma mark - DataManagerDelegate
-(void)connectionDidCompleteWithData:(NSMutableArray*)arrData{
    arrRecords = arrData ;
    [self loadNewsForIndex:counter];
}
-(void)connectionFailedWithError:(NSError *)error{
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
/*
 This method resets the option buttons background color.
 */
-(void)resetButtonColor{
    [btnOption1  setBackgroundColor:[UIColor whiteColor]];
    [btnOption2  setBackgroundColor:[UIColor whiteColor]];
    [btnOption3  setBackgroundColor:[UIColor whiteColor]];
    
}

/*
This method is used to show/hide the views. It is required at the time of question loading to show the loader and hide other views.
*/
-(void)showHideViews:(BOOL)showHideStatus{
    
    for (UIView *subView in self.view.subviews) {
        if(([subView isKindOfClass:[UIImageView class]] && subView != imgNews) || (subView == _loaderView) )
            continue;
        [subView setHidden:showHideStatus];
    }
}
/*
This method load next question.
*/
-(void)loadNewsForIndex:(int)index{
    
    [self showHideViews:YES];
    [self.view bringSubviewToFront:_loadIndicator];
    [_loadIndicator startAnimating];
    [_loaderView setHidden:NO];
    
    [self resetButtonColor];
    if (index < [arrRecords count]) {
        
        currentQuestion = (QuestionDataModel *)[arrRecords objectAtIndex:index];
        NSString* strURL = currentQuestion.imageUrl;
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            NSData *imgData = [NSData dataWithContentsOfURL:[NSURL URLWithString:strURL]];
            if (imgData) {
                
                UIImage *image = [UIImage imageWithData:imgData];
                if (image) {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [_loaderView setHidden:YES];
                        [_loadIndicator stopAnimating];
                        imgNews.image = image;
                        correctAnswerIndex = [currentQuestion.correctAnswerIndex intValue];
                        NSArray* options = currentQuestion.headlines;
                        if ([options count]>2) {
                            [btnOption1 setTitle:[options objectAtIndex:0] forState:UIControlStateNormal];
                            [btnOption2 setTitle:[options objectAtIndex:1] forState:UIControlStateNormal];
                            [btnOption3 setTitle:[options objectAtIndex:2] forState:UIControlStateNormal];
                        }
                        [self showHideViews:NO];
                        [_progressView setProgress:1.0];
                        point = MAX_POINT ;
                        isFirstWrong = NO ;
                        timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(deductPoint) userInfo:nil repeats: YES];
                    });
                    
                    
                }
            }
        });
    }
}
/*
This method is getting fired after every second. In this method we are updating the progress value for timer and text for time remaining.
*/

-(void)deductPoint{
   
    [lblPoint setText:[NSString stringWithFormat:@"+%d",point]];
    point-- ;
    
    float t = _progressView.progress;
    _progressView.progress = t - 0.1;
    if (point == 0) {
        [timer invalidate];
    }
    
}
/*
This method is getting called from detail screen if user choose to load next question. 
*/

-(void)loadNextQuestion{
    counter++;
    [lblPoint setText:[NSString stringWithFormat:@"%d",MAX_POINT]];
    [self loadNewsForIndex:counter];
}

@end
