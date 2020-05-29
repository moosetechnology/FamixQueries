Class {
	#name : #FQQueryConfigurationPresenter,
	#superclass : #SpPresenter,
	#instVars : [
		'#query => SpObservableSlot',
		'#firstParameter',
		'#secondParameter',
		'#parentQuery'
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
FQQueryConfigurationPresenter class >> queryClass [
	^ self subclassResponsibility
]

{ #category : #initialization }
FQQueryConfigurationPresenter >> defaultQuery [
	^ self class queryClass defaultForParent: parentQuery
]

{ #category : #initialization }
FQQueryConfigurationPresenter >> initialize [
	"	self class initializeSlots: self.
	query := self defaultQuery.
	needRebuild := true.
	visible := true.
	self initializePrivateAnnouncer.
	self initializePrivateValueHolders.
	self initializePrivateHooks.
	self initializePrivateAnnouncements"

	super initialize.
	query := self defaultQuery
]

{ #category : #accessing }
FQQueryConfigurationPresenter >> modelPrefix [
	^ parentQuery result first mooseModel className
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
	self flag: #FQImprove , 'Bug source !'.
	^ query ifNil: [ self defaultQuery ]
]

{ #category : #transmissions }
FQQueryConfigurationPresenter >> queryChangedPort [
	^ FQQueryOutputPort newPresenter: self
]

{ #category : #initialization }
FQQueryConfigurationPresenter >> setModelBeforeInitialization: aParentQuery [
	parentQuery := aParentQuery
]

{ #category : #transmissions }
FQQueryConfigurationPresenter >> transmitInitialConfiguration [
	self notifyQueryChanged
]

{ #category : #update }
FQQueryConfigurationPresenter >> updateForQuery: aQuery [
	query := aQuery
]
