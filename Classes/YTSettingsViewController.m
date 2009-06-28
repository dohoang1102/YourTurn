//
//  YTSettingsViewController.m
//  YourTurn
//
//  Created by Masashi Ono on 09/06/26.
//  Copyright (c) 2009, Masashi Ono
//  All rights reserved.
//

#import "YTSettingsViewController.h"
#import "YTSetSoundViewController.h"
#import "YTSetIntervalViewController.h"
#import "YTSelectionCell.h"
#import "YTUserDefaults.h"
#import "NSString+YourTurn.h"

#define _REUSE_IDENTIFIER_SELECTION @"YTSelectionCell"
#define _CELL_SOUND_SETTINGS 0
#define _CELL_INTERMISSION_SETTINGS 1


@implementation YTSettingsViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    if (self = [super initWithStyle:style])
    {
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.tableView.scrollEnabled = NO;
    self.title = @"Settings";
    soundSettingsCell = [[YTSelectionCell alloc] initWithFrame:CGRectZero
                                               reuseIdentifier:_REUSE_IDENTIFIER_SELECTION];
    intermissionSettingsCell = [[YTSelectionCell alloc] initWithFrame:CGRectZero
                                                      reuseIdentifier:_REUSE_IDENTIFIER_SELECTION];
}

- (void)dealloc
{
    [soundSettingsCell release];
    [intermissionSettingsCell release];
    [super dealloc];
}

#pragma mark ViewController methods

- (void)viewWillAppear:(BOOL)animated
{
    [self.tableView reloadData];
}

- (void)viewDidAppear:(BOOL)animated
{
    // Unselect any selections
	NSIndexPath *tableSelection = [self.tableView indexPathForSelectedRow];
	[self.tableView deselectRowAtIndexPath:tableSelection animated:YES];
}

#pragma mark Table view methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return @"General";
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    BOOL enabled = NO;
    NSString *string = nil;
    switch (indexPath.row) {
        case _CELL_INTERMISSION_SETTINGS:
            enabled = [defaults boolForKey:USERDEFAULTS_INTERMISSION_ENABLED_KEY];
            string = (enabled) ? [NSString stringHMSFormatWithAllottedTime:[defaults integerForKey:USERDEFAULTS_INTERMISSION_DURATION_KEY]] : @"OFF";
            intermissionSettingsCell.label = @"Intermission";
            intermissionSettingsCell.selectionLabel = string;
            return intermissionSettingsCell;
        case _CELL_SOUND_SETTINGS:
            string = [defaults stringForKey:USERDEFAULTS_SOUND_TURNEND_KEY];
            soundSettingsCell.label = @"Sound";
            soundSettingsCell.selectionLabel = string;
            return soundSettingsCell;
        default:
            return nil;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UIViewController *viewController = nil;
    switch (indexPath.row) {
        case _CELL_INTERMISSION_SETTINGS:
            viewController = [[YTSetIntervalViewController alloc] initWithStyle:UITableViewStyleGrouped];
            [self.navigationController pushViewController:viewController animated:YES];
            break;
        case _CELL_SOUND_SETTINGS:
            viewController = [[YTSetSoundViewController alloc] initWithStyle:UITableViewStyleGrouped];
            [self.navigationController pushViewController:viewController animated:YES];
            break;
        default:
            break;
    }
}

@end