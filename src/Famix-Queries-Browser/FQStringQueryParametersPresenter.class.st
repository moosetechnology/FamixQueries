Class {
	#name : #FQStringQueryParametersPresenter,
	#superclass : #FQPropertyQueryParametersPresenter,
	#instVars : [
		'comparators',
		'valueInput'
	],
	#category : #'Famix-Queries-Browser-PropertyQueryParametersPresenters'
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

{ #category : #'instance creation' }
FQStringQueryParametersPresenter class >> open [
	<script>
	^ self basicNew
		setModelBeforeInitialization:
			(FQQueryBuilder default
				buildPropertyQueryTyped: #string;
				yourself);
		initialize;
		openWithSpec
]

{ #category : #initialization }
FQStringQueryParametersPresenter >> initializePresenters [
	super initializePresenters.
	comparators := self newDropList
		items: queryBuilder query availableComparators;
		display: [ :prop | prop asString ];
		whenSelectedItemChangedDo: [ :prop | queryBuilder changeQueryComparator: prop ];
		selectIndex: 1;
		yourself.
	valueInput := self newNumberInput
		placeholder: 'Your pattern';
		autoAccept: true;
		whenTextChangedDo: [ :pattern | queryBuilder changeQueryValueToCompare: pattern ];
		yourself
]
