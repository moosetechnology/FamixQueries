Class {
	#name : #FQPropertyQueryParametersPresenter,
	#superclass : #SpPresenter,
	#instVars : [
		'properties',
		'comparators',
		'valueInput'
	],
	#category : #'Famix-Queries-Browser-PropertyQuery-SubPresenters'
}

{ #category : #initialization }
FQPropertyQueryParametersPresenter >> initializePresenters [
	properties := self newDropList
		items: self query availableProperties;
		display: [ :prop | prop asString ];
		whenSelectedItemChangedDo: [ :prop | 
			self query property: prop.
			self owner notifyQueryChanged ];
		yourself
]

{ #category : #accessing }
FQPropertyQueryParametersPresenter >> query [
	^ owner query
]
