//
//  ANiTunesTrack.h
//  luXifer
//
//  Created by Alex Nichol on 11/1/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>

enum eANiTunesTrackType {
	kANiTunesTrackTypeVideo = 1,
	kANiTunesTrackTypeAudio =  2
};

typedef enum eANiTunesTrackType ANiTunesTrackType;

@interface ANiTunesTrack : NSObject {
	int trackID;
	NSString * trackName;
	NSString * trackArtist;
	NSString * trackGenre;
	ANiTunesTrackType trackType;
	int trackPlayCount;
	BOOL trackPurchased;
	NSString * trackPathURL;
	NSDictionary * loadedDictionary;
}

@property (nonatomic, retain) NSString * trackName;
@property (nonatomic, retain) NSString * trackArtist;
@property (nonatomic, retain) NSString * trackGenre;
@property (nonatomic, retain) NSString * trackPathURL;
@property (readwrite) ANiTunesTrackType trackType;
@property (readwrite) int trackPlayCount;
@property (readwrite) int trackID;
@property (readwrite) BOOL trackPurchased;

- (id)initWithDictionary:(NSDictionary *)dictionary;
@end
