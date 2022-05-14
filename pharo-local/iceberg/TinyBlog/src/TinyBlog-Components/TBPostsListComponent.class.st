Class {
	#name : #TBPostsListComponent,
	#superclass : #TBScreenComponent,
	#instVars : [
		'postComponents',
		'currentCategory',
		'showLoginError'
	],
	#category : #'TinyBlog-Components'
}

{ #category : #initialization }
TBPostsListComponent >> basicRenderCategoriesOn: html [
	html render: self categoriesComponent

]

{ #category : #initialization }
TBPostsListComponent >> basicRenderPostsOn: html [
	self readSelectedPosts do: [ :p | html render: (self postComponentFor: p) ]

]

{ #category : #'as yet unclassified' }
TBPostsListComponent >> categoriesComponent [
	^ TBCategoriesComponent
	categories: self blog allCategories
	postsList: self

]

{ #category : #initialization }
TBPostsListComponent >> children [
	^ self postComponents, super children

]

{ #category : #accessing }
TBPostsListComponent >> currentCategory [
	^ currentCategory

]

{ #category : #accessing }
TBPostsListComponent >> currentCategory: anObject [
	currentCategory := anObject
]

{ #category : #'as yet unclassified' }
TBPostsListComponent >> goToAdministrationView [
	self call: TBAdminComponent new

]

{ #category : #'as yet unclassified' }
TBPostsListComponent >> hasLoginError [
	^ showLoginError ifNil: [ false ]

]

{ #category : #initialization }
TBPostsListComponent >> initialize [
	super initialize.
	postComponents := OrderedCollection new
]

{ #category : #'as yet unclassified' }
TBPostsListComponent >> loginErrorMessage [
	^ 'Incorrect login and/or password'

]

{ #category : #'as yet unclassified' }
TBPostsListComponent >> loginErrorOccurred [
	showLoginError := true

]

{ #category : #'as yet unclassified' }
TBPostsListComponent >> postComponentFor: aPost [
	^ TBPostComponent new post: aPost
]

{ #category : #initialization }
TBPostsListComponent >> postComponents [
	postComponents := self readSelectedPosts collect: [ :each | TBPostComponent new post: each ].
	^ postComponents

]

{ #category : #initialization }
TBPostsListComponent >> readSelectedPosts [
	^ self currentCategory
	ifNil: [ self blog allVisibleBlogPosts ]
	ifNotNil: [ self blog allVisibleBlogPostsFromCategory: self currentCategory ]

]

{ #category : #initialization }
TBPostsListComponent >> renderCategoryColumnOn: html [
	html tbsColumn
	extraSmallSize: 12;
	smallSize: 2;
	mediumSize: 4;
	with: [ self basicRenderCategoriesOn: html ]

]

{ #category : #initialization }
TBPostsListComponent >> renderContentOn: html [
	super renderContentOn: html.
	html tbsContainer: [
		html tbsRow showGrid;
		with: [ self renderCategoryColumnOn: html. self renderPostColumnOn: html ]
	]

]

{ #category : #initialization }
TBPostsListComponent >> renderLoginErrorMessageIfAnyOn: html [
	self hasLoginError ifTrue: [
		showLoginError := false.
		html tbsAlert
		beDanger ;
		with: self loginErrorMessage
	]

]

{ #category : #initialization }
TBPostsListComponent >> renderPostColumnOn: html [
	html tbsColumn
	extraSmallSize: 12;
	smallSize: 10;
	mediumSize: 8;
	with: [
		self renderLoginErrorMessageIfAnyOn: html.
		self basicRenderPostsOn: html
	]
]

{ #category : #'as yet unclassified' }
TBPostsListComponent >> tryConnectionWithLogin: login andPassword: password [
(login = self blog administrator login and: [ (SHA256 hashMessage: password) = self blog administrator password ])
ifTrue: [ self session currentAdmin: self blog administrator. self goToAdministrationView ]
ifFalse: [ self loginErrorOccurred ]
]
