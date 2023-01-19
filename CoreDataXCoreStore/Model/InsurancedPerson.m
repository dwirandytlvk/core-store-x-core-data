//
//  InsurancedPerson.m
//  CoreDataXCoreStore
//
//  Created by Dwi Randy Herdinanto on 17/01/23.
//

#import "InsurancedPerson.h"

static NSString *const kEmailAddress = @"emailAddress";
static NSString *const kNationality = @"nationality";
static NSString *const kFirstName = @"firstName";
static NSString *const kDocumentType = @"documentType";

@implementation InsurancedPerson

- (instancetype)initWithDictionary:(NSDictionary *)dict
                           context:(NSManagedObjectContext *)context {
    self = [super initWithContext:context];
    if (self && [dict isKindOfClass:[NSDictionary class]]) {
        self.emailAddress = [dict safeObjectForKey:kEmailAddress];
        self.nationality = [dict safeObjectForKey:kNationality];
        self.firstName = [dict safeObjectForKey:kFirstName];
        self.documentType = [dict safeObjectForKey:kDocumentType];
    }
    
    return self;
}

@end
