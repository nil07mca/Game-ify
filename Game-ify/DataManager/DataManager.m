//
//  DataManager.m
//  Game-ify
//
//  Created by sadmin on 8/12/15.
//  Copyright (c) 2015 Niladri. All rights reserved.
//

#import "DataManager.h"
#import "QuestionDataModel.h"


@interface DataManager ()<NSURLConnectionDelegate>{
    NSMutableData* responseData ;
    
}
@end

@implementation DataManager
@synthesize arrItems , strURL;

- (id) initWithUrlString:(NSString*)str {
    if ( (self = [super init]) ) {
        // Initialization code here.
        strURL = str ;
        
    }
    return self;
}

-(void)fetchNews{
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:strURL]];
    
    // Create url connection and fire request
    NSURLConnection *conn = [[NSURLConnection alloc] initWithRequest:request delegate:self];
}

#pragma mark - Connection
- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    // A response has been received, this is where we initialize the instance var you created
    // so that we can append data to it in the didReceiveData method
    // Furthermore, this method is called each time there is a redirect so reinitializing it
    // also serves to clear it
    responseData = [[NSMutableData alloc] init];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    // Append the new data to the instance variable you declared
    [responseData appendData:data];
}

- (NSCachedURLResponse *)connection:(NSURLConnection *)connection
                  willCacheResponse:(NSCachedURLResponse*)cachedResponse {
    // Return nil to indicate not necessary to store a cached response for this connection
    return nil;
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    // The request is complete and data has been received
    // You can parse the stuff in your instance variable now
    NSError *error = nil;
    NSDictionary* dictResponse = [NSJSONSerialization JSONObjectWithData:responseData options:kNilOptions error:&error];
    NSArray *items = [dictResponse objectForKey:@"items"];
    self.arrItems = [NSMutableArray array];
    for (NSDictionary *eachItem in items) {
        [self.arrItems addObject:[[QuestionDataModel alloc] initWithData:eachItem]];
    }
    //arrItems = [dictResponse objectForKey:@"items"];
    if (error != nil) {
        NSLog(@"Error parsing JSON.");
    }
    else {
        //NSLog(@"Array: %@", arrItems);
        if ([self.delegate respondsToSelector:@selector(connectionDidCompleteWithData:)]) {
            [self.delegate connectionDidCompleteWithData:arrItems];
        }
    }
    
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    // The request has failed for some reason!
    // Check the error var
    if ([self.delegate respondsToSelector:@selector(connectionFailedWithError:)]) {
        [self.delegate connectionFailedWithError:error];
    }
}




@end
