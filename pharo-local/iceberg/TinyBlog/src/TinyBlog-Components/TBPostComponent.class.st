Class {
	#name : #TBPostComponent,
	#superclass : #WAComponent,
	#instVars : [
		'post'
	],
	#category : #'TinyBlog-Components'
}

{ #category : #initialization }
TBPostComponent >> date [
	^ post date

]

{ #category : #initialization }
TBPostComponent >> initialize [
	super initialize.
	post := TBPost new
]

{ #category : #initialization }
TBPostComponent >> post: aPost [
	post := aPost

]

{ #category : #initialization }
TBPostComponent >> renderContentOn: html [
	html heading level: 2; with: self title.
	html heading level: 6; with: self date.
	html text: self text

]

{ #category : #initialization }
TBPostComponent >> text [
	^ post text

]

{ #category : #initialization }
TBPostComponent >> title [
	^ post title
]
