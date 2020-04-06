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
FQPropertyQueriesPresenter >> adaptQueryParametersPresenterFor: aPropertype [
	queryBuilder buildPropertyQueryTyped: aPropertype.
	queryParameters := (configurationPresenterClasses at: aPropertype)
		on: queryBuilder.
	self needRebuild: false.
	self buildWithSpec
]

{ #category : #initialization }
FQPropertyQueriesPresenter >> initializeBuilder [
	queryBuilder buildPropertyQueryTyped: #boolean
]

{ #category : #initialization }
FQPropertyQueriesPresenter >> initializeConfigurationClasses [
	configurationPresenterClasses := Dictionary
		newFromPairs:
			{#boolean.
			FQBooleanQueryParametersPresenter.
			#number.
			FQNumericQueryParametersPresenter.
			#string.
			FQStringQueryParametersPresenter}
]

{ #category : #initialization }
FQPropertyQueriesPresenter >> initializePresenters [
	super initializePresenters.
	self initializeConfigurationClasses.
	self initializeQueryTypeRadioButtons
]

{ #category : #initialization }
FQPropertyQueriesPresenter >> initializeQueryTypeRadioButtons [
	propertyType := SpDynamicPresentersListBuilder new
		modelObjects: queryBuilder propertyTypes;
		presenter: SpRadioButtonPresenter
			configuredAs: [ :presenter :modelObject | 
			presenter
				label: modelObject asString capitalized;
				whenActivatedDo: [ self adaptQueryParametersPresenterFor: modelObject ];
				yourself ];
		layoutBuilder: (SpDynamicTopToBottomRowsLayout rows: 1);
		build.
	propertyType presenters first
		associatedRadioButtons: propertyType presenters allButFirst.
		
	self adaptQueryParametersPresenterFor: #boolean
]
