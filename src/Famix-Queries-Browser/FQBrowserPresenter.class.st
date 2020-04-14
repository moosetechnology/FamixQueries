Class {
	#name : #FQBrowserPresenter,
	#superclass : #SpPresenter,
	#instVars : [
		'entities',
		'entitiesList',
		'queryConfigurationPresenter',
		'queryCode',
		'queryTypesDropList',
		'resultList',
		'toolBar',
		'entitiesListTitle',
		'resultListTitle'
	],
	#category : #'Famix-Queries-Browser-Presenters'
}

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
	^ SpBoxLayout newHorizontal
		add:
			(SpBoxLayout newVertical
				add: #entitiesListTitle height: self labelHeight;
				add: #entitiesList;
				yourself);
		add:
			(SpBoxLayout newVertical
				add: #queryTypesDropList height: self buttonHeight;
				add: #queryConfigurationPresenter
					height: self queryConfigurationHeight;
				add: #queryCode;
				yourself)
			width: self queryConfigurationWidth;
		add:
			(SpBoxLayout newVertical
				add: #resultListTitle height: self labelHeight;
				add: #resultList;
				yourself);
		spacing: 5;
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

{ #category : #'query configuration presenters' }
FQBrowserPresenter class >> queryConfigurationPresenters [
	^ FQQueryConfigurationPresenter allSubclasses
]

{ #category : #specs }
FQBrowserPresenter class >> queryConfigurationWidth [
	self flag: 'Change when we can use a pane'.
	^ 300
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
	entitiesListTitle := self newLabel label: 'Current Entities'.
	entitiesList := self newList
		items: self entities;
		display: #name.

	resultListTitle := self newLabel label: 'Query result'.
	resultList := self newList
		display: #name;
		yourself.

	self initializeQueryTypesDropList.
	"This will initialize queryConfiguration  according to the selected type of query. 
		See updateQueryConfiguration: "
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
FQBrowserPresenter >> updateQueryCode [
	queryCode := queryConfigurationPresenter queryBuilder queryIsValid
		ifTrue: [ self newCode ]
		ifFalse: [ self newText ].
	self flag: 'ugly, use transmissions'.
	queryCode
		whenTextIsAcceptedDo: [ :code | 
			| newQuery |
			newQuery := Smalltalk compiler evaluate: code.
			queryCode
				text:
					(EFFormatter
						format:
							(RBParser
								parseExpression: (String streamContents: [ :s | newQuery storeOn: s ]))).
			queryConfigurationPresenter updateForQuery: newQuery ]
]

{ #category : #update }
FQBrowserPresenter >> updateQueryConfigurationPresenter: aPresenterClass [
	queryConfigurationPresenter := aPresenterClass
		owner: self
		on: self entities.
	self updateQueryCode.
	self updateTransmissions.
	queryConfigurationPresenter transmitInitialConfiguration.
	self update
]

{ #category : #update }
FQBrowserPresenter >> updateTransmissions [
	queryConfigurationPresenter
		transmitTo: queryCode
		transform: [ :queryBuilder | queryBuilder codeToDisplay ].
	queryConfigurationPresenter
		transmitTo: resultList
		transform: [ :queryBuilder | 
			| result |
			result := queryBuilder applyQuery.
			result
				ifEmpty: [ resultList headerTitle: 'No entities to show' ]
				ifNotEmpty: [ resultList hideHeaderTitle ].
			result ]
]
