Class {
	#name : #FQStringQueryParametersPresenter,
	#superclass : #FQPropertyQueryParametersPresenter,
	#category : #'Famix-Queries-Browser-PropertyQuery-SubPresenters'
}

{ #category : #specs }
FQStringQueryParametersPresenter class >> defaultSpec [
	| padding |
	padding := 8.
	^ SpBoxLayout newVertical
		add: #properties
			expand: true
			fill: true
			padding: padding;
		add: #comparators
			expand: true
			fill: true
			padding: padding;
		add: #valueInput
			expand: true
			fill: true
			padding: padding;
		yourself
]

{ #category : #initialization }
FQStringQueryParametersPresenter class >> queryBuilderClass [
	^ FQStringPropertyQueryBuilder
]

{ #category : #initialization }
FQStringQueryParametersPresenter >> initializePresenters [
	super initializePresenters.
	comparators := self newDropList
		items: queryBuilder availableComparators;
		display: [ :prop | prop asString ];
		whenSelectedItemChangedDo: [ :prop | 
			queryBuilder changeQueryComparator: prop.
			self owner notifyQueryChanged ];
		selectIndex: 1;
		yourself.
	valueInput := self newTextInput
		placeholder: 'Your pattern';
		autoAccept: true;
		whenTextChangedDo: [ :pattern | 
			queryBuilder changeQueryValueToCompare: pattern.
			self owner notifyQueryChanged ];
		yourself
]
