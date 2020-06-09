Class {
	#name : #FQRootQuery,
	#superclass : #FQUnaryQuery,
	#category : #'Famix-Queries-Queries-Unary'
}

{ #category : #display }
FQRootQuery class >> color [
	^ Color colorFrom: 'DDDDDD'
]

{ #category : #display }
FQRootQuery class >> label [
	^ 'Initial Entities'
]

{ #category : #adding }
FQRootQuery >> beChildOf: parentQuery [
	FQNoParentForRootQuery signal: 'Root query cannot have a parent'
]

{ #category : #default }
FQRootQuery >> beDefaultForParent [
	"Nothing to do"

	
]

{ #category : #printing }
FQRootQuery >> defaultName [
	^ 'Model'
]

{ #category : #printing }
FQRootQuery >> displayOn: aStream with: aString [
	aStream << aString
]

{ #category : #comparing }
FQRootQuery >> hasSameParametersAs: aQuery [
	"It can be too long to check 'self result sameElements: aQuery result' and not really needed for now."

	^ true
]

{ #category : #initialization }
FQRootQuery >> initialize [
	super initialize.
	result := MooseGroup new
]

{ #category : #testing }
FQRootQuery >> isRootQuery [
	^ true
]

{ #category : #testing }
FQRootQuery >> isValid [
	^ result isKindOf: MooseGroup
]

{ #category : #accessing }
FQRootQuery >> result: aMooseGroup [
	result := aMooseGroup
]

{ #category : #running }
FQRootQuery >> runOn: aMooseGroup [
	^ aMooseGroup
]

{ #category : #printing }
FQRootQuery >> storeOn: aStream [
	aStream << self className << ' new'
]
