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
FQNumericQueryParametersPresenter >> initializePresenters [
	super initializePresenters.
	comparators := self newDropList
		items: self query class comparators;
		display: [ :prop | prop asString ];
		whenSelectedItemChangedDo: [ :prop | 
			self query comparator: prop.
			self owner notifyQueryChanged ];
		yourself.
	valueInput := self newNumberInput
		placeholder: 'Your numeric value';
		climbRate: 1;
		minimum: 0;
		autoAccept: true;
		whenNumberChangedDo: [ :num | 
			self query valueToCompare: num.
			self owner notifyQueryChanged ];
		yourself
]
