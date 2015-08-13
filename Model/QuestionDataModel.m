//
//  ResponseModel.m
//  Game-ify
//
//  Created by IR Mac Mini on 13/08/15.
//  Copyright (c) 2015 Niladri. All rights reserved.
//

#import "QuestionDataModel.h"

@implementation QuestionDataModel

-(id)initWithData:(NSDictionary *)questionData {
    if (self = [super init]) {
        self.correctAnswerIndex = [questionData valueForKey:@"correctAnswerIndex"];
        self.imageUrl = [questionData valueForKey:@"imageUrl"];
        self.standFirst = [questionData valueForKey:@"standFirst"];
        self.storyUrl = [questionData valueForKey:@"storyUrl"];
        self.section = [questionData valueForKey:@"section"];
        self.headlines = [questionData valueForKey:@"headlines"];
    }
    return self;
}

@end
