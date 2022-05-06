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

{ #category : #printing }
FQScriptQuery >> displayOn: aStream with: aString [
	^ aStream << aString << Character space << self defaultName
]

{ #category : #comparing }
FQScriptQuery >> hasSameParametersAs: aQuery [
	^ script asString = aQuery script asString
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
