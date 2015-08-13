//
//  DataManager.h
//  Game-ify
//
//  Created by sadmin on 8/12/15.
//  Copyright (c) 2015 Niladri. All rights reserved.
//

#import <Foundation/Foundation.h>


@protocol DataManagerDelegate

// define protocol functions that can be used in any class using this delegate
-(void)connectionDidCompleteWithData:(NSMutableArray*)arrData;
-(void)connectionFailedWithError:(NSError *)error ;

@end

@interface DataManager : NSObject<NSURLConnectionDelegate>

@property(nonatomic,strong)  NSMutableArray* arrItems ;
@property(nonatomic,strong)  NSString* strURL ;
@property (nonatomic, assign) id  delegate;

-(void)fetchNews ;
- (id) initWithUrlString:(NSString*)str ;

@end
