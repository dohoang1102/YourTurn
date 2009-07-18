//
//  YTSelectionCell.m
//  YourTurn
//
//  Created by Masashi Ono on 09/06/26.
//  Copyright (c) 2009, Masashi Ono
//  All rights reserved.
//

#import "YTSelectionCell.h"


@implementation YTSelectionCell

#pragma mark property

@synthesize label;
@synthesize selectionLabel;

- (CGFloat)height
{
    return 44.0;
}

# pragma mark init, dealloc, memory management

- (id)initWithFrame:(CGRect)frame reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithFrame:frame reuseIdentifier:reuseIdentifier])
    {
        label = [[UILabel alloc] initWithFrame:CGRectZero];
        label.font = [UIFont boldSystemFontOfSize:16.0];
        [self addSubview:label];
        selectionLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        selectionLabel.textAlignment = UITextAlignmentRight;
        [self addSubview:selectionLabel];
        
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        self.selectionStyle = UITableViewCellSelectionStyleBlue;
    }
    return self;
}

- (void)dealloc
{
    [label release];
    [selectionLabel release];
    [super dealloc];
}

#pragma mark TableCell method

- (void)layoutSubviews
{
    [super layoutSubviews];
    label.frame = CGRectMake(25, 12, 170, 24);
    selectionLabel.frame = CGRectMake(170, 12, 110, 24);
}

@end
