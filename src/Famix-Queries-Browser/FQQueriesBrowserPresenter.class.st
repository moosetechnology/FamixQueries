Class {
	#name : #FQQueriesBrowserPresenter,
	#superclass : #SpPresenter,
	#instVars : [
		'queriesTree',
		'queryResult',
		'queriesCombinator',
		'selectedQuery',
		'queryResultTitle',
		'queries'
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
		add:
			(SpBoxLayout newVertical
				add: #queryResultTitle height: self labelHeight;
				add: #queryResult;
				yourself);
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

{ #category : #accessing }
FQQueriesBrowserPresenter >> entities [
	^ selectedQuery result
]

{ #category : #accessing }
FQQueriesBrowserPresenter >> initialQuery [
	^ queries detect: [ :query | query parent isNil ]
]

{ #category : #initialization }
FQQueriesBrowserPresenter >> initializePresenters [
	self initializeQueriesTree.
	self initializeQueryResult
]

{ #category : #initialization }
FQQueriesBrowserPresenter >> initializeQueriesTree [
	"queriesTree := (SpTreeTablePresenter owner: self)
		addColumn:
			(SpCompositeTableColumn new
				title: 'Queries';
				addColumn: (SpStringTableColumn new evaluated: [ :query | query class label ]));
		roots: {self initialQuery};
		children: #children;
		selectItem: self initialQuery;
		contextMenuFromCommandsGroup: [ self rootCommandsGroup ];
		activateOnDoubleClick;
		whenSelectionChangedDo: [ :selection | self selectQuery: selection selectedItem ];
		whenActivatedDo: [ :selection | self openQueryCreationPresenter ]"

	queriesTree := (FQRoassalQueryPresenter owner: self on: self queries)
		adaptToBrowser: self
]

{ #category : #initialization }
FQQueriesBrowserPresenter >> initializeQueryResult [
	queryResultTitle := self newLabel
		label: 'Result of the selected query'.
	queryResult := self newList
		headerTitle: (self mooseGroupDetails: self entities);
		items: self entities;
		display: #name
]

{ #category : #initialization }
FQQueriesBrowserPresenter >> initializeWindow: aWindowPresenter [
	super initializeWindow: aWindowPresenter.
	aWindowPresenter initialExtent: 500 @ 400
]

{ #category : #accessing }
FQQueriesBrowserPresenter >> modelPrefix [
	^ self entities first mooseModel className withoutSuffix: 'Model'
]

{ #category : #accessing }
FQQueriesBrowserPresenter >> mooseGroupDetails: result [
	^ String
		streamContents: [ :stream | 
			(result collectAsSet: #class)
				do: [ :class | 
					stream
						<< (result select: [ :entity | entity class == class ]) size asString
						<< ' '
						<< (class name withoutPrefix: self modelPrefix) asEnglishPlural
						<< ' ' ] ]
]

{ #category : #action }
FQQueriesBrowserPresenter >> openQueryCreationPresenter [
	(FQQueryCreationPresenter on: self) openWithSpec
]

{ #category : #accessing }
FQQueriesBrowserPresenter >> queries [
	^ queries
]

{ #category : #action }
FQQueriesBrowserPresenter >> removeQuery: aQuery [
	aQuery children
		ifNotEmpty: [ UIManager default
				alert: 'Cannot remove a query with children for now'.
			^ self ].
	aQuery prepareRemovalFrom: self.
	queries remove: aQuery.
	^ aQuery
]

{ #category : #action }
FQQueriesBrowserPresenter >> selectQuery: aQuery [
	selectedQuery := aQuery.
	queriesTree selectItem: selectedQuery.
	queryResult
		items: selectedQuery result;
		headerTitle: (self mooseGroupDetails: selectedQuery result).
	self update
]

{ #category : #accessing }
FQQueriesBrowserPresenter >> selectedQuery [
	^ selectedQuery
]

{ #category : #'accessing model' }
FQQueriesBrowserPresenter >> setModelBeforeInitialization: aMooseGroup [
	queries := OrderedCollection new
		add:
			(FQMockQuery new
				result: aMooseGroup;
				yourself);
		yourself.
	selectedQuery := self initialQuery
]

{ #category : #action }
FQQueriesBrowserPresenter >> updateForQuery: aQuery [
	aQuery parent: selectedQuery.
	selectedQuery addChild: aQuery.
	self selectQuery: (queries addLast: aQuery)
]
