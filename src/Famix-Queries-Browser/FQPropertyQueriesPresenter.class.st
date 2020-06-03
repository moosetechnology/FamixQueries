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

{ #category : #accessing }
FQPropertyQueriesPresenter class >> propertyQueryTypes [
	^ FQPropertyQuery allSubclasses
]

{ #category : #running }
FQPropertyQueriesPresenter class >> queryClass [
	^ FQPropertyQuery
]

{ #category : #specs }
FQPropertyQueriesPresenter class >> title [
	^ 'Property Query'
]

{ #category : #update }
FQPropertyQueriesPresenter >> configureBooleanQuery: aQuery [
	secondParameter := aQuery isValid
		ifTrue: [ self instantiate: FQBooleanQueryParametersPresenter ]
		ifFalse: [ self noParameterMessage: 'Boolean property' ]
]

{ #category : #update }
FQPropertyQueriesPresenter >> configureNumericQuery: aQuery [
	secondParameter := aQuery isValid
		ifTrue: [ self instantiate: FQNumericQueryParametersPresenter ]
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
		ifTrue: [ self instantiate: FQStringQueryParametersPresenter ]
		ifFalse: [ self noParameterMessage: 'String property' ]
]

{ #category : #accessing }
FQPropertyQueriesPresenter >> defaultQuery [
	^ FQBooleanQuery defaultForParent: parentQuery
]

{ #category : #initialization }
FQPropertyQueriesPresenter >> initializePresenters [
	self initializeQueryTypeRadioButtons.
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
	self flag: #FQRefactor , 'Is this update necessary ?'
]
