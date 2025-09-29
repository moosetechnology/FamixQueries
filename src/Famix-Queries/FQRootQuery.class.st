Class {
	#name : 'FQRootQuery',
	#superclass : 'FQUnaryQuery',
	#instVars : [
		'input'
	],
	#category : 'Famix-Queries-Queries-Unary',
	#package : 'Famix-Queries',
	#tag : 'Queries-Unary'
}

{ #category : 'display' }
FQRootQuery class >> color [
	^ Color colorFrom: 'DDDDDD'
]

{ #category : 'display' }
FQRootQuery class >> label [
	^ 'Initial Entities'
]

{ #category : 'adding' }
FQRootQuery >> beChildOf: parentQuery [
	FQNoParentForRootQuery signal: 'Root query cannot have a parent'
]

{ #category : 'default' }
FQRootQuery >> beDefaultForParent [
	"Nothing to do"

	
]

{ #category : 'printing' }
FQRootQuery >> defaultName [
	^ 'Model'
]

{ #category : 'printing' }
FQRootQuery >> displayOn: aStream with: aString [
	aStream << aString
]

{ #category : 'comparing' }
FQRootQuery >> hasSameParametersAs: aQuery [
	"It can be too long to check 'self result sameElements: aQuery result' and not really needed for now."

	^ true
]

{ #category : 'initialization' }
FQRootQuery >> initialize [

	super initialize.
	input := MooseGroup new
]

{ #category : 'accessing' }
FQRootQuery >> input: aMooseGroup [

	input := aMooseGroup
]

{ #category : 'testing' }
FQRootQuery >> isRootQuery [
	^ true
]

{ #category : 'testing' }
FQRootQuery >> isValid [

	^ input isKindOf: MooseGroup
]

{ #category : 'running' }
FQRootQuery >> rawRunOn: aMooseGroup [
	^ aMooseGroup
]

{ #category : 'running' }
FQRootQuery >> result [

	^ input
]

{ #category : 'accessing' }
FQRootQuery >> result: aMooseGroup [

	self
		deprecated: 'Unclear method name'
		transformWith:
		'`@receiver result: `@arg' -> '`@receiver input: `@arg'.
	self input: aMooseGroup
]

{ #category : 'printing' }
FQRootQuery >> storeOn: aStream [
	aStream << self className << ' new'
]
