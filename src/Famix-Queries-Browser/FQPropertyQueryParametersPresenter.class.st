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
FQPropertyQueryParametersPresenter class >> queryBuilderClass [
	^ self subclassResponsibility
]

{ #category : #accessing }
FQPropertyQueryParametersPresenter class >> queryClass [
	^ self subclassResponsibility
]

{ #category : #initialization }
FQPropertyQueryParametersPresenter >> initializePresenters [
	super initializePresenters.
	properties := self newDropList
		items: queryBuilder availableProperties;
		display: [ :prop | prop asString ];
		whenSelectedItemChangedDo: [ :prop | 
			queryBuilder changeQueryProperty: prop.
			self owner notifyQueryChanged ];
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
