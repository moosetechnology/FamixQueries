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
		yourself
]

{ #category : #initialization }
FQPropertyQueriesPresenter class >> label [ 
	^ FQAbstractPropertyQueryBuilder queryClass label
]

{ #category : #'instance creation' }
FQPropertyQueriesPresenter class >> open [
	<script>
	super open
]

{ #category : #accessing }
FQPropertyQueriesPresenter class >> propertyQueryConfigurationPresenters [
	^ FQPropertyQueryParametersPresenter allSubclasses
]

{ #category : #initialization }
FQPropertyQueriesPresenter class >> queryBuilderClass [
	^ self propertyQueryConfigurationPresenters first queryBuilderClass
]

{ #category : #specs }
FQPropertyQueriesPresenter class >> title [
	^ 'Property Query'
]

{ #category : #'widgets configuration' }
FQPropertyQueriesPresenter >> configureRadioButton: radioButton forSubPresenter: configurationPresenterClass [
	radioButton
		label: configurationPresenterClass label;
		whenActivatedDo: [ self updateQueryParametersPresenter: configurationPresenterClass.
			self notifyQueryChanged ]
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
	queryBuilder := [ aPropertyQueryParametersPresenterClass
		queryBuilderClass newWithEntities: queryBuilder entities ]
		on: ImpossibleQuery
		do: [ :error | error builder ]
]

{ #category : #update }
FQPropertyQueriesPresenter >> updateQueryParametersPresenter: aPropertyQueryParametersPresenterClass [
	self updateQueryBuilderFor: aPropertyQueryParametersPresenterClass.
	queryParametersPresenter := queryBuilder queryIsValid
		ifTrue: [ aPropertyQueryParametersPresenterClass owner: self on: queryBuilder ]
		ifFalse: [ self
				instantiate: FQNoPossibleQueryPresenter
				on: aPropertyQueryParametersPresenterClass label , ' property ' ].
	self update
]
