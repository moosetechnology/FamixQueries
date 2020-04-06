Class {
	#name : #FQNumericQueryConfigurationPresenter,
	#superclass : #FQPropertyQueryConfigurationPresenter,
	#instVars : [
		'comparators',
		'valueInput'
	],
	#category : #'Famix-Queries-Browser-PropertyQueryConfigurationPresenters'
}

{ #category : #specs }
FQNumericQueryConfigurationPresenter class >> defaultSpec [
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
FQNumericQueryConfigurationPresenter class >> open [
	<script>
	^ self basicNew
		setModelBeforeInitialization:
			(FQQueryBuilder default
				buildPropertyQueryTyped: #number;
				yourself);
		initialize;
		openWithSpec
]

{ #category : #initialization }
FQNumericQueryConfigurationPresenter >> initializePresenters [
	super initializePresenters.
	comparators := self newDropList
		items: queryBuilder query availableComparators;
		display: [ :prop | prop asString ];
		whenSelectedItemChangedDo: [ :prop | queryBuilder query comparator: prop ];
		selectIndex: 1;
		yourself.
	valueInput := self newNumberInput
		placeholder: 'Your numeric value';
		climbRate: 1;
		minimum: 0;
		autoAccept: true;
		whenNumberChangedDo: [ :num | queryBuilder query valueToCompare: num ];
		yourself
]
