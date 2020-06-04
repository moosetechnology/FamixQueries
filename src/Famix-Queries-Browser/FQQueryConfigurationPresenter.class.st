Class {
	#name : #FQQueryConfigurationPresenter,
	#superclass : #SpPresenter,
	#instVars : [
		'query',
		'firstParameter',
		'secondParameter'
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

{ #category : #running }
FQQueryConfigurationPresenter class >> queryClass [
	^ self subclassResponsibility
]

{ #category : #accessing }
FQQueryConfigurationPresenter class >> traitPrefix [
	^ 'FamixT'
]

{ #category : #accessing }
FQQueryConfigurationPresenter >> modelPrefix [
	^ query parent result first mooseModel className
		withoutSuffix: 'Model'
]

{ #category : #update }
FQQueryConfigurationPresenter >> noParameterMessage: aParameterName [
	^ self instantiate: FQNoPossibleQueryPresenter on: aParameterName
]

{ #category : #transmissions }
FQQueryConfigurationPresenter >> notifyQueryChanged [
	owner updateFromConfiguration
]

{ #category : #accessing }
FQQueryConfigurationPresenter >> query [
	^ query
]

{ #category : #transmissions }
FQQueryConfigurationPresenter >> queryChangedPort [
	self flag: #FQUnused.
	^ FQQueryOutputPort newPresenter: self
]

{ #category : #'accessing model' }
FQQueryConfigurationPresenter >> setModelBeforeInitialization: aQuery [
	query := aQuery
]

{ #category : #update }
FQQueryConfigurationPresenter >> updateForQuery: aQuery [
	query := aQuery
]
