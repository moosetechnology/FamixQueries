Class {
	#name : #FQPropertyQueriesPresenter,
	#superclass : #FQQueryConfigurationPresenter,
	#instVars : [
		'propertyTypeRadioButtons',
		'queryParametersPresenter'
	],
	#category : #'Famix-Queries-Browser-Presenters'
}

{ #category : #specs }
FQPropertyQueriesPresenter class >> defaultSpec [
	^ SpBoxLayout newHorizontal
		add: #propertyTypeRadioButtons;
		add: #queryParametersPresenter width: 200;
		add: self creationButton;
		spacing: 5;
		yourself
]

{ #category : #'instance creation' }
FQPropertyQueriesPresenter class >> open [
	<script>
	(self on: FQQueryBuilder default) openWithSpec
]

{ #category : #accessing }
FQPropertyQueriesPresenter class >> propertyQueryConfigurationPresenters [
	^ FQPropertyQueryParametersPresenter allSubclasses
]

{ #category : #initialization }
FQPropertyQueriesPresenter class >> queryBuilderClass [
	^ self propertyQueryConfigurationPresenters first queryBuilderClass
]

{ #category : #accessing }
FQPropertyQueriesPresenter class >> queryClass [
	^ FQPropertyQuery
]

{ #category : #specs }
FQPropertyQueriesPresenter class >> title [
	^ 'Property Query'
]

{ #category : #'widgets configuration' }
FQPropertyQueriesPresenter >> configureRadioButton: radioButton forSubPresenter: configurationPresenterClass [
	radioButton
		label: configurationPresenterClass queryClass label;
		whenActivatedDo:
				[ self updateQueryParametersPresenter: configurationPresenterClass ]
]

{ #category : #initialization }
FQPropertyQueriesPresenter >> initializePresenters [
	super initializePresenters.
	self initializeQueryTypeRadioButtons.
	self
		updateQueryParametersPresenter: FQBooleanQueryParametersPresenter
]

{ #category : #initialization }
FQPropertyQueriesPresenter >> initializeQueryTypeRadioButtons [
	propertyTypeRadioButtons := SpDynamicPresentersListBuilder new
		modelObjects: self class propertyQueryConfigurationPresenters;
		presenter: SpRadioButtonPresenter
			configuredAs: [ :radioButton :configurationPresenterClass | 
			self
				configureRadioButton: radioButton
				forSubPresenter: configurationPresenterClass ];
		layoutBuilder: (SpDynamicTopToBottomRowsLayout rows: 1);
		build.
	propertyTypeRadioButtons presenters first
		associatedRadioButtons: propertyTypeRadioButtons presenters allButFirst
]

{ #category : #update }
FQPropertyQueriesPresenter >> updateQueryBuilderFor: aPropertyQueryParametersPresenterClass [
	queryBuilder := aPropertyQueryParametersPresenterClass
		queryBuilderClass newWithEntities: queryBuilder entities
]

{ #category : #update }
FQPropertyQueriesPresenter >> updateQueryParametersPresenter: aPropertyQueryParametersPresenterClass [
	self updateQueryBuilderFor: aPropertyQueryParametersPresenterClass.
	queryParametersPresenter := aPropertyQueryParametersPresenterClass
		owner: self
		on: queryBuilder.
	self needRebuild: false.
	self buildWithSpec
]
