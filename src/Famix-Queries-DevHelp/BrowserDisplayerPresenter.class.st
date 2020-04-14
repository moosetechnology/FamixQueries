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
		add: #open width: 150;
		add: #openWithoutEntities width: 150;
		yourself
]

{ #category : #specs }
BrowserDisplayerPresenter class >> open [
	<script>
	self new openWithSpec
]

{ #category : #specs }
BrowserDisplayerPresenter class >> title [
	^ 'Open Famix Query Browser'
]

{ #category : #initialization }
BrowserDisplayerPresenter >> initializePresenters [
	open := self newButton
		whenActivatedDo: [ FQBrowserPresenter open ];
		label: 'Open';
		yourself.
	openWithoutEntities := self newButton
		whenActivatedDo: [ FQBrowserPresenter openWithoutEntities ];
		label: 'Open without Entities';
		yourself
]

{ #category : #initialization }
BrowserDisplayerPresenter >> initializeWindow: aWindowPresenter [
	super initializeWindow: aWindowPresenter.
	aWindowPresenter initialExtent: 300 @ 150
]
