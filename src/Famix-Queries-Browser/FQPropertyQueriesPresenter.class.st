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

{ #category : #'instance creation' }
FQPropertyQueriesPresenter class >> open [
	"This is a workaround for Iceberg bug"

	
]

{ #category : #accessing }
FQPropertyQueriesPresenter class >> propertyQueryConfigurationPresenters [
	^ FQPropertyQueryParametersPresenter allSubclasses
]

{ #category : #accessing }
FQPropertyQueriesPresenter class >> propertyQueryTypes [
	^ FQPropertyQuery allSubclasses
]

{ #category : #initialization }
FQPropertyQueriesPresenter class >> queryClass [
	^ FQPropertyQuery
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

{ #category : #update }
FQPropertyQueriesPresenter >> configureBooleanQuery: aQuery [
	secondParameter := aQuery isValid
		ifTrue: [ FQBooleanQueryParametersPresenter owner: self on: aQuery ]
		ifFalse: [ self noParameterMessage: 'Boolean property' ]
]

{ #category : #update }
FQPropertyQueriesPresenter >> configureNumericQuery: aQuery [
	secondParameter := aQuery isValid
		ifTrue: [ FQNumericQueryParametersPresenter owner: self on: aQuery ]
		ifFalse: [ self noParameterMessage: 'Numeric property' ]
]

{ #category : #'widgets configuration' }
FQPropertyQueriesPresenter >> configureRadioButton: radioButton forQueryClass: queryClass [
	radioButton
		label: queryClass label substrings first;
		whenActivatedDo: [ self updateForQuery: (queryClass defaultForParent: query parent) ]
]

{ #category : #update }
FQPropertyQueriesPresenter >> configureStringQuery: aQuery [
	secondParameter := aQuery isValid
		ifTrue: [ FQStringQueryParametersPresenter owner: self on: aQuery ]
		ifFalse: [ self noParameterMessage: 'String property' ]
]

{ #category : #initialization }
FQPropertyQueriesPresenter >> defaultQuery [
	^ FQBooleanQuery defaultForParent: parentQuery
]

{ #category : #initialization }
FQPropertyQueriesPresenter >> initializePresenters [
	self initializeQueryTypeRadioButtons.
	"self
		updateQueryParametersPresenter: FQBooleanQueryParametersPresenter"
	self updateForQuery: self query
]

{ #category : #initialization }
FQPropertyQueriesPresenter >> initializeQueryTypeRadioButtons [
	firstParameter := SpDynamicPresentersListBuilder new
		modelObjects: self class propertyQueryTypes;
		presenter: SpRadioButtonPresenter
			configuredAs:
				[ :radioButton :queryClass | self configureRadioButton: radioButton forQueryClass: queryClass ];
		layoutBuilder: (SpDynamicTopToBottomRowsLayout rows: 1);
		build.
	firstParameter presenters first
		associatedRadioButtons: firstParameter presenters allButFirst
]

{ #category : #update }
FQPropertyQueriesPresenter >> updateForQuery: aQuery [
	query := aQuery.
	aQuery configureIn: self.
	self notifyQueryChanged.
	self update.
	self flag: #FQRefactor , 'Is this necessary ?'
]
