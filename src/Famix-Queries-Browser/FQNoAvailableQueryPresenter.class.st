Class {
	#name : #FQNoAvailableQueryPresenter,
	#superclass : #FQQueryConfigurationPresenter,
	#instVars : [
		'displayText',
		'textToDisplay',
		'null1',
		'null2'
	],
	#category : #'Famix-Queries-Browser-Presenters'
}

{ #category : #specs }
FQNoAvailableQueryPresenter class >> defaultSpec [
	^ SpBoxLayout newHorizontal
		add:
			(SpBoxLayout newVertical
				add: #null1;
				add: #displayText height: self buttonHeight;
				add: #null2;
				yourself);
		add: self creationButton width: 150;
		yourself
]

{ #category : #transmissions }
FQNoAvailableQueryPresenter >> codeToDisplay [
	^ 'No query to display'
]

{ #category : #initialization }
FQNoAvailableQueryPresenter >> initializePresenters [
	super initializePresenters.
	creationButton disable.
	displayText := self newLabel
		label: textToDisplay;
		yourself.
	null1 := self newNullPresenter.
	null2 := self newNullPresenter
]

{ #category : #initialization }
FQNoAvailableQueryPresenter >> setModelBeforeInitialization: aText [
	textToDisplay := aText
]
