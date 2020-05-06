Class {
	#name : #FQQueryCreationPresenter,
	#superclass : #SpPresenter,
	#instVars : [
		'queryConfigurationPresenter',
		'queryCode',
		'queryTypesDropList',
		'resultList',
		'toolBar',
		'resultListTitle',
		'browser',
		'sequence'
	],
	#category : #'Famix-Queries-Browser-Presenters'
}

{ #category : #commands }
FQQueryCreationPresenter class >> buildCommandsGroupWith: presenter forRoot: aCmCommandsGroup [
	aCmCommandsGroup
		register:
			((FQQueryCreationCommand forSpecWithIconNamed: #glamorousGo)
				context: presenter)
]

{ #category : #entities }
FQQueryCreationPresenter class >> classesAndMethods [
	| model |
	model := self modelExample.
	^ MooseGroup
		withAll:
			{model allModelClasses.
			model allModelMethods} flatten
]

{ #category : #'instance creation' }
FQQueryCreationPresenter class >> default [
	^ self basicNew
		entities: self classesAndMethods;
		initialize;
		yourself
]

{ #category : #specs }
FQQueryCreationPresenter class >> defaultSpec [
	^ SpBoxLayout newVertical
		add: #toolBar height: self toolbarHeight;
		add: #sequence height: self toolbarHeight;
		add:
			(SpPanedLayout newHorizontal
				add: self queryConfigurationLayout;
				position: 65 percent;
				add: self queryResultLayout;
				yourself);
		yourself
]

{ #category : #entities }
FQQueryCreationPresenter class >> entitiesWithNoDownScope [
	^ self modelExample allWithType: FamixStAnnotationInstanceAttribute
]

{ #category : #entities }
FQQueryCreationPresenter class >> modelExample [
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
FQQueryCreationPresenter class >> newWhithoutEntities [
	^ self basicNew
		entities: self noEntities;
		initialize;
		yourself
]

{ #category : #entities }
FQQueryCreationPresenter class >> noEntities [
	^ MooseGroup new
]

{ #category : #'instance creation' }
FQQueryCreationPresenter class >> open [
	<script>
	self default openWithSpec
]

{ #category : #'instance creation' }
FQQueryCreationPresenter class >> openOn: aMooseGroup [
	(self on: aMooseGroup) openWithSpec
]

{ #category : #'instance creation' }
FQQueryCreationPresenter class >> openWithoutEntities [
	<script>
	self newWhithoutEntities openWithSpec
]

{ #category : #specs }
FQQueryCreationPresenter class >> queryConfigurationHeight [
	"If this is changed, FQQueryConfigurationPresenter>>paddingAroundButton should also be changed."

	"(Padding around button = 50) * 2 + (button height = 29, see SpAbstractPresenter>>buttonHeight)"

	^ 129
]

{ #category : #specs }
FQQueryCreationPresenter class >> queryConfigurationLayout [
	^ SpBoxLayout newVertical
		add: #queryTypesDropList height: self buttonHeight;
		add: #queryConfigurationPresenter
			height: self queryConfigurationHeight;
		add: #queryCode;
		yourself
]

{ #category : #'query configuration presenters' }
FQQueryCreationPresenter class >> queryConfigurationPresenters [
	^ FQQueryConfigurationPresenter allSubclasses
]

{ #category : #specs }
FQQueryCreationPresenter class >> queryResultLayout [
	^ SpBoxLayout newVertical
		add: #resultListTitle height: self labelHeight;
		add: #resultList;
		yourself
]

{ #category : #specs }
FQQueryCreationPresenter class >> title [
	^ 'Query Creation'
]

{ #category : #entities }
FQQueryCreationPresenter class >> unnamedEntities [
	| model |
	model := self modelExample.
	^ MooseGroup
		withAll: (model copyWithoutAll: (model allUsing: FamixTNamedEntity))
]

{ #category : #commands }
FQQueryCreationPresenter >> defaultCommandsContext [
	^ queryConfigurationPresenter
]

{ #category : #accessing }
FQQueryCreationPresenter >> entities [
	^ browser entities
]

{ #category : #initialization }
FQQueryCreationPresenter >> initializePresenters [
	toolBar := self newToolBar.	"beText"
	self initializeRoassalSequence.
	self initializeQueryTypesDropList.
	self initializeQueryCode.
	self initializeResultList.
	self initializeQueryConfigurationPresenter
]

{ #category : #initialization }
FQQueryCreationPresenter >> initializeQueryCode [
	queryCode := self newCode
		whenTextIsAcceptedDo: [ :code | self updateForAcceptedCode: code ];
		withoutSyntaxHighlight;
		yourself
]

{ #category : #initialization }
FQQueryCreationPresenter >> initializeQueryConfigurationPresenter [
	queryTypesDropList selectIndex: 1
]

{ #category : #initialization }
FQQueryCreationPresenter >> initializeQueryTypesDropList [
	queryTypesDropList := self newDropList
		items: self class queryConfigurationPresenters;
		display: [ :presenter | presenter label ];
		whenSelectedItemChangedDo: [ :presenter | self update: presenter ]
]

{ #category : #initialization }
FQQueryCreationPresenter >> initializeResultList [
	resultListTitle := self newLabel label: 'Query result'.
	resultList := self newList
		display: #name;
		yourself
]

{ #category : #initialization }
FQQueryCreationPresenter >> initializeRoassalSequence [
	sequence := (FQRoassalSequence
		on: browser selectedQuery parentSequence)
		shapeColor: [ :model | model class color ];
		shapeLabel: [ :model | model roassalLabel substrings first ]
]

{ #category : #initialization }
FQQueryCreationPresenter >> initializeWindow: aWindowPresenter [
	super initializeWindow: aWindowPresenter.
	aWindowPresenter initialExtent: 550 @ 400
]

{ #category : #accessing }
FQQueryCreationPresenter >> projectPrefix [
	^ 'FQ'
]

{ #category : #'accessing model' }
FQQueryCreationPresenter >> setModelBeforeInitialization: aQueriesPresenter [
	browser := aQueriesPresenter
]

{ #category : #transmissions }
FQQueryCreationPresenter >> transmitAcceptedQuery [
	queryConfigurationPresenter
		transmitPort: #acceptedQuery
		do: [ :query | 
			browser updateForQuery: query.
			self window close ]
]

{ #category : #transmissions }
FQQueryCreationPresenter >> transmitFromCodeToConfig [
	self
		flag:
			#FQSpecPb
				,
					'Bug in spec transmission from SpCodePresenter. 
	FQCodeAcceptedPort is ready to accept a transmission'
	"queryCode transmitTo: queryConfigurationPresenter"
]

{ #category : #transmissions }
FQQueryCreationPresenter >> transmitFromConfigToCode [
	queryConfigurationPresenter
		transmitTo: queryCode
		transform: [ :queryBuilder | 
			queryCode syntaxHighlight: queryBuilder queryIsValid.
			queryBuilder codeToDisplay ]
]

{ #category : #transmissions }
FQQueryCreationPresenter >> transmitFromConfigToResultList [
	queryConfigurationPresenter
		transmitTo: resultList
		transform: [ :queryBuilder | 
			| result |
			result := queryBuilder applyQuery.
			result
				ifEmpty: [ resultList headerTitle: 'No entities to show' ]
				ifNotEmpty: [ resultList headerTitle: (browser mooseGroupDetails: result) ].
			result ]
]

{ #category : #transmissions }
FQQueryCreationPresenter >> transmitFromConfigToSequence [
	queryConfigurationPresenter
		transmitTo: sequence
		transform: [ :queryBuilder | queryBuilder query ]
]

{ #category : #update }
FQQueryCreationPresenter >> update: aPresenterClass [
	self updateConfigurationPresenter: aPresenterClass.
	self updateToolBar.
	self updateTransmissions.
	queryConfigurationPresenter notifyQueryChanged.
	self update
]

{ #category : #update }
FQQueryCreationPresenter >> updateConfigurationPresenter: aPresenterClass [
	queryConfigurationPresenter := aPresenterClass
		owner: self
		on: self entities
]

{ #category : #update }
FQQueryCreationPresenter >> updateForAcceptedCode: code [
	queryConfigurationPresenter updateForQueryCode: code.
	queryCode
		text: queryConfigurationPresenter queryBuilder codeToDisplay.
	self
		flag:
			#FQSpecPb ,
			'This should go through transmissions but TextChangedPort is buggy in Spec for now. 
			FQCodeAcceptedPort is ready to accept a transmission'
]

{ #category : #update }
FQQueryCreationPresenter >> updateToolBar [
	toolBar fillWith: self rootCommandsGroup
]

{ #category : #update }
FQQueryCreationPresenter >> updateTransmissions [
	self transmitFromConfigToCode.
	self transmitFromConfigToSequence.
	self transmitFromConfigToResultList.
	self transmitAcceptedQuery
]
