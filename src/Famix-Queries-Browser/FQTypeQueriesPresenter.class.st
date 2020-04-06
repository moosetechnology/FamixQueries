Class {
	#name : #FQTypeQueriesPresenter,
	#superclass : #FQQueryConfigurationPresenter,
	#instVars : [
		'types'
	],
	#category : #'Famix-Queries-Browser-Presenters'
}

{ #category : #specs }
FQTypeQueriesPresenter class >> defaultSpec [
	^ SpBoxLayout newHorizontal
		add: #types;
		add: self creationButton;
		spacing: 5;
		yourself
]

{ #category : #'instance creation' }
FQTypeQueriesPresenter class >> open [
	<script>
	(self
		on:
			(FQQueryBuilder default
				buildTypeQuery;
				yourself)) openWithSpec
]

{ #category : #specs }
FQTypeQueriesPresenter class >> title [
	^ 'Type Query'
]

{ #category : #initialization }
FQTypeQueriesPresenter >> initializeBuilder [
	queryBuilder buildTypeQuery
]

{ #category : #initialization }
FQTypeQueriesPresenter >> initializePresenters [
	super initializePresenters.
	self instanciateTypeCheckBoxes
]

{ #category : #initialization }
FQTypeQueriesPresenter >> instanciateTypeCheckBoxes [
	types := SpDynamicPresentersListBuilder new
		modelObjects: queryBuilder availableTypes;
		presenter: SpCheckBoxPresenter
			configuredAs: [ :presenter :type | 
			presenter
				label: (type name withoutPrefix: self modelPrefix);
				whenActivatedDo: [ queryBuilder addTypeToQuery: type ];
				whenDeactivatedDo: [ queryBuilder removeTypeFromQuery: type ];
				state: false;
				yourself ];
		layoutBuilder:
			(SpDynamicLeftToRightColumnsLayout
				columns: (queryBuilder availableTypes size // 2 + 1 min: 6));
		"min: 6 to avoid more than 6 checkboxes / column"
			build.
			
	self flag: 'To change when aType Query can have several types'.
	types presenters first toggleState
]
