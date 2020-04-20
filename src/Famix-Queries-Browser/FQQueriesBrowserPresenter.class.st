Class {
	#name : #FQQueriesBrowserPresenter,
	#superclass : #SpPresenter,
	#instVars : [
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
			(SpPanedLayout newVertical
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

{ #category : #accessing }
FQQueriesBrowserPresenter >> entities [
	^ queriesCombinator currentResult
]

{ #category : #accessing }
FQQueriesBrowserPresenter >> entities: anObject [
	entities := anObject
]

{ #category : #initialization }
FQQueriesBrowserPresenter >> initializePresenters [
	self initializeQueriesTree.
	self initializeQueryCreationButton.
	self initializeQueryResult
]

{ #category : #initialization }
FQQueriesBrowserPresenter >> initializeQueriesTree [
	queriesTree := self newList
		headerTitle: 'Queries';
		display: [ :query | query class label ];
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

{ #category : #update }
FQQueriesBrowserPresenter >> updateForQuery: aQuery [
	queriesCombinator addQueryToSequence: aQuery.
	queriesTree items: queriesCombinator queries.
	queriesTree selectItem: queriesCombinator queries last
]
