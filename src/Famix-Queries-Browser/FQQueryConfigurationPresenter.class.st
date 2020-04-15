Class {
	#name : #FQQueryConfigurationPresenter,
	#superclass : #SpPresenter,
	#instVars : [
		'#queryBuilder',
		'#queryHasChanged => SpObservableSlot',
		'#acceptedQuery => SpObservableSlot',
		'#applyQueryButton'
	],
	#category : #'Famix-Queries-Browser-Presenters'
}

{ #category : #specs }
FQQueryConfigurationPresenter class >> creationButton [
	^ SpBoxLayout newVertical
		add: #applyQueryButton
			expand: true
			fill: true
			padding: self paddingAroundButton;
		yourself
]

{ #category : #specs }
FQQueryConfigurationPresenter class >> defaultSpec [
	^ self subclassResponsibility
]

{ #category : #initialization }
FQQueryConfigurationPresenter class >> label [
	^ self queryBuilderClass queryClass label
]

{ #category : #'instance creation' }
FQQueryConfigurationPresenter class >> open [
	(self on: FQBrowserPresenter classesAndMethods) openWithSpec
]

{ #category : #specs }
FQQueryConfigurationPresenter class >> paddingAroundButton [
	"Should be changed if FQBrowserPresenter>>queryConfigurationHeight is changed"

	^ 50
]

{ #category : #initialization }
FQQueryConfigurationPresenter class >> queryBuilderClass [
	^ self subclassResponsibility
]

{ #category : #accessing }
FQQueryConfigurationPresenter >> button [
	^ applyQueryButton
]

{ #category : #initialization }
FQQueryConfigurationPresenter >> defineInputPorts [
	^ {FQCodeAcceptedPort new}
]

{ #category : #initialization }
FQQueryConfigurationPresenter >> defineOutputPorts [
	^ {FQQueryHasChangedPort new.
	FQAcceptedQueryPort new}
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
FQQueryConfigurationPresenter >> notifyAcceptedQuery [
	self notifyPropertyChanged: #acceptedQuery
]

{ #category : #transmissions }
FQQueryConfigurationPresenter >> notifyQueryChanged [
	self notifyPropertyChanged: #queryHasChanged
]

{ #category : #accessing }
FQQueryConfigurationPresenter >> queryBuilder [
	^ queryBuilder
]

{ #category : #initialization }
FQQueryConfigurationPresenter >> setModelBeforeInitialization: entities [
	queryBuilder := [ self class queryBuilderClass
		newWithEntities: entities ]
		on: ImpossibleQuery
		do: [ :error | error builder ]
]

{ #category : #transmissions }
FQQueryConfigurationPresenter >> transmitInitialConfiguration [
	self notifyQueryChanged
]

{ #category : #update }
FQQueryConfigurationPresenter >> updateForQueryCode: newQueryCode [
	self flag: 'TODO: Match with modified code'.
	queryBuilder updateForQueryCode: newQueryCode
]
