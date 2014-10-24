/*******************************************************************************
 * Copyright (c) Microsoft Open Technologies, Inc.
 * All Rights Reserved
 * See License.txt in the project root for license information.
 ******************************************************************************/

#import "MSOODataEntityFetcher.h"
#import "MSOAttachmentOperations.h"
#import "MSOAttachment.h"

#import "MSOFileAttachmentFetcher.h"	
#import "MSOItemAttachmentFetcher.h"	
/**
* The header for type MSOAttachmentFetcher.
*/

@protocol MSOAttachmentFetcher

@optional
-(NSURLSessionDataTask *)execute:(void (^)(MSOAttachment* attachment, NSError *error))callback;
-(NSURLSessionDataTask*) update:(id)updatedEntity :(void (^)(MSOAttachment*, NSError * error))callback;
@end

@interface MSOAttachmentFetcher : MSOODataEntityFetcher<MSOAttachmentFetcher>

-(MSOAttachmentOperations*) getOperations;
		
-(MSOFileAttachmentFetcher*) asFileAttachment;	
		
-(MSOItemAttachmentFetcher*) asItemAttachment;	
	
@end