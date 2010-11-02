//
//  ANiTunesTrack.m
//  luXifer
//
//  Created by Alex Nichol on 11/1/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "ANiTunesTrack.h"


@implementation ANiTunesTrack

@synthesize trackName;
@synthesize trackArtist;
@synthesize trackGenre;
@synthesize trackPathURL;
@synthesize trackType;
@synthesize trackPlayCount;
@synthesize trackPurchased;
@synthesize trackID;

- (id)initWithDictionary:(NSDictionary *)dictionary {
	if (self = [super init]) {
		loadedDictionary = [dictionary retain];
		// load specific attributes
		self.trackID = [[loadedDictionary objectForKey:@"Track ID"] intValue];
		self.trackName = [loadedDictionary objectForKey:@"Name"];
		self.trackArtist = [loadedDictionary objectForKey:@"Artist"];
		self.trackGenre = [loadedDictionary objectForKey:@"Genre"];
		self.trackPathURL = [loadedDictionary objectForKey:@"Location"];
		if ([[loadedDictionary objectForKey:@"Has Video"] boolValue]) 
			self.trackType = kANiTunesTrackTypeVideo;
		else self.trackType = kANiTunesTrackTypeAudio;
		self.trackPlayCount = [[loadedDictionary objectForKey:@"Play Count"] intValue];
		self.trackPurchased = [[loadedDictionary objectForKey:@"Purchased"] boolValue];
		if (!self.trackName || !self.trackPathURL) {
			// return here
			[self release];
			return nil;
		}
		if (!self.trackArtist) self.trackArtist = @"Unknown";
	}
	return self;
}

- (void)dealloc {
	[loadedDictionary release];
	loadedDictionary = nil;
	self.trackArtist = nil;
	self.trackGenre = nil;
	self.trackName = nil;
	self.trackPathURL = nil;
	[super dealloc];
}
@end
