Class {
	#name : #FQPropertyQueryParametersPresenter,
	#superclass : #SpPresenter,
	#instVars : [
		'queryBuilder',
		'properties'
	],
	#category : #'Famix-Queries-Browser-PropertyQueryParametersPresenters'
}

{ #category : #initialization }
FQPropertyQueryParametersPresenter >> initializePresenters [
	super initializePresenters.
	properties := self newDropList
		items: queryBuilder availableProperties;
		display: [ :prop | prop asString ];
		whenSelectedItemChangedDo: [ :prop | queryBuilder changeQueryProperty: prop ];
		selectIndex: 1;
		yourself.
	properties listItems
		ifEmpty: [ self owner button disable ]
		ifNotEmpty: [ self owner button enable ]
]

{ #category : #'accessing model' }
FQPropertyQueryParametersPresenter >> setModelBeforeInitialization: aModel [
	queryBuilder := aModel
]