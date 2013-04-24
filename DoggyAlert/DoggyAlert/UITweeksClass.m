    //
//  UITweeksClass.m
//  Behave
//
//  Created by Syed Ayaz Uddin Alavi on 9/23/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "UITweeksClass.h"

@implementation UITweeksClass

+ (NSString *)createUUID
{
    // Create universally unique identifier (object)
    CFUUIDRef uuidObject = CFUUIDCreate(kCFAllocatorDefault);
    
    // Get the string representation of CFUUID object.
    NSString *uuidStr = [(NSString *)CFUUIDCreateString(kCFAllocatorDefault, uuidObject) autorelease];
    
    CFRelease(uuidObject);
    
    return uuidStr;
}

+ (NSString *) getDocumentsDirFolder:(NSString *) key {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *fullPathToFile = [documentsDirectory stringByAppendingPathComponent:key];
    return fullPathToFile;
}

+ (NSString *) getDocumentsDirFolder {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    return [paths objectAtIndex:0];
}

@end
