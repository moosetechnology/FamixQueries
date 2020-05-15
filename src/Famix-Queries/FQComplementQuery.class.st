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

{ #category : #running }
FQComplementQuery >> displayOn: aStream with: aString [
	aStream << aString << ' copyWithoutAll: ('.
	self parent displayOn: aStream.
	aStream << ')'
]

{ #category : #comparing }
FQComplementQuery >> hasSameParametersAs: aQuery [
	^ aQuery parent = parent
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
