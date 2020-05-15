Class {
	#name : #BrowserOpeningButton,
	#superclass : #SpPresenter,
	#instVars : [
		'open',
		'openWithoutEntities',
		'roassal',
		'openEmpty'
	],
	#category : #'Famix-Queries-DevHelp-StartButton'
}

{ #category : #specs }
BrowserOpeningButton class >> defaultSpec [
	^ SpBoxLayout newHorizontal
		add: #open;
		add: #openEmpty;
		yourself
]

{ #category : #specs }
BrowserOpeningButton class >> open [
	<script>
	self new openWithSpec
]

{ #category : #specs }
BrowserOpeningButton class >> title [
	^ 'Famix Query Button'
]

{ #category : #initialization }
BrowserOpeningButton >> initializePresenters [
	open := self newButton
		whenActivatedDo: [ FQQueriesBrowserPresenter open ];
		iconName: #smallFind;
		label: 'Famix Query Browser';
		color: UITheme current borderColor;
		yourself.
	openEmpty := self newButton
		whenActivatedDo: [ FQQueriesBrowserPresenter openEmpty ];
		iconName: #smallFind;
		label: 'Empty Famix Query Browser';
		color: UITheme current borderColor;
		yourself
]

{ #category : #initialization }
BrowserOpeningButton >> initializeWindow: aWindowPresenter [
	super initializeWindow: aWindowPresenter.
	aWindowPresenter initialExtent: 400 @ 150
]
