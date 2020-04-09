Class {
	#name : #FQBrowserPresenter,
	#superclass : #SpPresenter,
	#instVars : [
		'entities',
		'entitiesList',
		'queryConfigurationPresenter',
		'queryCode',
		'queryTypesDropList'
	],
	#category : #'Famix-Queries-Browser-Presenters'
}

{ #category : #'instance creation' }
FQBrowserPresenter class >> default [
	^ self basicNew
		entities: self defaultEntities;
		initialize;
		yourself
]

{ #category : #'instance creation' }
FQBrowserPresenter class >> defaultEntities [
	| model noCommonTypeNorProperty noDownScope |
	model := FamixStModel new.
	MoosePharoImporterTask new
		importerClass: SmalltalkImporter;
		model: model;
		addFromPackageNamed: #'Moose-TestResources-LAN';
		run.
	noCommonTypeNorProperty := MooseGroup
		withAll: (model copyWithoutAll: (model allUsing: FamixTNamedEntity)).
	noDownScope := model allWithType: FamixStAnnotationInstanceAttribute.
	^ MooseGroup
		withAll:
			{model allModelClasses.
			model allModelMethods} flatten
]

{ #category : #specs }
FQBrowserPresenter class >> defaultSpec [
	^ SpPanedLayout newHorizontal
		add: #entitiesList;
		position: 30 percent;
		add:
			(SpBoxLayout newVertical
				add: #queryTypesDropList height: self buttonHeight;
				add: #queryConfigurationPresenter height: self queryConfigurationHeight;
				add: #queryCode;
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

{ #category : #'query configuration presenters' }
FQBrowserPresenter class >> queryConfigurationPresenters [
	^ FQQueryConfigurationPresenter allSubclasses
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
	self initializeQueryTypesDropList.
	queryCode := self newCode.

	"This will initialize queryConfiguration  according to the selected type of query. 
		See updateQueryConfiguration: "
	queryTypesDropList selectIndex: 1
]

{ #category : #initialization }
FQBrowserPresenter >> initializeQueryTypesDropList [
	queryTypesDropList := self newDropList
		items: self class queryConfigurationPresenters;
		display: [ :presenter | presenter queryClass label ];
		whenSelectedItemChangedDo: [ :presenter | self updateQueryConfigurationPresenter: presenter ]
]

{ #category : #initialization }
FQBrowserPresenter >> initializeWindow: aWindowPresenter [
	super initializeWindow: aWindowPresenter.
	aWindowPresenter initialExtent: 600 @ 300
]

{ #category : #'query configuration presenters' }
FQBrowserPresenter >> updateQueryConfigurationPresenter: aPresenterClass [
	queryConfigurationPresenter := aPresenterClass
		owner: self
		on: self entities.
	queryConfigurationPresenter
		transmitTo: queryCode
		transform: [ :queryBuilder | queryBuilder createQuery ].
	queryConfigurationPresenter
		transmitPort: #newQueryPort
		do: [ :queryBuilder | 
			UIManager default
				confirm: 'This wil trigger a more complex action later'
				label: 'Query was applied' ].
	queryConfigurationPresenter transmitInitialConfiguration.
	self update
]
