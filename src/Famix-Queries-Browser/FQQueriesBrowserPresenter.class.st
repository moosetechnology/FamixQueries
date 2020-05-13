Class {
	#name : #FQQueriesBrowserPresenter,
	#superclass : #MiAbstractBrowser,
	#instVars : [
		'queriesTree',
		'queryResult',
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
	^ super defaultSpec
		add:
			(SpPanedLayout newHorizontal
				add: #queriesTree;
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

{ #category : #'instance creation' }
FQQueriesBrowserPresenter class >> openEmpty [
	<script>
	(self on: MooseGroup new) openWithSpec
]

{ #category : #specs }
FQQueriesBrowserPresenter class >> title [
	^ 'Query Browser'
]

{ #category : #'as yet unclassified' }
FQQueriesBrowserPresenter >> accept: anObject [
	^ anObject isKindOf: MooseAbstractGroup
]

{ #category : #action }
FQQueriesBrowserPresenter >> addCombinationQuery: newQuery [
	(queries includesAll: newQuery parents)
		ifFalse: [ FQUnknownPrecedingQuery signal ].
	self selectQuery: (queries addLast: newQuery)
]

{ #category : #action }
FQQueriesBrowserPresenter >> combineQuery: aQuery with: anotherQuery [
	(FQQueriesCombinationPresenter on: self)
		onQueries:
			{aQuery.
			anotherQuery};
		openWithSpec
]

{ #category : #transmissions }
FQQueriesBrowserPresenter >> defaultInputPort [
	^ FQQueryCreatedPort newPresenter: self
]

{ #category : #accessing }
FQQueriesBrowserPresenter >> entities [
	^ selectedQuery result
]

{ #category : #'as yet unclassified' }
FQQueriesBrowserPresenter >> followAction [
	(self accept: toSelect)
		ifFalse: [ ^ self ].
	queries do: #resetResult.
	self initialQuery result: (toSelect allUsing: FamixTNamedEntity).
	self initialQuery label: toSelect name.
	self selectQuery: self initialQuery
]

{ #category : #'as yet unclassified' }
FQQueriesBrowserPresenter >> highlightAction [
	(self accept: toSelect)
		ifFalse: [ ^ self ]
]

{ #category : #accessing }
FQQueriesBrowserPresenter >> initialQuery [
	^ queries detect: [ :query | query parent isNil ]
]

{ #category : #initialization }
FQQueriesBrowserPresenter >> initializePresenters [
	super initializePresenters.
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
	queryResult := (self instantiate: FQResultTreePresenter on: self)
		updateForEntities: self entities;
		yourself
]

{ #category : #initialization }
FQQueriesBrowserPresenter >> initializeWindow: aWindowPresenter [
	super initializeWindow: aWindowPresenter.
	aWindowPresenter initialExtent: 500 @ 400
]

{ #category : #accessing }
FQQueriesBrowserPresenter >> modelPrefix [
	^ self initialQuery result first mooseModel className
		withoutSuffix: 'Model'
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
	queryResult updateForEntities: aQuery result.
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

{ #category : #accessing }
FQQueriesBrowserPresenter >> sortedEntities [
	| types |
	types := (self entities collectAsSet: #class) asOrderedCollection.
	^ (types
		collect: [ :type | self entities select: [ :entity | entity class == type ] ])
		flatten
]

{ #category : #action }
FQQueriesBrowserPresenter >> updateForQuery: aQuery [
	aQuery parent: selectedQuery.
	selectedQuery addChild: aQuery.
	self selectQuery: (queries addLast: aQuery)
]
