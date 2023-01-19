//
//  InsurancedPerson.h
//  CoreDataXCoreStore
//
//  Created by Dwi Randy Herdinanto on 17/01/23.
//

#import <CoreData/CoreData.h>
#import "NSDictionary+SafeObject.h"


@class InsuranceDetail;

NS_ASSUME_NONNULL_BEGIN

@interface InsurancedPerson : NSManagedObject

@property (nonatomic, strong) NSString *emailAddress;
@property (nonatomic, strong) NSString *nationality;
//@property (nonatomic, strong) NSString *firstName;
//@property (nonatomic, strong) NSString *lastName;
@property (nonatomic, strong) NSString *fullName;
@property (nonatomic, strong) NSString *documentType;

// Relationship
@property (nonatomic, assign) InsuranceDetail *insuranceDetail;

- (instancetype)initWithDictionary:(NSDictionary *)dict
                           context:(NSManagedObjectContext *)context;

@end

NS_ASSUME_NONNULL_END
