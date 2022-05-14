Class {
	#name : #TBPostsReport,
	#superclass : #TBSMagritteReport,
	#instVars : [
		'blog'
	],
	#classInstVars : [
		'blog'
	],
	#category : #'TinyBlog-Components'
}

{ #category : #'as yet unclassified' }
TBPostsReport class >> filteredDescriptionsFrom: aBlogPost [
"Filter only some descriptions for the report columns."
	^ aBlogPost magritteDescription
		select: [ :each | #(title category date) includes: each accessor selector ]

]

{ #category : #'as yet unclassified' }
TBPostsReport class >> from: aBlog [
	| report blogPosts |
	blogPosts := aBlog allBlogPosts.
	report := self rows: blogPosts description: (self filteredDescriptionsFrom: blogPosts anyOne).
	report blog: aBlog.
	report addColumn: 
		(MACommandColumn new
			addCommandOn: report
			selector: #viewPost:
			text: 'View';
			yourself;
			addCommandOn: report
			selector: #editPost:
			text: 'Edit';
			yourself;
			addCommandOn: report
			selector: #deletePost:
			text: 'Delete';
			yourself
		).
	^ report

]

{ #category : #'as yet unclassified' }
TBPostsReport >> addPost [
	| post |
	post := self call: (self renderAddPostForm: TBPost new).
	post
	ifNotNil: [ blog writeBlogPost: post. self refreshReport ]

]

{ #category : #accessing }
TBPostsReport >> blog [
	^ blog

]

{ #category : #accessing }
TBPostsReport >> blog: aTBBlog [
	blog := aTBBlog

]

{ #category : #'as yet unclassified' }
TBPostsReport >> deletePost: aPost [
	(self confirm: 'Do you want remove this post ?')
	ifTrue: [ blog removeBlogPost: aPost. self refreshReport ]

]

{ #category : #rendering }
TBPostsReport >> editPost: aPost [
	| post |
	post := self call: (self renderEditPostForm: aPost).
	post ifNotNil: [ blog save ]

]

{ #category : #'as yet unclassified' }
TBPostsReport >> refreshReport [
	self rows: blog allBlogPosts.
	self refresh.

]

{ #category : #rendering }
TBPostsReport >> renderAddPostForm: aPost [
	^ aPost asComponent
	addDecoration: (TBSMagritteFormDecoration buttons: { #save -> 'Add post' . #cancel -> 'Cancel'});
	yourself

]

{ #category : #rendering }
TBPostsReport >> renderContentOn: html [
	html tbsGlyphIcon iconPencil.
	html anchor
	callback: [ self addPost ];
	with: 'Add post'.
	super renderContentOn: html

]

{ #category : #rendering }
TBPostsReport >> renderEditPostForm: aPost [
	^ aPost asComponent addDecoration: (
		TBSMagritteFormDecoration buttons: {
			#save -> 'Save post'. #cancel -> 'Cancel'
		}
	);
	yourself

]

{ #category : #rendering }
TBPostsReport >> renderViewPostForm: aPost [
	^ aPost asComponent
	addDecoration: (TBSMagritteFormDecoration buttons: { #cancel -> 'Back' });
	readonly: true;
	yourself

]

{ #category : #rendering }
TBPostsReport >> viewPost: aPost [
	self call: (self renderViewPostForm: aPost)

]
