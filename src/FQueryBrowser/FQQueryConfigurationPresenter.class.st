Class {
	#name : #FQQueryConfigurationPresenter,
	#superclass : #SpPresenter,
	#instVars : [
		'creationButton',
		'model'
	],
	#category : #'FQueryBrowser-Presenters'
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
FQQueryConfigurationPresenter >> model [
	^ model
]

{ #category : #initialization }
FQQueryConfigurationPresenter >> setModelBeforeInitialization: aModel [
	model := aModel
]
