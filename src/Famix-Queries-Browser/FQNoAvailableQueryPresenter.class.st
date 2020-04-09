Class {
	#name : #FQNoAvailableQueryPresenter,
	#superclass : #FQQueryConfigurationPresenter,
	#instVars : [
		'displayText',
		'textToDisplay'
	],
	#category : #'Famix-Queries-Browser-Presenters'
}

{ #category : #specs }
FQNoAvailableQueryPresenter class >> defaultSpec [
	^ SpBoxLayout newHorizontal
		beNotHomogeneous;
		add: #displayText;
		add: self creationButton;
		spacing: 5;
		yourself
]

{ #category : #transmissions }
FQNoAvailableQueryPresenter >> codeToDisplay [
	^ ''
]

{ #category : #initialization }
FQNoAvailableQueryPresenter >> initializePresenters [
	super initializePresenters.
	creationButton disable.
	displayText := self newText
		text: textToDisplay;
		yourself
]

{ #category : #initialization }
FQNoAvailableQueryPresenter >> setModelBeforeInitialization: aText [
	textToDisplay := aText
]
