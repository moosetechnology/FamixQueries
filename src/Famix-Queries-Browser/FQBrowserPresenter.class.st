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
	| model |
	model := FamixStModel new.
	MoosePharoImporterTask new
		importerClass: SmalltalkImporter;
		model: model;
		addFromPackageNamed: #'Moose-TestResources-LAN';
		run.
	^ self basicNew
		entities: model asMooseGroup;
		initialize;
		yourself
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
FQBrowserPresenter >> initialExtent [
	self flag: 'See overriden in SpPresenter'.
	^ 600 @ 300
]

{ #category : #initialization }
FQBrowserPresenter >> initialize [
	super initialize.
	queryBuilder := FQQueryBuilder new
		entities: self entities;
		yourself
]

{ #category : #initialization }
FQBrowserPresenter >> initializePresenters [
	entitiesList := self newList
		items: self entities;
		display: #name.
	self initializeQueryTypes.
	queryConfiguration := self typeQueryConfigurationPresenter.
	queryDisplay := self newCode.
	queryConfiguration
		transmitTo: queryDisplay
		transform: [ :query | query ]
]

{ #category : #initialization }
FQBrowserPresenter >> initializeQueryTypes [
	queryType := self newDropList
		items: self queryTypes associations;
		display: [ :elt | elt value ];
		whenSelectedItemChangedDo: [ :type | self updateQueryConfiguration: type key ]
]

{ #category : #'query configuration presenters' }
FQBrowserPresenter >> navigationQueryConfigurationPresenter [
	^ FQNavigationQueriesPresenter
		owner: self
		on: FQNavigationQueriesModel default
]

{ #category : #'query configuration presenters' }
FQBrowserPresenter >> propertyQueryConfigurationPresenter [
	^ FQPropertyQueriesPresenter
		owner: self
		on: FQPropertyQueriesModel default
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
			{self typeQueryConfigurationPresenter.
			self scopeQueryConfigurationPresenter.
			self propertyQueryConfigurationPresenter.
			self navigationQueryConfigurationPresenter}
]

{ #category : #accessing }
FQBrowserPresenter >> queryTypes [
	^ OrderedDictionary
		newFromKeys: {#typeQuery . #scopeQuery . #propertyQuery . #navigationQuery}
		andValues: {'Type Query' . 'Scope Query' . 'Property Query' . 'Navigation Query'}
]

{ #category : #'query configuration presenters' }
FQBrowserPresenter >> scopeQueryConfigurationPresenter [
	^ FQScopeQueriesPresenter owner: self on: self queryBuilder	"FQScopeQueriesModel default"
]

{ #category : #'query configuration presenters' }
FQBrowserPresenter >> typeQueryConfigurationPresenter [
	^ FQTypeQueriesPresenter owner: self on: FQTypeQueriesModel default
]

{ #category : #'query configuration presenters' }
FQBrowserPresenter >> updateQueryConfiguration: aType [
	queryConfiguration := self queryConfigurationTypes at: aType.
	queryConfiguration
		transmitTo: queryDisplay
		transform: [ :query | query ].
	self needRebuild: false.
	self buildWithSpec
]
