//
//  ANiTunesPlaylist.m
//  luXifer
//
//  Created by Alex Nichol on 11/1/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "ANiTunesPlaylist.h"


@implementation ANiTunesPlaylist

@synthesize plName;
@synthesize plTrackIDs;
@synthesize visible;

- (id)initWithDictionary:(NSDictionary *)dict {
	if (self = [super init]) {
		self.plName = [dict objectForKey:@"Name"];
		self.plTrackIDs = [dict objectForKey:@"Playlist Items"];
		self.visible = [[dict objectForKey:@"Visible"] boolValue];
	}
	return self;
}

- (void)dealloc {
	self.plName = nil;
	self.plTrackIDs = nil;
	[super dealloc];
}

@end
