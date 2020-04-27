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
			(SpBoxLayout newVertical
				add: #queriesTree;
				add: #newQueryButton height: self buttonHeight;
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
FQQueriesBrowserPresenter >> connectPresenters [
	queriesTree
		transmitTo: queryResult
		transform:
			[ :item | item ifNotNil: [ queriesCombinator resultOfQuery: item ] ifNil: [ {} ] ]
]

{ #category : #initialization }
FQQueriesBrowserPresenter >> defineInputPorts [
	^ {FQQueryPort new}
]

{ #category : #accessing }
FQQueriesBrowserPresenter >> entities [
	^ queriesTree selectedItem
		ifNil: [ queriesCombinator initialEntities ]
		ifNotNil: [ queriesCombinator resultOfQuery: queriesTree selectedItem ]
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
	queriesTree := self newTreeTable
		addColumn:
			(SpCompositeTableColumn new
				title: 'Queries';
				addColumn: (SpStringTableColumn new evaluated: [ :wrapper | wrapper label ]));
		roots: queriesCombinator queries;
		children: #children;
		selectItem: queriesCombinator queries first;
		yourself
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
	| newQueryWrapper |
	newQueryWrapper := queriesTree selectedItem "Keep trace of the parent, independant of the selection ?"
		ifNil: [ queriesCombinator addQueryOnInitialEntities: aQuery ]
		ifNotNil: [ queriesCombinator addQuery: aQuery after: queriesTree selectedItem ].
	queriesTree
		roots:
			(queriesCombinator queries select: [ :wrapper | wrapper parent isNil ]);
		children: [ :wrapper | wrapper children ].
	queriesTree selectItem: newQueryWrapper.
	queryResult items: (queriesCombinator resultOfQuery: newQueryWrapper).
	self update
]
