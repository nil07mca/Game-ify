//
//  ResponseModel.h
//  Game-ify
//
//  Created by IR Mac Mini on 13/08/15.
//  Copyright (c) 2015 Niladri. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QuestionDataModel : NSObject

@property (nonatomic,strong) NSString *correctAnswerIndex;
@property (nonatomic,strong) NSString *imageUrl;
@property (nonatomic,strong) NSString *standFirst;
@property (nonatomic,strong) NSString *storyUrl;
@property (nonatomic,strong) NSString *section;
@property (nonatomic,strong) NSArray *headlines;
-(id)initWithData:(NSDictionary *)questionData;

@end
