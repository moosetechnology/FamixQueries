Class {
	#name : #FQPropertyQueryParametersPresenter,
	#superclass : #SpPresenter,
	#instVars : [
		'queryBuilder',
		'properties',
		'comparators',
		'valueInput'
	],
	#category : #'Famix-Queries-Browser-PropertyQuery-SubPresenters'
}

{ #category : #specs }
FQPropertyQueryParametersPresenter class >> defaultSpec [
	^ self subclassResponsibility
]

{ #category : #initialization }
FQPropertyQueryParametersPresenter class >> label [
	^ self queryBuilderClass queryClass label substrings first
]

{ #category : #initialization }
FQPropertyQueryParametersPresenter class >> queryBuilderClass [
	^ FQAbstractPropertyQueryBuilder
]

{ #category : #initialization }
FQPropertyQueryParametersPresenter >> initializePresenters [
	properties := self newDropList
		items: queryBuilder availableProperties;
		display: [ :prop | prop asString ];
		whenSelectedItemChangedDo: [ :prop | 
			queryBuilder changeQueryProperty: prop.
			self owner notifyQueryChanged ];
		yourself
]

{ #category : #'accessing model' }
FQPropertyQueryParametersPresenter >> setModelBeforeInitialization: aModel [
	queryBuilder := aModel
]
