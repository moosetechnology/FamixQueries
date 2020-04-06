Class {
	#name : #FQPropertyQueriesPresenter,
	#superclass : #FQQueryConfigurationPresenter,
	#instVars : [
		'queryParameters',
		'propertyType',
		'helper',
		'configurationPresenterClasses'
	],
	#category : #'Famix-Queries-Browser-Presenters'
}

{ #category : #specs }
FQPropertyQueriesPresenter class >> defaultSpec [
	^ SpBoxLayout newHorizontal
		add: #propertyType;
		add: #queryParameters width: 200;
		add: self creationButton;
		spacing: 5;
		yourself
]

{ #category : #'instance creation' }
FQPropertyQueriesPresenter class >> open [
	<script>
	(self on: FQPropertyQueriesModel default) openWithSpec
]

{ #category : #specs }
FQPropertyQueriesPresenter class >> title [
	^ 'Property Query'
]

{ #category : #initialization }
FQPropertyQueriesPresenter >> adaptConfigurationPresenterFor: aPropertype [
	queryBuilder buildPropertyQueryTyped: aPropertype.
	queryParameters := (configurationPresenterClasses at: aPropertype)
		on: queryBuilder.
	self needRebuild: false.
	self buildWithSpec
]

{ #category : #initialization }
FQPropertyQueriesPresenter >> initialize [
	super initialize.
	self initializeConfigurationClasses
]

{ #category : #initialization }
FQPropertyQueriesPresenter >> initializeConfigurationClasses [
	configurationPresenterClasses := Dictionary
		newFromPairs:
			{#boolean.
			FQBooleanQueryConfigurationPresenter.
			#number.
			FQNumericQueryConfigurationPresenter.
			#string.
			FQStringQueryConfigurationPresenter}
]

{ #category : #initialization }
FQPropertyQueriesPresenter >> initializeHelper [
	helper := FQPropertyQueriesPresenterHelper new
		entities: owner entities;
		yourself
]

{ #category : #initialization }
FQPropertyQueriesPresenter >> initializeOnBooleanQuery [
	queryBuilder buildPropertyQueryTyped: #boolean.
	self adaptConfigurationPresenterFor: #boolean
]

{ #category : #initialization }
FQPropertyQueriesPresenter >> initializePresenters [
	super initializePresenters.
	self initializeQueryTypeRadioButtons.
	self initializeConfigurationClasses.
	self initializeOnBooleanQuery
]

{ #category : #initialization }
FQPropertyQueriesPresenter >> initializeQueryParameters [
	self initializeConfigurationClasses.
	self adaptConfigurationPresenterFor: #boolean
]

{ #category : #initialization }
FQPropertyQueriesPresenter >> initializeQueryTypeRadioButtons [
	propertyType := SpDynamicPresentersListBuilder new
		modelObjects: queryBuilder propertyTypes;
		presenter: SpRadioButtonPresenter
			configuredAs: [ :presenter :modelObject | 
			presenter
				label: modelObject asString capitalized;
				whenActivatedDo: [ self updateQueryParameters: modelObject ];
				yourself ];
		layoutBuilder: (SpDynamicTopToBottomRowsLayout rows: 1);
		build.
	propertyType presenters first
		associatedRadioButtons: propertyType presenters allButFirst
]

{ #category : #accessing }
FQPropertyQueriesPresenter >> queryParameters [
	^ queryParameters
]

{ #category : #accessing }
FQPropertyQueriesPresenter >> queryParameters: anObject [
	queryParameters := anObject
]

{ #category : #initialization }
FQPropertyQueriesPresenter >> rebuildLayoutWith: sublayout [
	self flag: 'Magic numbers'.
	layout := SpBoxLayout newHorizontal
		add: #propertyType;
		add: sublayout width: 200;
		add: self class creationButton;
		spacing: 5;
		yourself.
	self needRebuild: false.
	self buildWithSpec
]

{ #category : #initialization }
FQPropertyQueriesPresenter >> updateQueryParameters: aQueryType [
	self adaptConfigurationPresenterFor: aQueryType
	"	| sublayout |
	self flag: 'Magic numbers'.
	queryBuilder buildPropertyQueryTyped: aQueryType.
	sublayout := SpBoxLayout newVertical
		borderWidth: 13;
		spacing: 14;
		yourself.
	(helper configuratorFor: aQueryType)
		do: [ :configurator | 
			| newPresenter |
			newPresenter := self instantiate: configurator presenterClass.
			configurator configurePresenter: newPresenter.
			sublayout
				add: newPresenter
				withConstraints: configurator layoutConstraints ].
	self rebuildLayoutWith: sublayout"
]
