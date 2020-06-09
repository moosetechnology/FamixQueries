Class {
	#name : #FQQueriesBrowserPresenter,
	#superclass : #MiAbstractBrowser,
	#instVars : [
		'queriesTree',
		'queryResult',
		'selectedQuery',
		'queries',
		'queryCode'
	],
	#category : #'Famix-Queries-Browser-Presenters'
}

{ #category : #specs }
FQQueriesBrowserPresenter class >> defaultSpec [
	^ super defaultSpec
		add:
			(SpPanedLayout newHorizontal
				add: #queriesTree;
				add:
					(SpPanedLayout newVertical
						add: #queryResult;
						add: #queryCode;
						yourself);
				yourself);
		yourself
]

{ #category : #'world menu' }
FQQueriesBrowserPresenter class >> menuCommandOn: aBuilder [
	<worldMenu>
	(aBuilder item: #Queries)
		parent: self toolbarName;
		label: 'Queries';
		action: [ self runMe ]
]

{ #category : #private }
FQQueriesBrowserPresenter class >> new [
	"A MooseGroup is necessary to initialize this presenter"

	^ self on: MooseGroup new
]

{ #category : #'instance creation' }
FQQueriesBrowserPresenter class >> open [
	<script>
	self
		flag:
			#FQImprove
				, 'This should be an example AND it depends on tests package'.
	^ (self on: FQTestsHelper current classesAndMethods)
		openWithSpec;
		yourself
]

{ #category : #'instance creation' }
FQQueriesBrowserPresenter class >> openEmpty [
	<script>
	^ self new
		openWithSpec;
		yourself
]

{ #category : #'world menu' }
FQQueriesBrowserPresenter class >> runMe [
	<script>
	^ super runMe
]

{ #category : #specs }
FQQueriesBrowserPresenter class >> title [
	^ 'Query Browser'
]

{ #category : #midas }
FQQueriesBrowserPresenter >> accept: anObject [
	^ (anObject isKindOf: MooseObject)
		and: [ (anObject asMooseGroup allUsing: FamixTNamedEntity) isNotEmpty
				and: [ anObject asMooseGroup ~= selectedQuery result ] ]
]

{ #category : #accessing }
FQQueriesBrowserPresenter >> entities [
	^ selectedQuery result
]

{ #category : #midas }
FQQueriesBrowserPresenter >> followAction [
	self selectEntity: toSelect
]

{ #category : #accessing }
FQQueriesBrowserPresenter >> initialQuery [
	^ queries detect: [ :query | query parent isNil ]
]

{ #category : #initialization }
FQQueriesBrowserPresenter >> initializePresenters [
	super initializePresenters.
	self initializeQueriesTree.
	self initializeQueryResult.
	self initializeQueryCode
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
FQQueriesBrowserPresenter >> initializeQueryCode [
	queryCode := self newCode text: '"Query code"'
]

{ #category : #initialization }
FQQueriesBrowserPresenter >> initializeQueryResult [
	queryResult := (self instantiate: FQResultTreePresenter on: self)
		updateForEntities: self entities;
		yourself
]

{ #category : #midas }
FQQueriesBrowserPresenter >> miSelectedItem [
	^ selectedQuery result
]

{ #category : #action }
FQQueriesBrowserPresenter >> openCombinationPresenterFor: aQuery and: anotherQuery [
	(FQQueriesCombinationPresenter on: self)
		onQueries:
			{aQuery.
			anotherQuery};
		openWithSpec
]

{ #category : #action }
FQQueriesBrowserPresenter >> openQueryCreationPresenter [
	(FQQueryCreationPresenter on: self) openWithSpec
]

{ #category : #accessing }
FQQueriesBrowserPresenter >> queries [
	^ queries
]

{ #category : #transmissions }
FQQueriesBrowserPresenter >> queryInputPort [
	^ FQQueryInputPort newPresenter: self
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

{ #category : #midas }
FQQueriesBrowserPresenter >> selectEntity: anEntity [
	| entityToSelect |
	(self accept: anEntity)
		ifFalse: [ ^ self ].
	entityToSelect := anEntity asMooseGroup allUsing: FamixTNamedEntity.
	queries do: #resetResult.
	self initialQuery result: entityToSelect.
	self initialQuery name: entityToSelect first mooseModel name.
	self selectQuery: self initialQuery
]

{ #category : #action }
FQQueriesBrowserPresenter >> selectQuery: aQuery [
	selectedQuery := aQuery.
	queriesTree selectItem: selectedQuery.
	queryResult updateForEntities: aQuery result.
	queryCode
		text:
			(aQuery isRootQuery
				ifTrue: [ '"Query code"' ]
				ifFalse: [ EFFormatter
						format:
							(RBParser
								parseExpression: (String streamContents: [ :s | aQuery storeWithParentsOn: s ])) ]).
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
			(FQRootQuery new
				result: aMooseGroup;
				yourself);
		yourself.
	selectedQuery := self initialQuery
]

{ #category : #action }
FQQueriesBrowserPresenter >> updateForQuery: aQuery [
	"This method is called from FQQueryCreationPresenter and FQQueriesCombinationPresenter. 
	They have the responsibility to establish the [parent* - child] relationship between queries"

	self selectQuery: (queries addLast: aQuery)
]
