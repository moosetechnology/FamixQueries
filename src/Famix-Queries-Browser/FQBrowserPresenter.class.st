Class {
	#name : #FQBrowserPresenter,
	#superclass : #SpPresenter,
	#instVars : [
		'entities',
		'queryConfigurationPresenter',
		'queryCode',
		'queryTypesDropList',
		'resultList',
		'toolBar',
		'resultListTitle',
		'superPresenter'
	],
	#category : #'Famix-Queries-Browser-Presenters'
}

{ #category : #commands }
FQBrowserPresenter class >> buildCommandsGroupWith: presenter forRoot: aCmCommandsGroup [
	aCmCommandsGroup
		register:
			((FQQueryCreationCommand forSpecWithIconNamed: #glamorousGo)
				context: presenter)
]

{ #category : #entities }
FQBrowserPresenter class >> classesAndMethods [
	| model |
	model := self modelExample.
	^ MooseGroup
		withAll:
			{model allModelClasses.
			model allModelMethods} flatten
]

{ #category : #'instance creation' }
FQBrowserPresenter class >> default [
	^ self basicNew
		entities: self classesAndMethods;
		initialize;
		yourself
]

{ #category : #specs }
FQBrowserPresenter class >> defaultSpec [
	^ SpBoxLayout newVertical
		add: #toolBar height: self toolbarHeight;
		add:
			(SpPanedLayout newHorizontal
				add: self queryConfigurationLayout;
				position: 65 percent;
				add: self queryResultLayout;
				yourself);
		yourself
]

{ #category : #entities }
FQBrowserPresenter class >> entitiesWithNoDownScope [
	^ self modelExample allWithType: FamixStAnnotationInstanceAttribute
]

{ #category : #entities }
FQBrowserPresenter class >> modelExample [
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
FQBrowserPresenter class >> newWhithoutEntities [
	^ self basicNew
		entities: self noEntities;
		initialize;
		yourself
]

{ #category : #entities }
FQBrowserPresenter class >> noEntities [
	^ MooseGroup new
]

{ #category : #'instance creation' }
FQBrowserPresenter class >> open [
	<script>
	self default openWithSpec
]

{ #category : #'instance creation' }
FQBrowserPresenter class >> openOn: aMooseGroup [
	(self on: aMooseGroup) openWithSpec
]

{ #category : #'instance creation' }
FQBrowserPresenter class >> openWithoutEntities [
	<script>
	self newWhithoutEntities openWithSpec
]

{ #category : #specs }
FQBrowserPresenter class >> queryConfigurationHeight [
	"If this is changed, FQQueryConfigurationPresenter>>paddingAroundButton should also be changed."

	"(Padding around button = 50) * 2 + (button height = 29, see SpAbstractPresenter>>buttonHeight)"

	^ 129
]

{ #category : #specs }
FQBrowserPresenter class >> queryConfigurationLayout [
	^ SpBoxLayout newVertical
		add: #queryTypesDropList height: self buttonHeight;
		add: #queryConfigurationPresenter
			height: self queryConfigurationHeight;
		add: #queryCode;
		yourself
]

{ #category : #'query configuration presenters' }
FQBrowserPresenter class >> queryConfigurationPresenters [
	^ FQQueryConfigurationPresenter allSubclasses
]

{ #category : #specs }
FQBrowserPresenter class >> queryResultLayout [
	^ SpBoxLayout newVertical
		add: #resultListTitle height: self labelHeight;
		add: #resultList;
		yourself
]

{ #category : #specs }
FQBrowserPresenter class >> title [
	^ 'Famix Query Browser'
]

{ #category : #entities }
FQBrowserPresenter class >> unnamedEntities [
	| model |
	model := self modelExample.
	^ MooseGroup
		withAll: (model copyWithoutAll: (model allUsing: FamixTNamedEntity))
]

{ #category : #commands }
FQBrowserPresenter >> applyQuery: aQuery [
	self owner updateForNewQuery: aQuery
]

{ #category : #commands }
FQBrowserPresenter >> defaultCommandsContext [
	^ queryConfigurationPresenter
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
	toolBar := self newToolBar "beText".
	queryCode := self newCode
		whenTextIsAcceptedDo: [ :code | self updateForAcceptedCode: code ];
		yourself.
	resultListTitle := self newLabel label: 'Query result'.
	resultList := self newList
		display: #name;
		yourself.
	self initializeQueryTypesDropList.
	self initializeQueryConfigurationPresenter
]

{ #category : #initialization }
FQBrowserPresenter >> initializeQueryConfigurationPresenter [
	queryTypesDropList selectIndex: 1
]

{ #category : #initialization }
FQBrowserPresenter >> initializeQueryTypesDropList [
	queryTypesDropList := self newDropList
		items: self class queryConfigurationPresenters;
		display: [ :presenter | presenter label ];
		whenSelectedItemChangedDo: [ :presenter | self updateQueryConfigurationPresenter: presenter ]
]

{ #category : #initialization }
FQBrowserPresenter >> initializeWindow: aWindowPresenter [
	super initializeWindow: aWindowPresenter.
	aWindowPresenter initialExtent: 650 @ 400
]

{ #category : #initialization }
FQBrowserPresenter >> setModelBeforeInitialization: aQueriesPresenter [
	entities := aQueriesPresenter entities.
	superPresenter := aQueriesPresenter
]

{ #category : #update }
FQBrowserPresenter >> showQueryResult: queryResult [
	resultList
		unselectAll;
		items: queryResult.
	queryResult
		ifEmpty: [ resultList headerTitle: 'No entities to show' ]
		ifNotEmpty: [ resultList hideHeaderTitle ].
	self update
]

{ #category : #update }
FQBrowserPresenter >> updateForAcceptedCode: code [
	queryConfigurationPresenter updateForQueryCode: code.
	queryCode
		text: queryConfigurationPresenter queryBuilder codeToDisplay.
	self
		flag:
			'This should go through transmissions but TextChangedPort is buggy in Spec for now. 
			FQCodeAcceptedPort is ready to accept a transmission'
]

{ #category : #update }
FQBrowserPresenter >> updateQueryConfigurationPresenter: aPresenterClass [
	queryConfigurationPresenter := aPresenterClass
		owner: self
		on: self entities.
	self updateToolBar.
	self updateTransmissions.
	queryConfigurationPresenter transmitInitialConfiguration.
	self update
]

{ #category : #update }
FQBrowserPresenter >> updateToolBar [
	toolBar fillWith: self rootCommandsGroup
]

{ #category : #update }
FQBrowserPresenter >> updateTransmissions [
	queryConfigurationPresenter
		transmitTo: queryCode
		transform: [ :queryBuilder | 
			queryCode syntaxHighlight: queryBuilder queryIsValid.
			queryBuilder codeToDisplay ].
	queryConfigurationPresenter
		transmitTo: resultList
		transform: [ :queryBuilder | 
			| result |
			result := queryBuilder applyQuery.
			result
				ifEmpty: [ resultList headerTitle: 'No entities to show' ]
				ifNotEmpty: [ resultList hideHeaderTitle ].
			result ].

	"queryCode transmitTo: queryConfigurationPresenter"	"Bug in Spec"
	queryConfigurationPresenter
		transmitPort: #acceptedQuery
		do: [ :query | superPresenter updateForQuery: query ]
]
