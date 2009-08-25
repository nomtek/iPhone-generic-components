//
//  TableViewSection.m
//  RKFinder
//
//  Created by Krzysztof Choma on 09-08-06.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "TableViewModel.h"

@implementation TableViewRow

@synthesize cell;
@synthesize height;

- (id)initWithCell:(UITableViewCell*)newCell target:(NSObject*)newTarget selector:(SEL)newSelector {
	if (self = [super init]) {
		cell = newCell;
		[cell retain];
		
		target = newTarget;
		targetSel = newSelector;
		height = nil;
	}
	return self;
}

- (void)wasSelected {
	[target performSelector: targetSel withObject:nil];
}

- (void)dealloc {
	[cell release];
	[height release];
    [super dealloc];
}

@end

@implementation TableViewSection

@synthesize title;

- (id)initWithTitle:(NSString*)newTitle {
	if (self = [super init]) {
		title = newTitle;
		[title retain];
		
		rows = [[NSMutableArray alloc] init];
	}
	return self;
}

- (NSInteger)numberOfRows {
	return rows.count;
}

- (TableViewRow*)getRowAtIndex:(NSInteger)index {
	return (TableViewRow*)[rows objectAtIndex:index];
}

- (UITableViewCell*)cellForRow:(NSInteger)row {
	return [self getRowAtIndex:row].cell;
}

- (void)didSelectRow:(NSInteger)row {
	[[self getRowAtIndex:row] wasSelected];
}

- (TableViewRow*)addRowWithCell:(UITableViewCell*)newCell target:(NSObject*)newTarget selector:(SEL)newSelector {
	TableViewRow* row = [[TableViewRow alloc] initWithCell:newCell target:newTarget selector:newSelector];
	[rows addObject:row];
	[row release];
	return row;
	return nil;
}

- (NSNumber*)heightForRow:(NSInteger)row {
	return [self getRowAtIndex:row].height;
}

- (void)dealloc {
	[title release];
	[rows release];
    [super dealloc];
}

@end

@implementation TableViewModel

- (id)init {
	if (self = [super init]) {
		sections = [[NSMutableArray alloc] init];
	}
	return self;
}

- (TableViewSection*)addSectionWithTitle:(NSString*)title {
	TableViewSection* section = [[TableViewSection alloc] initWithTitle:title];
	[sections addObject:section];
	[section release];
	return section;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	return sections.count;
}

- (TableViewSection*)getSectionAtIndex:(NSInteger)index {
	return (TableViewSection*)[sections objectAtIndex:index];
}

- (NSInteger)tableView:(UITableView*)tableView numberOfRowsInSection:(NSInteger)section {
	return [[self getSectionAtIndex:section] numberOfRows];
}

- (UITableViewCell *)tableView:(UITableView*)tableView cellForRowAtIndexPath:(NSIndexPath*)indexPath {
	return [[self getSectionAtIndex:indexPath.section] cellForRow:indexPath.row];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	[tableView deselectRowAtIndexPath:indexPath animated:YES];
	[[self getSectionAtIndex:indexPath.section] didSelectRow:indexPath.row];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
	return [self getSectionAtIndex:section].title;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
	NSNumber* height = [[self getSectionAtIndex:indexPath.section] heightForRow:indexPath.row];
	if (height == nil) {
		return tableView.rowHeight;
	} else {
		return [height floatValue];
	}
}

- (void)dealloc {
	[sections release];
    [super dealloc];
}

@end
