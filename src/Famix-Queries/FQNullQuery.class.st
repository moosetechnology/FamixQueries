"
I am a null query that does not do anything. I am only here for avoid checking nils
"
Class {
	#name : #FQNullQuery,
	#superclass : #FQAbstractQuery,
	#category : #'Famix-Queries-Core'
}

{ #category : #comparing }
FQNullQuery >> = anObject [
	"Answer whether the receiver and anObject represent the same object."

	self == anObject ifTrue: [ ^ true ].
	self class = anObject class ifFalse: [ ^ false ].
	^ true
]

{ #category : #printing }
FQNullQuery >> buildDefaultName [

	^ self defaultName
]

{ #category : #running }
FQNullQuery >> computeResult [

	^ #() asMooseGroup
]

{ #category : #printing }
FQNullQuery >> defaultName [

	^ 'Null Query'
]

{ #category : #printing }
FQNullQuery >> displayOn: aStream [

	aStream << 'Null Query'
]

{ #category : #accessing }
FQNullQuery >> hasSameParametersAs: aQuery [

	^ self class == aQuery class
]

{ #category : #comparing }
FQNullQuery >> hash [

	^ self name hash
]

{ #category : #testing }
FQNullQuery >> isValid [

	^ false
]

{ #category : #accessing }
FQNullQuery >> parentSequence [

	^ #(  )
]

{ #category : #removing }
FQNullQuery >> prepareRemoval [
]

{ #category : #running }
FQNullQuery >> rawRunOn: aMooseGroup [

	^ #(  )
]

{ #category : #printing }
FQNullQuery >> storeOn: aStream [

	aStream << 'Null Query'
]

{ #category : #printing }
FQNullQuery >> storeWithParentsOn: aStream [

	aStream << 'Null Query'
]
