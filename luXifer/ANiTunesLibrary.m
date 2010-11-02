//
//  ANiTunesLibrary.m
//  luXifer
//
//  Created by Alex Nichol on 11/1/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "ANiTunesLibrary.h"
#import <fnmatch.h>


@implementation ANiTunesLibrary

@synthesize tracks;
@synthesize playlists;

+ (BOOL)string:(NSString *)str matchesPattern:(NSString *)pattern {
	if (fnmatch([pattern UTF8String], [str UTF8String], FNM_CASEFOLD) == 0) {
		return YES;
	}
	return NO;
}

+ (NSArray *)resultsWithParameters:(NSDictionary *)params {
	NSMutableArray * results = [[NSMutableArray alloc] init];
	ANiTunesLibrary * lib = [[ANiTunesLibrary alloc] init];
	[lib loadEverythingFromFile:[NSHomeDirectory() stringByAppendingFormat:@"/Music/iTunes/iTunes Music Library.xml"]];
	// read through tracks
	for (int i = 0; i < [[lib tracks] count]; i++) {
		ANiTunesTrack * track = [[lib tracks] objectAtIndex:i];
		int tkID = [[params objectForKey:@"tid"] intValue];
		// check patterns
		BOOL b1 = ([ANiTunesLibrary string:[track trackName] matchesPattern:[params objectForKey:@"name"]]);
		BOOL b2 = ([ANiTunesLibrary string:[track trackGenre] matchesPattern:[params objectForKey:@"genre"]]);
		BOOL b3 = ([ANiTunesLibrary string:[track trackArtist] matchesPattern:[params objectForKey:@"artist"]]);
		BOOL b4;
		BOOL b5 = (tkID == -1) ? YES : (tkID == [track trackID]);
		switch ([[params objectForKey:@"purchased"] intValue]) {
			case -1:
				b4 = YES;
				break;
			case 0:
				b4 = [track trackPurchased] ? NO : YES;
				break;
			case 1:
				b4 = [track trackPurchased] ? YES : NO;
				break;
			default:
				break;
		}
		if (b1 && b2 && b3 && b4 && b5) {
			[results addObject:track];
		}
	}
	return [results autorelease];
}

+ (void)listContentsWithParameters:(NSDictionary *)params {
	NSArray * arr = [ANiTunesLibrary resultsWithParameters:params];
	for (int i = 0; i < [arr count]; i++) {
		ANiTunesTrack * track = [arr objectAtIndex:i];
		printf("(%d)\t %s - %s \n", [track trackID], 
			   [[track trackName] UTF8String], [[track trackArtist] UTF8String]);
	}
}

- (void)loadEverythingFromFile:(NSString *)filePath {
	NSDictionary * tmpDict = [[NSDictionary alloc] initWithContentsOfFile:filePath];
	if (!tmpDict) {
		return;
	}
	NSMutableArray * tmpTracks = [[NSMutableArray alloc] init];
	NSDictionary * mtracks = [tmpDict objectForKey:@"Tracks"];
	for (NSString * key in mtracks) {
		// process this bad boy
		NSDictionary * trackD = [mtracks objectForKey:key];
		if (trackD) {
			ANiTunesTrack * track = [[ANiTunesTrack alloc] initWithDictionary:trackD];
			if (track) {
				[tmpTracks addObject:track];
			}
		}
	}
	tracks = tmpTracks;
	
	NSMutableArray * tmpPlaylists = [[NSMutableArray alloc] init];
	NSArray * mdict = [tmpDict objectForKey:@"Playlists"];
	for (NSDictionary * plD in mdict) {
		// process this bad boy
		if (plD) {
			ANiTunesPlaylist * pl = [[ANiTunesPlaylist alloc] initWithDictionary:plD];
			if (pl) {
				[tmpPlaylists addObject:pl];
			}
		}
	}
	playlists = tmpPlaylists;
}
- (void)dealloc {
	self.playlists = nil;
	self.tracks = nil;
	[super dealloc];
}

@end
