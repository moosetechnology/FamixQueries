Class {
	#name : #FQPropertyQueriesPresenter,
	#superclass : #FQQueryConfigurationPresenter,
	#instVars : [
		'queryParameters',
		'propertyType',
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
	(self on: FQQueryBuilder default) openWithSpec
]

{ #category : #specs }
FQPropertyQueriesPresenter class >> title [
	^ 'Property Query'
]

{ #category : #initialization }
FQPropertyQueriesPresenter >> adaptQueryParametersPresenterFor: aPropertyQueryClass [
	queryBuilder buildPropertyQuery: aPropertyQueryClass.
	queryParameters := aPropertyQueryClass configurationPresenter
		owner: self
		on: queryBuilder.
	self needRebuild: false.
	self buildWithSpec
]

{ #category : #initialization }
FQPropertyQueriesPresenter >> initializeBuilder [
	queryBuilder buildPropertyQuery
]

{ #category : #initialization }
FQPropertyQueriesPresenter >> initializePresenters [
	super initializePresenters.
	self initializeQueryTypeRadioButtons
]

{ #category : #initialization }
FQPropertyQueriesPresenter >> initializeQueryTypeRadioButtons [
	propertyType := SpDynamicPresentersListBuilder new
		modelObjects: queryBuilder availablePropertyQueryTypes;
		presenter: SpRadioButtonPresenter
			configuredAs: [ :presenter :modelObject | 
			presenter
				label: modelObject label;
				whenActivatedDo: [ self adaptQueryParametersPresenterFor: modelObject ];
				yourself ];
		layoutBuilder: (SpDynamicTopToBottomRowsLayout rows: 1);
		build.
	propertyType presenters first
		associatedRadioButtons: propertyType presenters allButFirst.
	self adaptQueryParametersPresenterFor: FQBooleanQuery
]
