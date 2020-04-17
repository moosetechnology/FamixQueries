Class {
	#name : #BrowserDisplayerPresenter,
	#superclass : #SpPresenter,
	#instVars : [
		'open',
		'openWithoutEntities'
	],
	#category : #'Famix-Queries-DevHelp'
}

{ #category : #specs }
BrowserDisplayerPresenter class >> defaultSpec [
	^ SpBoxLayout newHorizontal
		add: #open;
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
		color: UITheme current selectionColor ;
		yourself
]

{ #category : #initialization }
BrowserDisplayerPresenter >> initializeWindow: aWindowPresenter [
	super initializeWindow: aWindowPresenter.
	aWindowPresenter initialExtent: 200 @ 150
]
