Class {
	#name : #FQPropertyQueriesPresenter,
	#superclass : #FQQueryConfigurationPresenter,
	#instVars : [
		'queryParameters',
		'propertyType'
	],
	#category : #'Famix-Queries-Browser-Presenters'
}

{ #category : #specs }
FQPropertyQueriesPresenter class >> defaultSpec [
	^ SpBoxLayout newHorizontal
		add: #propertyType;
		add: #queryParameters;
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
FQPropertyQueriesPresenter >> initializePresenters [
	super initializePresenters.
	self initializeQueryTypeRadioButtons.
	queryParameters := self newNullPresenter.
	self initializeQueryParameters
]

{ #category : #initialization }
FQPropertyQueriesPresenter >> initializeQueryParameters [
	self updateQueryParameters: #boolean
]

{ #category : #initialization }
FQPropertyQueriesPresenter >> initializeQueryTypeRadioButtons [
	propertyType := SpDynamicPresentersListBuilder new
		modelObjects: queryBuilder propertiesTypes;
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
	| sublayout |
	self flag: 'Magic numbers'.
	queryBuilder newQueryTyped: aQueryType.
	sublayout := SpBoxLayout newVertical
		borderWidth: 13;
		spacing: 14;
		yourself.
	(queryBuilder parametersDict at: aQueryType)
		do: [ :configurator | 
			| newPresenter |
			newPresenter := self instantiate: configurator presenterClass.
			configurator configurePresenter: newPresenter.
			sublayout
				add: newPresenter
				withConstraints: configurator layoutConstraints ].
	self rebuildLayoutWith: sublayout
]
