"
I am a query that can be applied on a MooseGroup.

----- Query -----
I compute all entities that are tagged by a given tag

----- Parameters -----
I have the name of the tag to look for

----- API -----

•	Running : see FQAbstractQuery comment
•	Printing : see FQAbstractQuery comment
•	Changing name:


Use #tagName: with a string as argument.

•	Comparing:


Two type queries are equal if their tag names are the same.

•	Available parameters:


Available relations depend on the moose model of the input MooseGroup.

----- Validity -----
I am valid if I have a tag name.

----- Instance Creation -----

•	Class method #tagName: takes a string as argument.
•	Simplified creation API:


'FQRelationQuery tagName: aString'
"
Class {
	#name : #FQTaggedEntityQuery,
	#superclass : #FQUnaryQuery,
	#instVars : [
		'tagName'
	],
	#category : #'Famix-Queries-Queries-Unary'
}

{ #category : #accessing }
FQTaggedEntityQuery class >> label [
	^ 'Tag Query'
]

{ #category : #'instance creation' }
FQTaggedEntityQuery class >> tagNamed: aTagName [

	^ self new
		  tagName: aTagName;
		  yourself
]

{ #category : #'available parameters' }
FQTaggedEntityQuery >> availableTagNames [

	^ parent
		ifNil: [ {  } ]
		ifNotNil: [ 
		  (self availableTagNamesFor: parent result) sorted ]
]

{ #category : #'available parameters' }
FQTaggedEntityQuery >> availableTagNamesFor: aMooseGroup [

	aMooseGroup ifEmpty: [ ^ {  } ].
	^ aMooseGroup anyOne mooseModel allTags collect: #name
]

{ #category : #default }
FQTaggedEntityQuery >> beDefaultForParent [

	self tagName: (self availableTagNames
			 ifEmpty: [ nil ]
			 ifNotEmpty: [ :tagNames | tagNames anyOne ])
]

{ #category : #printing }
FQTaggedEntityQuery >> defaultName [

	^ 'tag named: #' , self tagName
]

{ #category : #printing }
FQTaggedEntityQuery >> displayOn: aStream with: aString [

	aStream << '(MooseObjectQueryResult withAll: ' << aString
	<< ') tagNamed: '.
	self tagName storeOn: aStream
]

{ #category : #comparing }
FQTaggedEntityQuery >> hasSameParametersAs: aQuery [
	^ aQuery tagName = self tagName
]

{ #category : #testing }
FQTaggedEntityQuery >> isValid [
	^ tagName isNotNil
]

{ #category : #running }
FQTaggedEntityQuery >> rawRunOn: aMooseGroup [

	^ aMooseGroup select: [ :entity | entity allTagAssociations anySatisfy: [ :tass | tass tag name = tagName ] ]
]

{ #category : #printing }
FQTaggedEntityQuery >> storeOn: aStream [

	aStream << self className << ' tagNamed: '.
	self tagName storeOn: aStream
]

{ #category : #accessing }
FQTaggedEntityQuery >> tagName [
	^tagName
]

{ #category : #accessing }
FQTaggedEntityQuery >> tagName: aTagName [
	tagName := aTagName.
	self resetResult
]
