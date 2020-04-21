Class {
	#name : #FQQueriesBrowserPresenter,
	#superclass : #SpPresenter,
	#instVars : [
		'initialEntitiesButton',
		'queriesTree',
		'queryResult',
		'entities',
		'newQueryButton',
		'queriesCombinator'
	],
	#category : #'Famix-Queries-Browser-Presenters'
}

{ #category : #entities }
FQQueriesBrowserPresenter class >> classesAndMethods [
	| model |
	model := self modelExample.
	^ MooseGroup
		withAll:
			{model allModelClasses.
			model allModelMethods} flatten
]

{ #category : #'instance creation' }
FQQueriesBrowserPresenter class >> default [
	^ self basicNew
		entities: self classesAndMethods;
		initialize;
		yourself
]

{ #category : #specs }
FQQueriesBrowserPresenter class >> defaultSpec [
	^ SpPanedLayout newHorizontal
		add:
			(SpBoxLayout newVertical
				add: #initialEntitiesButton height: self buttonHeight;
				add: #queriesTree;
				add: #newQueryButton;
				yourself);
		add: #queryResult;
		yourself
]

{ #category : #entities }
FQQueriesBrowserPresenter class >> modelExample [
	| model |
	model := FamixStModel new.
	MoosePharoImporterTask new
		importerClass: SmalltalkImporter;
		model: model;
		addFromPackageNamed: #'Moose-TestResources-LAN';
		run.
	^ model
]

{ #category : #'instance creation' }
FQQueriesBrowserPresenter class >> open [
	<script>
	(self on: self classesAndMethods) openWithSpec
]

{ #category : #specs }
FQQueriesBrowserPresenter class >> title [
	^ 'Query Browser'
]

{ #category : #initialization }
FQQueriesBrowserPresenter >> defineInputPorts [
	^ {FQQueryPort new}
]

{ #category : #initialization }
FQQueriesBrowserPresenter >> displayLabelFor: query [
	^ query class label
		,
			(query class == FQSequenceQuery
				ifTrue: [ ' (' , query childrenQueries last class label , ')' ]
				ifFalse: [ '' ])
]

{ #category : #accessing }
FQQueriesBrowserPresenter >> entities [
	^ queriesCombinator currentResult
]

{ #category : #accessing }
FQQueriesBrowserPresenter >> entities: anObject [
	entities := anObject
]

{ #category : #initialization }
FQQueriesBrowserPresenter >> initializeInitialEntitiesButton [
	initialEntitiesButton := self newButton
		label: 'Initial entities';
		whenActivatedDo: [ "queriesTree unselectAll."
			queryResult items: queriesCombinator initialEntities ]
]

{ #category : #initialization }
FQQueriesBrowserPresenter >> initializePresenters [
	self initializeInitialEntitiesButton.
	self initializeQueriesTree.
	self initializeQueryCreationButton.
	self initializeQueryResult
]

{ #category : #initialization }
FQQueriesBrowserPresenter >> initializeQueriesTree [
	queriesTree := self newList
		headerTitle: 'Queries';
		display:
				[ :query | self displayLabelFor: query ];
		whenSelectionChangedDo: [ :selection | 
			queryResult
				items: (queriesCombinator resultOfQuery: selection selectedItem).
			self update ]
]

{ #category : #initialization }
FQQueriesBrowserPresenter >> initializeQueryCreationButton [
	newQueryButton := self newButton
		label: 'Create a new query';
		iconName: #add;
		whenActivatedDo: [ (FQQueryCreationPresenter on: self) openWithSpec ]
]

{ #category : #initialization }
FQQueriesBrowserPresenter >> initializeQueryResult [
	queryResult := self newList
		items: queriesCombinator initialEntities;
		display: #name
]

{ #category : #initialization }
FQQueriesBrowserPresenter >> setModelBeforeInitialization: aMooseGroup [
	queriesCombinator := FQQueriesCombinator newWithEntities: aMooseGroup
]

{ #category : #update }
FQQueriesBrowserPresenter >> updateForQuery: aQuery [
	queriesCombinator addQueryToSequence: aQuery.
	queriesTree items: queriesCombinator queries.
	queriesTree selectItem: queriesCombinator queries last
]
