Class {
	#name : #FQQueriesBrowserPresenter,
	#superclass : #SpPresenter,
	#instVars : [
		'queriesTree',
		'queryResult',
		'queriesCombinator',
		'selectedQuery'
	],
	#category : #'Famix-Queries-Browser-Presenters'
}

{ #category : #commands }
FQQueriesBrowserPresenter class >> buildCommandsGroupWith: presenterIntance forRoot: rootCommandGroup [
	rootCommandGroup
		register:
			(FQAddQueryCommand forSpec
				iconName: #add;
				yourself)
]

{ #category : #entities }
FQQueriesBrowserPresenter class >> classesAndMethods [
	| model |
	model := self modelExample.
	^ MooseGroup
		withAll:
			{model allModelClasses.
			model allModelMethods} flatten
]

{ #category : #specs }
FQQueriesBrowserPresenter class >> defaultSpec [
	^ SpPanedLayout newHorizontal
		add:
			(SpBoxLayout newVertical
				add: #queriesTree;
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
	^ queriesCombinator resultOfQuery: selectedQuery
]

{ #category : #initialization }
FQQueriesBrowserPresenter >> initializePresenters [
	self initializeQueriesTree.
	self initializeQueryResult
]

{ #category : #initialization }
FQQueriesBrowserPresenter >> initializeQueriesTree [
	"queriesTree := (FQTreeTablePresenter owner: self) adaptToOwner"

	queriesTree := (FQRoassalQueryPresenter owner: self) adaptToOwner
]

{ #category : #initialization }
FQQueriesBrowserPresenter >> initializeQueryResult [
	queryResult := self newList
		items: queriesCombinator initialEntities;
		display: #name
]

{ #category : #initialization }
FQQueriesBrowserPresenter >> setModelBeforeInitialization: aMooseGroup [
	queriesCombinator := FQQueriesCombinator newWithEntities: aMooseGroup.
	selectedQuery := queriesCombinator initialQuery
]

{ #category : #update }
FQQueriesBrowserPresenter >> updateForQuery: aQuery [
	selectedQuery := queriesCombinator
		addQuery: aQuery
		after: selectedQuery.
	queriesTree selectItem: selectedQuery.
	self
		flag:
			'If we just selectItem in tabletree and in roassal, not useful to create this special method. Maybe not even the FQTreeTablePres class'.
	queryResult items: (queriesCombinator resultOfQuery: selectedQuery).
	self update
]
