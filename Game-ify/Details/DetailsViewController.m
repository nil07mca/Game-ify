//
//  DetailsViewController.m
//  Game-ify
//
//  Created by sadmin on 8/12/15.
//  Copyright (c) 2015 Niladri. All rights reserved.
//

#import "DetailsViewController.h"

@interface DetailsViewController ()
@property (weak, nonatomic) IBOutlet UILabel *lblPoint;

@end

@implementation DetailsViewController

@synthesize questionImg,questionStandFirst,questionStoryUrl,totalPoint, pointGained,isWrongAnswer;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view from its nib.
}

-(void)viewWillAppear:(BOOL)animated{
    [_imgView setImage:self.questionImg];
    [_standFirstLbl setText:self.questionStandFirst];
    [_imgView setClipsToBounds:YES];
    [_totalScoreLbl setText:[NSString stringWithFormat:@"Score:%d",totalPoint]];
    
    if(self.isWrongAnswer){
        [_answerStatusLbl setText:@"That's Wrong"];
        [self.lblPoint setText:[NSString stringWithFormat:@"%d",pointGained]];
    }else{
        [_answerStatusLbl setText:@"That's Right"];
        [self.lblPoint setText:[NSString stringWithFormat:@"+%d",pointGained]];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

/*
This method is fired when Next Question button is pressed. In this method we fetch last viewcontroller with the UINavigationController and fire its method which starts loading of the next question.
*/

-(IBAction)nextQuestionAction:(id)sender{
    id homeViewController = [self.navigationController.viewControllers firstObject];
    if(!homeViewController)
        return;
    #pragma clang diagnostic push
    #pragma clang diagnostic ignored "-Wundeclared-selector"
    SEL selector = @selector(loadNextQuestion);
    
    
    if([homeViewController respondsToSelector:selector]){
        #pragma clang diagnostic push
        #pragma clang diagnostic ignored "-Warc-performSelector-leaks"
        [homeViewController performSelector:selector withObject:Nil];
        #pragma clang diagnostic pop
    }
    #pragma clang diagnostic pop
    NSLog(@"Next question pressed");
    [self.navigationController popViewControllerAnimated:YES];
}

/*
 This method is fired when Read Article button is pressed. In this method we open the questionStoryLink in the mobile browser.
 */
-(IBAction)readArticleAction:(id)sender{
    NSLog(@"Read article pressed");
    
    NSURL *url = [NSURL URLWithString:self.questionStoryUrl];
    
    if (![[UIApplication sharedApplication] openURL:url]) {
        NSLog(@"%@%@",@"Failed to open url:",[url description]);
    }
}
@end
