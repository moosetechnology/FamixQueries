Class {
	#name : #FQScriptQuery,
	#superclass : #FQUnaryQuery,
	#instVars : [
		'script'
	],
	#category : #'Famix-Queries-Queries-Unary'
}

{ #category : #accessing }
FQScriptQuery class >> label [
	^ 'Manual query'
]

{ #category : #accessing }
FQScriptQuery class >> script: aBlock [
	^ self new
		script: aBlock;
		yourself
]

{ #category : #comparing }
FQScriptQuery >> = anObject [
	"Answer whether the receiver and anObject represent the same object."

	^ super = anObject and: [
		  script compiledBlock = anObject script compiledBlock ]
]

{ #category : #printing }
FQScriptQuery >> displayOn: aStream with: aString [

	^ aStream << aString << Character space << self name
]

{ #category : #comparing }
FQScriptQuery >> hasSameParametersAs: aQuery [
	^ script asString = aQuery script asString
]

{ #category : #comparing }
FQScriptQuery >> hash [
	"Answer an integer value that is related to the identity of the receiver."

	^ super hash bitXor: script hash
]

{ #category : #testing }
FQScriptQuery >> isScriptQuery [

	^ true
]

{ #category : #testing }
FQScriptQuery >> isValid [
	^script notNil
]

{ #category : #accessing }
FQScriptQuery >> script [

	^ script
]

{ #category : #accessing }
FQScriptQuery >> script: anObject [

	script := anObject
]

{ #category : #printing }
FQScriptQuery >> storeOn: aStream [

	aStream << self className << ' script: ' <<
	(self isValid ifTrue: [ script asString ] ifFalse: [ '[:entity | ]' ])
]
