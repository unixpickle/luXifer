//
//  ANiTunesLibrary.h
//  luXifer
//
//  Created by Alex Nichol on 11/1/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "ANiTunesTrack.h"
#import "ANiTunesPlaylist.h"


@interface ANiTunesLibrary : NSObject {
	NSMutableArray * tracks;
	NSMutableArray * playlists;
}

@property (nonatomic, retain) NSMutableArray * tracks;
@property (nonatomic, retain) NSMutableArray * playlists;

+ (NSArray *)resultsWithParameters:(NSDictionary *)params;
+ (void)listContentsWithParameters:(NSDictionary *)params;
- (void)loadEverythingFromFile:(NSString *)filePath;
@end
