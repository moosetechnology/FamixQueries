Class {
	#name : #FQNumericQueryParametersPresenter,
	#superclass : #FQPropertyQueryParametersPresenter,
	#category : #'Famix-Queries-Browser-PropertyQuery-SubPresenters'
}

{ #category : #specs }
FQNumericQueryParametersPresenter class >> defaultSpec [
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
FQNumericQueryParametersPresenter class >> queryBuilderClass [
	^ FQNumericPropertyQueryBuilder 
]

{ #category : #initialization }
FQNumericQueryParametersPresenter >> initializePresenters [
	super initializePresenters.
	comparators := self newDropList
		items: queryBuilder availableComparators;
		display: [ :prop | prop asString ];
		whenSelectedItemChangedDo: [ :prop | 
			queryBuilder changeQueryComparator: prop.
			self owner notifyQueryChanged ];
		selectIndex: 1;
		yourself.
	valueInput := self newNumberInput
		placeholder: 'Your numeric value';
		climbRate: 1;
		minimum: 0;
		autoAccept: true;
		whenNumberChangedDo: [ :num | 
			queryBuilder changeQueryValueToCompare: num.
			self owner notifyQueryChanged ];
		yourself
]
