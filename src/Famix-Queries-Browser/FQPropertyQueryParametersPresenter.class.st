Class {
	#name : #FQPropertyQueryParametersPresenter,
	#superclass : #SpPresenter,
	#instVars : [
		'properties',
		'comparators',
		'valueInput',
		'query'
	],
	#category : #'Famix-Queries-Browser-PropertyQuery-SubPresenters'
}

{ #category : #specs }
FQPropertyQueryParametersPresenter class >> defaultSpec [
	^ self subclassResponsibility
]

{ #category : #initialization }
FQPropertyQueryParametersPresenter >> initializePresenters [
	properties := self newDropList
		items: query availableProperties;
		display: [ :prop | prop asString ];
		whenSelectedItemChangedDo: [ :prop | 
			query property: prop.
			self owner notifyQueryChanged ];
		yourself
]

{ #category : #'accessing model' }
FQPropertyQueryParametersPresenter >> setModelBeforeInitialization: aQuery [
	query := aQuery
]
