Class {
	#name : #FQNoPossibleQueryPresenter,
	#superclass : #SpPresenter,
	#instVars : [
		'textToDisplay',
		'label',
		'null1',
		'null2'
	],
	#category : #'Famix-Queries-Browser-Widgets'
}

{ #category : #specs }
FQNoPossibleQueryPresenter class >> defaultSpec [
	^ SpBoxLayout newHorizontal
		add:
			(SpBoxLayout newVertical
				add: #null1;
				add: #label;
				add: #null2;
				yourself)
			width: 175;
		yourself
]

{ #category : #initialization }
FQNoPossibleQueryPresenter >> initializePresenters [
	label := self newLabel
		label: textToDisplay;
		yourself.
	null1 := self newNullPresenter.
	null2 := self newNullPresenter
]

{ #category : #'accessing model' }
FQNoPossibleQueryPresenter >> setModelBeforeInitialization: aString [
	textToDisplay := 'No ' , aString , ' available'
]
