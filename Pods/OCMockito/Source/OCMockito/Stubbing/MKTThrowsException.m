//  OCMockito by Jon Reid, http://qualitycoding.org/about/
//  Copyright 2016 Jonathan M. Reid. See LICENSE.txt

#import "MKTThrowsException.h"


@interface MKTThrowsException ()
@property (nonatomic, strong, readonly) NSException *exception;
@end

@implementation MKTThrowsException

- (instancetype)initWithException:(NSException *)exception
{
    self = [super init];
    if (self)
        _exception = exception;
    return self;
}

- (id)answerInvocation:(NSInvocation *)invocation
{
    [self.exception raise];
    return nil;
}

@end
