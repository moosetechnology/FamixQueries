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
				state: true;
				yourself ];
		layoutBuilder:
			(SpDynamicLeftToRightRowsLayout
				rows: (queryBuilder availableTypes size // 3 max: 1));
		build
]
