Class {
	#name : #FQComplementQuery,
	#superclass : #FQAbstractQuery,
	#instVars : [
		'childQuery'
	],
	#category : #'Famix-Queries-Combinator'
}

{ #category : #'as yet unclassified' }
FQComplementQuery class >> forQuery: aQuery [
	^ self new
		childQuery: aQuery;
		yourself
]

{ #category : #accessing }
FQComplementQuery >> childQuery [
	^ childQuery
]

{ #category : #accessing }
FQComplementQuery >> childQuery: anObject [
	childQuery := anObject
]

{ #category : #running }
FQComplementQuery >> displayOn: aStream with: aString [
	aStream << aString << ' copyWithoutAll: ('.
	self childQuery displayOn: aStream.
	aStream << ')'
]

{ #category : #running }
FQComplementQuery >> runOn: aMooseGroup [
	"I should run myself on the MooseGroup as parameter and return a new MooseGroup with my result."

	^ MooseGroup
		withAll: (aMooseGroup copyWithoutAll: (self childQuery runOn: aMooseGroup))
]
