Class {
	#name : #FQQueryConfigurationPresenter,
	#superclass : #SpPresenter,
	#instVars : [
		'creationButton',
		'queryBuilder'
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
FQQueryConfigurationPresenter class >> paddingAroundButton [
	"Should be changed if FQBrowserPresenter>>queryConfigurationHeight is changed"

	^ 50
]

{ #category : #accessing }
FQQueryConfigurationPresenter >> button [
	^ creationButton
]

{ #category : #initialization }
FQQueryConfigurationPresenter >> defineOutputPorts [
	^ {FQNewQueryPort new}
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

{ #category : #accessing }
FQQueryConfigurationPresenter >> queryBuilder [
	^ queryBuilder
]

{ #category : #initialization }
FQQueryConfigurationPresenter >> setModelBeforeInitialization: aModel [
	queryBuilder := aModel
]
