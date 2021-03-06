/*
 * This file is part of the Tile project.
 *
 * Copyright 2009 Crazor <crazor@gmail.com>
 *
 * Tile is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 * 
 * Tile is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 * 
 * You should have received a copy of the GNU General Public License
 * along with Tile.  If not, see <http://www.gnu.org/licenses/>.
 */

#import "AreaController.h"
#import "Area.h"

@implementation AreaController

@synthesize screen;
@synthesize toplevelArea;

static AreaController *sharedInstance;

+ (void)initialize
{
	static BOOL initialized = NO;
	if(!initialized)
	{
		sharedInstance = [[AreaController alloc] init];
		initialized = YES;
	}
}

+ (AreaController *)sharedInstance
{
	return sharedInstance;
}

- (id)init
{
	if (sharedInstance)
	{
		[self dealloc];
		return sharedInstance;
	}

	return self;
}

- (void)awakeFromNib
{
	[self discoverScreens];
}

- (void)discoverScreens
{
	NSArray *screens = [NSScreen screens];
	NSLog(@"Found %d screens.", [screens count]);

	for (int i = 0; i < [screens count]; i++)
	{
		NSScreen *aScreen = [screens objectAtIndex:i];
		NSString *mainScreen;
		if (i == 0)
		{
			mainScreen = [NSString stringWithString:@"[Main screen]"];
			screen = aScreen;
		}
		else
		{
			mainScreen = @"";
		}
		
		NSLog(@"Screen %d: Resolution: %@ %@", i, [[aScreen deviceDescription] objectForKey:NSDeviceSize], mainScreen);
		NSLog(@"Frame: %@ %@", NSStringFromSize([aScreen frame].size), NSStringFromPoint([aScreen frame].origin));
		
		if (i == 0)
		{
			NSRect rect = [aScreen frame];
			rect.origin.y += 22;
			rect.size.height -= 22;
			NSLog(@"Rect: %@", NSStringFromRect(rect));
			toplevelArea = [[Area alloc] initWithRect:rect];
		}
		else
		{
			NSLog(@"Creating toplevelArea only on main screen for now!");
		}
	}
}

@end
