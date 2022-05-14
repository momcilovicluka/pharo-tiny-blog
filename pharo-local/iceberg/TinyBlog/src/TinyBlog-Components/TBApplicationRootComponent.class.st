Class {
	#name : #TBApplicationRootComponent,
	#superclass : #WAComponent,
	#instVars : [
		'main'
	],
	#category : #'TinyBlog-Components'
}

{ #category : #'class initialization' }
TBApplicationRootComponent class >> canBeRoot [
	^ true
]

{ #category : #'class initialization' }
TBApplicationRootComponent class >> initialize [
	"self initialize"
	| app |
	app := WAAdmin register: self asApplicationAt: 'TinyBlog'.
	app
	preferenceAt: #sessionClass put: TBSession.
	app
	addLibrary: JQDeploymentLibrary;
 	addLibrary: JQUiDeploymentLibrary;
	addLibrary: TBSDeploymentLibrary

]

{ #category : #rendering }
TBApplicationRootComponent >> children [
	^ { main }
]

{ #category : #rendering }
TBApplicationRootComponent >> initialize [
	super initialize.
	main := TBPostsListComponent new

]

{ #category : #rendering }
TBApplicationRootComponent >> main: aComponent [
	main := aComponent

]

{ #category : #rendering }
TBApplicationRootComponent >> renderContentOn: html [
	html render: main
]

{ #category : #rendering }
TBApplicationRootComponent >> updateRoot: anHtmlRoot [
	super updateRoot: anHtmlRoot.
	anHtmlRoot beHtml5.
	anHtmlRoot title: 'TinyBlog'

]
