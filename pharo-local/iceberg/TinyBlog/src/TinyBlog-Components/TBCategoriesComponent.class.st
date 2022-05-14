Class {
	#name : #TBCategoriesComponent,
	#superclass : #WAComponent,
	#instVars : [
		'categories',
		'postsList'
	],
	#category : #'TinyBlog-Components'
}

{ #category : #'as yet unclassified' }
TBCategoriesComponent class >> categories: categories postsList: aTBScreen [
	^ self new categories: categories; postsList: aTBScreen

]

{ #category : #accessing }
TBCategoriesComponent >> categories [
	^ categories

]

{ #category : #accessing }
TBCategoriesComponent >> categories: aCollection [
	categories := aCollection asSortedCollection

]

{ #category : #accessing }
TBCategoriesComponent >> postsList [
	^ postsList
]

{ #category : #accessing }
TBCategoriesComponent >> postsList: aComponent [
	postsList := aComponent
]

{ #category : #'as yet unclassified' }
TBCategoriesComponent >> renderCategoryLinkOn: html with: aCategory [
	html tbsLinkifyListGroupItem
	class: 'active' if: aCategory = self postsList currentCategory;
	callback: [ self selectCategory: aCategory ];
	with: aCategory

]

{ #category : #'as yet unclassified' }
TBCategoriesComponent >> renderContentOn: html [
	html tbsListGroup: [
		html tbsListGroupItem
		with: [ html strong: 'Categories' ].
		categories do: [ :cat | self renderCategoryLinkOn: html with: cat ]
	]

]

{ #category : #'as yet unclassified' }
TBCategoriesComponent >> selectCategory: aCategory [
	postsList currentCategory: aCategory
]
