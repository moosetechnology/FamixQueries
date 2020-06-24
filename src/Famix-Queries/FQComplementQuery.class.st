Class {
	#name : #FQComplementQuery,
	#superclass : #FQUnaryQuery,
	#category : #'Famix-Queries-Queries-Unary'
}

{ #category : #accessing }
FQComplementQuery class >> label [
	^ 'Complement Query'
]

{ #category : #default }
FQComplementQuery >> beDefaultForParent [
	"Nothing to do"

	
]

{ #category : #printing }
FQComplementQuery >> defaultName [
	^ '(' , parent name , ') not'
]

{ #category : #printing }
FQComplementQuery >> displayOn: aStream with: aString [
	aStream << 'aMooseGroup copyWithoutAll: ' << aString
]

{ #category : #comparing }
FQComplementQuery >> hasSameParametersAs: aQuery [
	^ aQuery parent hasSameParametersAs: parent
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

{ #category : #printing }
FQComplementQuery >> storeOn: aStream [
	aStream << self className << ' new beChildOf: ('.
	parent storeOn: aStream.
	aStream << $)
]
