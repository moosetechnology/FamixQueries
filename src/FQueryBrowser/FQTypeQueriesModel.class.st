Class {
	#name : #FQTypeQueriesModel,
	#superclass : #FQQueriesModel,
	#instVars : [
		'queriesDict',
		'stateDict'
	],
	#category : #'FQueryBrowser-Models'
}

{ #category : #accessing }
FQTypeQueriesModel class >> default [
	| defaultDict |
	defaultDict := Dictionary
		newFromPairs:
			{#packageType . 'Package' . #classType . 'Class' . #methodType.
			'Method'}.
	^ self new
		queriesDict: defaultDict;
		stateDict:
			(Dictionary
				newFromKeys: defaultDict keys
				andValues: (Array new: 3 withAll: true));
		yourself
]

{ #category : #'query creation' }
FQTypeQueriesModel >> createQuery [
	| keysToKeep queriesDisplays |
	keysToKeep := (self stateDict select: [ :state | state ]) keys.
	queriesDisplays := keysToKeep
		collect: [ :key | self queriesDict at: key ].
	^ queriesDisplays printString
	"^ String
		streamContents: [ :s | 
			keysToKeep
				do: [ :query | 
					s
						<< (queriesDict at: query);
						space ] ]"
]

{ #category : #accessing }
FQTypeQueriesModel >> queriesDict [
	^ queriesDict
]

{ #category : #accessing }
FQTypeQueriesModel >> queriesDict: anObject [
	queriesDict := anObject
]

{ #category : #accessing }
FQTypeQueriesModel >> stateDict [
	^ stateDict
]

{ #category : #accessing }
FQTypeQueriesModel >> stateDict: anObject [
	stateDict := anObject
]
