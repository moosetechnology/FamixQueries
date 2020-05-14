Class {
	#name : #BrowserDisplayerPresenter,
	#superclass : #SpPresenter,
	#instVars : [
		'open',
		'openWithoutEntities',
		'roassal',
		'openEmpty'
	],
	#category : #'Famix-Queries-DevHelp'
}

{ #category : #specs }
BrowserDisplayerPresenter class >> defaultSpec [
	^ SpBoxLayout newHorizontal
		add: #open;
		add: #openEmpty;
		yourself
]

{ #category : #specs }
BrowserDisplayerPresenter class >> open [
	<script>
	self new openWithSpec
]

{ #category : #specs }
BrowserDisplayerPresenter class >> title [
	^ 'Famix Query Button'
]

{ #category : #initialization }
BrowserDisplayerPresenter >> initializePresenters [
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
BrowserDisplayerPresenter >> initializeWindow: aWindowPresenter [
	super initializeWindow: aWindowPresenter.
	aWindowPresenter initialExtent: 400 @ 150
]
