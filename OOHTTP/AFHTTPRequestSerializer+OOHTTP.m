//
//  AFHTTPRequestSerializer+OOHTTP.m
//  OOHTTP
//
//  Created by emsihyo on 2018/4/13.
//  Copyright © 2018年 emsihyo. All rights reserved.
//

#import <JRSwizzle/JRSwizzle.h>

#import "AFHTTPRequestSerializer+OOHTTP.h"
#import "AFHTTPSessionManager+OOHTTP.h"

@implementation AFHTTPRequestSerializer (OOHTTP)

- (NSURLRequest *)oo_http_requestBySerializingRequest:(NSURLRequest *)req withParameters:(nullable id)parameters error:(NSError * _Nullable __autoreleasing *)error{
    NSMutableURLRequest *request=[req mutableCopy];
    NSString *target;NSDictionary *headers;
    oo_http_decode(req.URL.absoluteString, &target, &headers);
    request.URL=[NSURL URLWithString:target];
    request=[[self oo_http_requestBySerializingRequest:request withParameters:parameters error:error] mutableCopy];
    [headers enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        [request setValue:obj forHTTPHeaderField:key];
    }];
    return request;
}

+ (void)load{
    [self jr_swizzleMethod:@selector(requestBySerializingRequest:withParameters:error:) withMethod:@selector(oo_http_requestBySerializingRequest:withParameters:error:) error:nil];
}

@end
