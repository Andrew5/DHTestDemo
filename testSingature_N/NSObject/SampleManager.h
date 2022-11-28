//
//  SampleManager.h
//  LessonSql
//
//  Created by 肖 浩 on 12-11-16.
//  Copyright (c) 2012年 肖 浩. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SampleStudent.h"
#import <sqlite3.h>

@interface SampleManager : NSObject
{
    sqlite3 *_db;
    sqlite3 *dbNew;

}

+ (SampleManager *)instance;


- (BOOL) isOpenDB;
- (BOOL) createSampleStudentTable;
- (BOOL) insertStudent:(SampleStudent *)student;
- (BOOL) deleteStudent:(SampleStudent *)student;
- (BOOL) updateStudent:(SampleStudent *)student;

- (NSArray *) allStudent;

/// 数据库新
- (NSString *) filePath;
- (void) openDB;
- (void) createTableNamed:(NSString *) tableName
               withField1:(NSString *) field1
               withField2:(NSString *) field2;
- (void) insertRecordIntoTableNamed:(NSString *) tableName
                         withField1:(NSString *) field1
                        field1Value:(NSString *) field1Value
                         withField2:(NSString *) field2
                        field2Value:(NSString *) field2Value;
- (void) gatAllRowsFromTableNamed:  (NSString *) tableName;


@end
