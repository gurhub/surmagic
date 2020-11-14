//
//  GreetingsManager.h
//  universal
//
//  Created by Muhammed Gurhan Yerlikaya on 12.11.2020.
//  Copyright © 2020 https://github.com/gurhub/universal. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface GreetingsManager : NSObject

/**
 *
 * Gets the Singleton instance
 *
 */
+ (instancetype)shared;

/**
 *
 * Name for the Greetings!
 *
 */
@property (nonatomic, retain) NSString *name;

/**
*
* The Greetings on the terminal.
*
*/
+ (NSString*)greetings;

@end

NS_ASSUME_NONNULL_END
