Class {
	#name : #BrowserDisplayerPresenter,
	#superclass : #SpPresenter,
	#instVars : [
		'open',
		'openWithoutEntities',
		'roassal'
	],
	#category : #'Famix-Queries-DevHelp'
}

{ #category : #specs }
BrowserDisplayerPresenter class >> defaultSpec [
	^ SpPanedLayout newHorizontal
		add: #open;
		add: #roassal;
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
		label: 'Open Famix Query Browser';
		color: UITheme current borderColor;
		yourself.
	roassal := self newButton
		whenActivatedDo: [ FQRoassalQueryBrowser open ];
		iconName: #objects;
		label: 'Open Roassal Browser';
		color: UITheme current borderColor;
		yourself
]

{ #category : #initialization }
BrowserDisplayerPresenter >> initializeWindow: aWindowPresenter [
	super initializeWindow: aWindowPresenter.
	aWindowPresenter initialExtent: 400 @ 150
]
