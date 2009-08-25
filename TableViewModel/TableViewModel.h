//
//  TableViewSection.h
//  RKFinder
//
//  Created by Krzysztof Choma on 09-08-06.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TableViewRow : NSObject {
	UITableViewCell* cell;
	NSObject* target;
	SEL targetSel;
	NSNumber* height;
}

@property (readonly) UITableViewCell* cell;
@property (retain) NSNumber* height;

- (id)initWithCell:(UITableViewCell*)newCell target:(NSObject*)newTarget selector:(SEL)newSelector;
- (void)wasSelected;

@end

@interface TableViewSection : NSObject {
	NSString *title;
	NSMutableArray *rows;
}

@property (readonly) NSString* title;

- (id)initWithTitle:(NSString*)newTitle;
- (NSInteger)numberOfRows;
- (UITableViewCell*)cellForRow:(NSInteger)row;
- (void)didSelectRow:(NSInteger)row;
- (TableViewRow*)addRowWithCell:(UITableViewCell*)newCell target:(NSObject*)newTarget selector:(SEL)newSelector;
- (NSNumber*)heightForRow:(NSInteger)row;

@end

@interface TableViewModel : NSObject <UITableViewDataSource, UITableViewDelegate> {
	NSMutableArray* sections;
}

- (TableViewSection*)addSectionWithTitle:(NSString*)title;

@end

