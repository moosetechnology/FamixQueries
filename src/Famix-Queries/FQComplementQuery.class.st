Class {
	#name : #FQComplementQuery,
	#superclass : #FQUnaryQuery,
	#category : #'Famix-Queries-Queries-Unary'
}

{ #category : #'as yet unclassified' }
FQComplementQuery class >> forQuery: aQuery [
	^ self new
		parent: aQuery;
		yourself
]

{ #category : #comparing }
FQComplementQuery >> = aQuery [
	^ aQuery class == self class and: [ aQuery parent = parent ]
]

{ #category : #running }
FQComplementQuery >> displayOn: aStream with: aString [
	aStream << aString << ' copyWithoutAll: ('.
	self parent displayOn: aStream.
	aStream << ')'
]

{ #category : #testing }
FQComplementQuery >> isValid [
	^ parent isValid
]

{ #category : #running }
FQComplementQuery >> runOn: aMooseGroup [
	^ MooseGroup
		withAll: (aMooseGroup copyWithoutAll: (parent runOn: aMooseGroup))
]
