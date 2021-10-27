"
I am a null query that does not do anything. I am only here for avoid checking nils
"
Class {
	#name : #FQNullQuery,
	#superclass : #FQAbstractQuery,
	#category : #'Famix-Queries-Core'
}

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
FQNullQuery >> hasSameParametersAs: arg1 [

	^ false
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
FQNullQuery >> runOn: aMooseGroup [

	^ #(  ) asMooseGroup
]

{ #category : #printing }
FQNullQuery >> storeOn: aStream [

	aStream << 'Null Query'
]

{ #category : #printing }
FQNullQuery >> storeWithParentsOn: aStream [

	aStream << 'Null Query'
]
