Class {
	#name : #FQPropertyQueriesPresenter,
	#superclass : #FQQueryConfigurationPresenter,
	#category : #'Famix-Queries-Browser-Presenters'
}

{ #category : #specs }
FQPropertyQueriesPresenter class >> addSecondParameterToLayout: defaultLayout [
	"Override for specific constraints"

	defaultLayout add: #secondParameter width: 200
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
FQPropertyQueriesPresenter class >> secondParameterLayout [
	"Override for specific constraints"

	layout add: #secondParameter width: 200
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
	firstParameter := SpDynamicPresentersListBuilder new
		modelObjects: self class propertyQueryConfigurationPresenters;
		presenter: SpRadioButtonPresenter
			configuredAs: [ :radioButton :configurationPresenterClass | 
			self
				configureRadioButton: radioButton
				forSubPresenter: configurationPresenterClass ];
		layoutBuilder: (SpDynamicTopToBottomRowsLayout rows: 1);
		build.
	firstParameter presenters first
		associatedRadioButtons: firstParameter presenters allButFirst
]

{ #category : #update }
FQPropertyQueriesPresenter >> updateQueryBuilderFor: aPropertyQueryParametersPresenterClass [
	queryBuilder := [ aPropertyQueryParametersPresenterClass
		queryBuilderClass newWithEntities: queryBuilder entities ]
		on: ImpossibleQuery
		do: [ :error | error builder ]
]

{ #category : #update }
FQPropertyQueriesPresenter >> updateQueryParametersPresenter: aParameterPresenterClass [
	
	self updateQueryBuilderFor: aParameterPresenterClass.
	
	secondParameter := queryBuilder queryIsValid
		ifTrue: [ aParameterPresenterClass owner: self on: queryBuilder ]
		ifFalse: [ self noParameterMessage: aParameterPresenterClass label , ' property ' ].

	self update
]
