//
//  NSDictionary+SafeObject.h
//  CoreDataXCoreStore
//
//  Created by Dwi Randy Herdinanto on 18/01/23.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (SafeObject)

/**
 Get object using key of dictionary

 @param key key-string of dictionary
 @return return object if exist, otherwise return nil
 */
- (nullable id)safeObjectForKey:(nonnull NSString *)key;

/**
 Get object using keypath of dictionary

 @param keyPath key path of dictionar
 @return return object if exist, otherwise return nil
 */
- (nullable id)safeValueForKeyPath:(nonnull NSString *)keyPath;

/**
 Get object using key of dictionary

 @param aKey key-string of dictionary
 @param dict dictionary
 @return return object if exist, otherwise return nil
 */
- (nullable id)objectOrNilForKey:(nonnull NSString *)aKey fromDictionary:(nonnull NSDictionary *)dict DEPRECATED_MSG_ATTRIBUTE("This method is created in category class but it performs class method. Please use safeObjectForKey instead.");

@end

