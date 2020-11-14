//
//  GreetingsManager.m
//  universal
//
//  Created by Muhammed Gurhan Yerlikaya on 12.11.2020.
//  Copyright © 2020 https://github.com/gurhub/universal. All rights reserved.
//

#import "GreetingsManager.h"

static NSString *const kEmptyString = @"";

@implementation GreetingsManager

#pragma mark Singleton Methods

+ (instancetype)shared {
    static GreetingsManager *sharedManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedManager = [[self alloc] init];
    });
    return sharedManager;
}

- (instancetype)init {
    if (self = [super init]) {
        _name = kEmptyString; // Default Property Value
    }
    return self;
}

+ (NSString*)greetings {
    if ([GreetingsManager.shared.name isEqualToString:kEmptyString]) {
        return @"Please fill the name property!";
    } else {
        return [NSString stringWithFormat:@"Greetings %@!", GreetingsManager.shared.name];
    }
}

@end
