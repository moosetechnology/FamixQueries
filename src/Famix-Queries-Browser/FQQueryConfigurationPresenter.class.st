Class {
	#name : #FQQueryConfigurationPresenter,
	#superclass : #SpPresenter,
	#instVars : [
		'#creationButton',
		'#queryBuilder',
		'#queryHasChanged => SpObservableSlot'
	],
	#category : #'Famix-Queries-Browser-Presenters'
}

{ #category : #specs }
FQQueryConfigurationPresenter class >> creationButton [
	^ SpBoxLayout newVertical
		add: #creationButton
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
	^ creationButton
]

{ #category : #transmissions }
FQQueryConfigurationPresenter >> codeToDisplay [
	^ queryBuilder createQuery
]

{ #category : #initialization }
FQQueryConfigurationPresenter >> defineOutputPorts [
	^ {FQQueryHasChangedPort new.
	FQNewQueryPort new}
]

{ #category : #initialization }
FQQueryConfigurationPresenter >> initializePresenters [
	"Transmission defined in FQNewQueryPort"

	creationButton := self newButton
		label: 'Create query';
		yourself
]

{ #category : #accessing }
FQQueryConfigurationPresenter >> modelPrefix [
	^ queryBuilder entities first mooseModel className
		withoutSuffix: 'Model'
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
	queryBuilder := self class queryBuilderClass
		newWithEntities: entities
]

{ #category : #transmissions }
FQQueryConfigurationPresenter >> transmitInitialConfiguration [
	self notifyQueryChanged
]
