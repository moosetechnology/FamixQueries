Class {
	#name : #FQComplementQuery,
	#superclass : #FQUnaryQuery,
	#category : #'Famix-Queries-Queries-Unary'
}

{ #category : #accessing }
FQComplementQuery class >> label [
	^ 'Complement Query'
]

{ #category : #printing }
FQComplementQuery >> defaultName [
	^ '(' , parent name , ') not'
]

{ #category : #running }
FQComplementQuery >> displayOn: aStream with: aString [
	aStream << aString << ' copyWithoutAll: ('.
	self parent ifNotNil: [ self parent displayOn: aStream ].
	aStream << ')'
]

{ #category : #comparing }
FQComplementQuery >> hasSameParametersAs: aQuery [
	^ aQuery parent = parent
]

{ #category : #testing }
FQComplementQuery >> isValid [
	^ parent isNotNil and: [ parent isValid ]
]

{ #category : #running }
FQComplementQuery >> runOn: aMooseGroup [
	^ MooseGroup
		withAll: (aMooseGroup copyWithoutAll: (parent runOn: aMooseGroup))
]
