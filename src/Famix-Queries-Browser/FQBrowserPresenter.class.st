Class {
	#name : #FQBrowserPresenter,
	#superclass : #SpPresenter,
	#instVars : [
		'entities',
		'queryBuilder',
		'queryType',
		'queryDisplay',
		'queryConfiguration',
		'entitiesList'
	],
	#category : #'Famix-Queries-Browser-Presenters'
}

{ #category : #accessing }
FQBrowserPresenter class >> default [
	^ self basicNew
		entities: self defaultEntities;
		initializeQueryBuilder;
		initialize;
		yourself
]

{ #category : #accessing }
FQBrowserPresenter class >> defaultEntities [
	| model unnamedEntities |
	model := FamixStModel new.
	MoosePharoImporterTask new
		importerClass: SmalltalkImporter;
		model: model;
		addFromPackageNamed: #'Moose-TestResources-LAN';
		run.
	unnamedEntities := MooseGroup
		withAll: (model copyWithoutAll: (model allUsing: FamixTNamedEntity)).
	^ MooseGroup
		withAll:
			{model allModelClasses.
			model allModelMethods} flatten	"unnamedEntities"	"model"
]

{ #category : #specs }
FQBrowserPresenter class >> defaultSpec [
	^ SpPanedLayout newHorizontal
		add: #entitiesList;
		position: 30 percent;
		add:
			(SpBoxLayout newVertical
				add: #queryType height: self buttonHeight;
				add: #queryConfiguration height: self queryConfigurationHeight;
				add: #queryDisplay;
				yourself);
		yourself
]

{ #category : #'instance creation' }
FQBrowserPresenter class >> open [
	<script>
	self default openWithSpec
]

{ #category : #specs }
FQBrowserPresenter class >> queryConfigurationHeight [
	"If this is changed, FQQueryConfigurationPresenter>>paddingAroundButton should also be changed."

	"(Padding around button = 50) * 2 + (button height = 29, see SpAbstractPresenter>>buttonHeight)"

	^ 129
]

{ #category : #specs }
FQBrowserPresenter class >> title [
	^ 'Famix Query Browser'
]

{ #category : #accessing }
FQBrowserPresenter >> entities [
	^ entities
]

{ #category : #accessing }
FQBrowserPresenter >> entities: anObject [
	entities := anObject
]

{ #category : #initialization }
FQBrowserPresenter >> initializePresenters [
	entitiesList := self newList
		items: self entities;
		display: #name.
	
	self initializeQueryTypes.
	
	"This will initialize queryConfiguration and queryDisplay according to the selected type of query. 
		See updateQueryConfiguration: "
	queryType selectIndex: 1
]

{ #category : #initialization }
FQBrowserPresenter >> initializeQueryBuilder [
	queryBuilder := FQQueryBuilder new
		entities: self entities;
		yourself
]

{ #category : #initialization }
FQBrowserPresenter >> initializeQueryTypes [
	queryType := self newDropList
		items: self queryTypes associations;
		display: [ :elt | elt value ];
		whenSelectedItemChangedDo: [ :type | self updateQueryConfiguration: type key ]
]

{ #category : #initialization }
FQBrowserPresenter >> initializeWindow: aWindowPresenter [
	aWindowPresenter initialExtent: 600 @ 300
]

{ #category : #accessing }
FQBrowserPresenter >> queryBuilder [
	^ queryBuilder
]

{ #category : #accessing }
FQBrowserPresenter >> queryBuilder: anObject [
	queryBuilder := anObject
]

{ #category : #'query configuration presenters' }
FQBrowserPresenter >> queryConfigurationTypes [
	^ Dictionary
		newFromKeys: self queryTypes keys
		andValues:
			{FQTypeQueriesPresenter.
			FQScopeQueriesPresenter.
			FQPropertyQueriesPresenter.
			FQNavigationQueriesPresenter}
]

{ #category : #accessing }
FQBrowserPresenter >> queryTypes [
	^ OrderedDictionary
		newFromKeys: {#typeQuery . #scopeQuery . #propertyQuery . #navigationQuery}
		andValues: {'Type Query' . 'Scope Query' . 'Property Query' . 'Navigation Query'}
]

{ #category : #'query configuration presenters' }
FQBrowserPresenter >> updateQueryConfiguration: aType [
	queryConfiguration := (self queryConfigurationTypes at: aType)
		owner: self
		on: self queryBuilder.
		
	queryDisplay := self newCode.
	
	queryConfiguration
		transmitTo: queryDisplay
		transform: [ :query | query ].
		
	self needRebuild: false.
	self buildWithSpec
]
