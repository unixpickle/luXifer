#import <Foundation/Foundation.h>
#import "ANiTunesLibrary.h"

NSDictionary * processCommandArguments (int argc, const char * argv[]) {
	if (argc <= 1) return nil;
	NSMutableDictionary * dict = [[NSMutableDictionary alloc] init];
	for (int i = 1; i < argc; i++) {
		const char * str = argv[i];
		NSString * nstr = [NSString stringWithFormat:@"%s", str];
		if ([nstr hasPrefix:@"--"]) {
			// alright, its a flag
			[dict setObject:[NSNumber numberWithInt:1] 
					 forKey:[nstr substringFromIndex:2]];
		} else if ([nstr hasPrefix:@"-"]) {
			if (i + 1 < argc) {
				// here we go
				i += 1;
				[dict setObject:[NSString stringWithFormat:@"%s", argv[i]]
						 forKey:[nstr substringFromIndex:1]];
			} else {
				// treat as a flag
				[dict setObject:[NSNumber numberWithInt:1] 
						 forKey:[nstr substringFromIndex:1]];
			}
		}
	}
	return [dict autorelease];
}

int main (int argc, const char * argv[]) {
    NSAutoreleasePool * pool = [[NSAutoreleasePool alloc] init];
	
    // process parameters
	NSDictionary * args = processCommandArguments(argc, argv);
	if (!args || [args objectForKey:@"help"]) {
		fprintf(stderr, "Usage: %s\n", argv[0]);
		fprintf(stderr, "          --list   [-name search] [-genre search]\n");
		fprintf(stderr, "                   [-artist search] [-tid trackid]\n");
		fprintf(stderr, "                   [-purchased y|n]\n");
		/*fprintf(stderr, "          --delete [-name search] [-genre search]\n");
		fprintf(stderr, "                   [-artist search] [-tid trackid]\n");
		fprintf(stderr, "                   [-purchased y|n]\n");*/
		return 0;
	}
	if ([[args objectForKey:@"list"] intValue] == 1) {
		// here we list
		printf("Listing contents...\n");
		NSMutableDictionary * sParams = [[[NSMutableDictionary alloc] init] autorelease];
		if ([args objectForKey:@"name"]) {
			[sParams setObject:[args objectForKey:@"name"] forKey:@"name"];
		} else [sParams setObject:@"*" forKey:@"name"];
		if ([args objectForKey:@"genre"]) {
			[sParams setObject:[args objectForKey:@"genre"] forKey:@"genre"];
		} else [sParams setObject:@"*" forKey:@"genre"];
		if ([args objectForKey:@"artist"]) {
			[sParams setObject:[args objectForKey:@"artist"] forKey:@"artist"];
		} else [sParams setObject:@"*" forKey:@"artist"];
		if ([args objectForKey:@"purchased"]) {
			if ([[args objectForKey:@"purchased"] isEqual:@"y"])
				[sParams setObject:[NSNumber numberWithInt:1] forKey:@"purchased"];
			else [sParams setObject:[NSNumber numberWithInt:0] forKey:@"purchased"];
		} else [sParams setObject:[NSNumber numberWithInt:-1] forKey:@"purchased"];
		if ([args objectForKey:@"tid"]) {
			NSString * mStr = [args objectForKey:@"tid"];
			[sParams setObject:[NSNumber numberWithInt:[mStr intValue]] 
						forKey:@"tid"];
		} else [sParams setObject:[NSNumber numberWithInt:-1] forKey:@"tid"];
		
		[ANiTunesLibrary listContentsWithParameters:sParams];
	}
	
    [pool drain];
    return 0;
}
