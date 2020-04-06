Class {
	#name : #FQPropertyQueryConfigurationPresenter,
	#superclass : #SpPresenter,
	#instVars : [
		'queryBuilder',
		'properties'
	],
	#category : #'Famix-Queries-Browser-PropertyQueryConfigurationPresenters'
}

{ #category : #initialization }
FQPropertyQueryConfigurationPresenter >> initializePresenters [
	super initializePresenters.
	properties := self newDropList
		items: queryBuilder availableProperties;
		display: [ :prop | prop asString ];
		whenSelectedItemChangedDo: [ :prop | queryBuilder query property: prop ];
		selectIndex: 1;
		yourself
]

{ #category : #'accessing model' }
FQPropertyQueryConfigurationPresenter >> setModelBeforeInitialization: aModel [
	queryBuilder := aModel
]
