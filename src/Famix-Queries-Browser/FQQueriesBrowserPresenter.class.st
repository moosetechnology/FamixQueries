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

{ #category : #action }
FQQueriesBrowserPresenter >> addUnionQueryBetween: aQuery and: anotherQuery [
	self
		selectQuery: (queriesCombinator addUnionQueryBetween: aQuery and: anotherQuery)
]

{ #category : #initialization }
FQQueriesBrowserPresenter >> defineInputPorts [
	self flag: #FQUnused.
	^ {FQQueryPort new}
]

{ #category : #accessing }
FQQueriesBrowserPresenter >> entities [
	^ queriesCombinator resultOfQuery: selectedQuery
]

{ #category : #accessing }
FQQueriesBrowserPresenter >> initialQuery [
	^ queriesCombinator initialQuery
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
		headerTitle: 'Result of the selected query';
		items: queriesCombinator initialEntities;
		display: #name
]

{ #category : #initialization }
FQQueriesBrowserPresenter >> initializeWindow: aWindowPresenter [
	aWindowPresenter initialExtent: 500 @ 400
]

{ #category : #action }
FQQueriesBrowserPresenter >> openQueryCreationPresenter [
	(FQQueryCreationPresenter on: self) openWithSpec
]

{ #category : #accessing }
FQQueriesBrowserPresenter >> queries [
	^ queriesCombinator queries
]

{ #category : #action }
FQQueriesBrowserPresenter >> removeQuery: aQuery [
	self selectQuery: aQuery parent.
	queriesCombinator removeQuery: aQuery
]

{ #category : #action }
FQQueriesBrowserPresenter >> selectQuery: aQueryWrapper [
	selectedQuery := aQueryWrapper.
	queriesTree selectItem: selectedQuery.
	self
		flag:
			#FQImprove,
					'If we just selectItem in tabletree and in roassal, maybe the FQTreeTablePres class is unsueful'.
	queryResult items: (queriesCombinator resultOfQuery: aQueryWrapper).
	self update
]

{ #category : #accessing }
FQQueriesBrowserPresenter >> selectedQuery [
	^ selectedQuery
]

{ #category : #'accessing model' }
FQQueriesBrowserPresenter >> setModelBeforeInitialization: aMooseGroup [
	queriesCombinator := FQQueriesCombinator newWithEntities: aMooseGroup.
	selectedQuery := queriesCombinator initialQuery
]

{ #category : #action }
FQQueriesBrowserPresenter >> updateForQuery: aQuery [
	self
		selectQuery: (queriesCombinator addQuery: aQuery after: selectedQuery)
]
