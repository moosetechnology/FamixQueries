Class {
	#name : #FQQueryConfigurationPresenter,
	#superclass : #SpPresenter,
	#instVars : [
		'#queryBuilder',
		'#query => SpObservableSlot',
		'#firstParameter',
		'#secondParameter'
	],
	#category : #'Famix-Queries-Browser-Presenters'
}

{ #category : #specs }
FQQueryConfigurationPresenter class >> addFirstParameterToLayout: defaultLayout [
	"Override for specific constraints"

	defaultLayout add: #firstParameter
]

{ #category : #specs }
FQQueryConfigurationPresenter class >> addSecondParameterToLayout: defaultLayout [
	"Override for specific constraints"

	defaultLayout add: #secondParameter
]

{ #category : #specs }
FQQueryConfigurationPresenter class >> defaultSpec [
	| defaultLayout |
	defaultLayout := SpBoxLayout newHorizontal.
	self addFirstParameterToLayout: defaultLayout.
	self addSecondParameterToLayout: defaultLayout.
	^ defaultLayout
]

{ #category : #initialization }
FQQueryConfigurationPresenter class >> label [
	^ self queryBuilderClass queryClass label
]

{ #category : #initialization }
FQQueryConfigurationPresenter class >> queryBuilderClass [
	^ self subclassResponsibility
]

{ #category : #'as yet unclassified' }
FQQueryConfigurationPresenter class >> traitPrefix [
	^ 'FamixT'
]

{ #category : #initialization }
FQQueryConfigurationPresenter >> initialize [
	super initialize.
]

{ #category : #accessing }
FQQueryConfigurationPresenter >> modelPrefix [
	^ queryBuilder entities first mooseModel className
		withoutSuffix: 'Model'
]

{ #category : #update }
FQQueryConfigurationPresenter >> noParameterMessage: aParameterName [
	^ self instantiate: FQNoPossibleQueryPresenter on: aParameterName
]

{ #category : #transmissions }
FQQueryConfigurationPresenter >> notifyQueryChanged [
	self notifyPropertyChanged: #query
]

{ #category : #accessing }
FQQueryConfigurationPresenter >> query [
	^ queryBuilder query
]

{ #category : #accessing }
FQQueryConfigurationPresenter >> queryBuilder [
	^ queryBuilder
]

{ #category : #transmissions }
FQQueryConfigurationPresenter >> queryChangedPort [
	^ FQQueryOutputPort newPresenter: self
]

{ #category : #initialization }
FQQueryConfigurationPresenter >> setModelBeforeInitialization: aQuery [
	queryBuilder := [ self class queryBuilderClass
		newWithParentQuery: aQuery ]
		on: FQImpossibleQuery
		do: [ :error | error builder ].
	self flag: #ImpossibleQuery
]

{ #category : #transmissions }
FQQueryConfigurationPresenter >> transmitInitialConfiguration [
	self notifyQueryChanged
]

{ #category : #update }
FQQueryConfigurationPresenter >> updateForQueryCode: newQueryCode [
	self flag: #FQImprove , 'TODO: Match with modified code'.
	queryBuilder updateForQueryCode: newQueryCode
]
