Class {
	#name : #FQNavigationQueriesModel,
	#superclass : #FQQueriesModel,
	#instVars : [
		'queriesDict',
		'stateDict',
		'directions',
		'direction'
	],
	#category : #'FQueryBrowser-Models'
}

{ #category : #accessing }
FQNavigationQueriesModel class >> default [
	| defaultDict |
	defaultDict := Dictionary
		newFromPairs:
			{#access . 'Access' . #invocation . 'Invocation' . #reference.
			'Reference' . #inheritance . 'Inheritance'}.
	^ self new
		queriesDict: defaultDict;
		stateDict:
			(Dictionary
				newFromKeys: defaultDict keys
				andValues: (Array new: 4 withAll: true));
		yourself
]

{ #category : #'query creation' }
FQNavigationQueriesModel >> createQuery [
	| keysToKeep queriesDisplays |
	keysToKeep := (self stateDict select: [ :state | state ]) keys.
	queriesDisplays := {self direction}
		, (keysToKeep collect: [ :key | self queriesDict at: key ]).
	^ queriesDisplays printString
]

{ #category : #accessing }
FQNavigationQueriesModel >> direction [
	^ direction
]

{ #category : #accessing }
FQNavigationQueriesModel >> direction: anObject [
	direction := anObject
]

{ #category : #initialization }
FQNavigationQueriesModel >> initialize [
	super initialize.
	self direction: #incoming
]

{ #category : #accessing }
FQNavigationQueriesModel >> queriesDict [
	^ queriesDict
]

{ #category : #accessing }
FQNavigationQueriesModel >> queriesDict: anObject [
	queriesDict := anObject
]

{ #category : #accessing }
FQNavigationQueriesModel >> stateDict [
	^ stateDict
]

{ #category : #accessing }
FQNavigationQueriesModel >> stateDict: anObject [
	stateDict := anObject
]
