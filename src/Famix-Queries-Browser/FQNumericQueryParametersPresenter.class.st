Class {
	#name : #FQNumericQueryParametersPresenter,
	#superclass : #FQPropertyQueryParametersPresenter,
	#instVars : [
		'comparators',
		'valueInput'
	],
	#category : #'Famix-Queries-Browser-PropertyQueryParametersPresenters'
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

{ #category : #'instance creation' }
FQNumericQueryParametersPresenter class >> open [
	<script>
	^ self basicNew
		setModelBeforeInitialization:
			(FQQueryBuilder default
				buildPropertyQuery: FQNumericQuery;
				yourself);
		initialize;
		openWithSpec
]

{ #category : #initialization }
FQNumericQueryParametersPresenter class >> queryBuilderClass [
	^ FQNumericPropertyQueryBuilder 
]

{ #category : #accessing }
FQNumericQueryParametersPresenter class >> queryClass [
	^ FQNumericQuery
]

{ #category : #initialization }
FQNumericQueryParametersPresenter >> initializePresenters [
	super initializePresenters.
	comparators := self newDropList
		items: queryBuilder availableComparators;
		display: [ :prop | prop asString ];
		whenSelectedItemChangedDo: [ :prop | queryBuilder changeQueryComparator: prop ];
		selectIndex: 1;
		yourself.
	valueInput := self newNumberInput
		placeholder: 'Your numeric value';
		climbRate: 1;
		minimum: 0;
		autoAccept: true;
		whenNumberChangedDo: [ :num | queryBuilder changeQueryValueToCompare: num ];
		yourself
]
