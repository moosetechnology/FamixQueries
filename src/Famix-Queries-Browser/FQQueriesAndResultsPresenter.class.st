Class {
	#name : #FQQueriesAndResultsPresenter,
	#superclass : #SpPresenter,
	#instVars : [
		'queriesTree',
		'queryResult',
		'entities',
		'newQueryButton'
	],
	#category : #'Famix-Queries-Browser-Presenters'
}

{ #category : #entities }
FQQueriesAndResultsPresenter class >> classesAndMethods [
	| model |
	model := self modelExample.
	^ MooseGroup
		withAll:
			{model allModelClasses.
			model allModelMethods} flatten
]

{ #category : #'instance creation' }
FQQueriesAndResultsPresenter class >> default [
	^ self basicNew
		entities: self classesAndMethods;
		initialize;
		yourself
]

{ #category : #specs }
FQQueriesAndResultsPresenter class >> defaultSpec [
	^ SpPanedLayout newHorizontal
		add:
			(SpPanedLayout newVertical
				add: #queriesTree;
				add: #newQueryButton;
				yourself);
		add: #queryResult;
		yourself
]

{ #category : #entities }
FQQueriesAndResultsPresenter class >> modelExample [
	| model |
	model := FamixStModel new.
	MoosePharoImporterTask new
		importerClass: SmalltalkImporter;
		model: model;
		addFromPackageNamed: #'Moose-TestResources-LAN';
		run.
	^ model
]

{ #category : #'instance creation' }
FQQueriesAndResultsPresenter class >> open [
	<script>
	self default openWithSpec
]

{ #category : #accessing }
FQQueriesAndResultsPresenter >> entities [
	^ entities
]

{ #category : #accessing }
FQQueriesAndResultsPresenter >> entities: anObject [
	entities := anObject
]

{ #category : #initialization }
FQQueriesAndResultsPresenter >> initializePresenters [
	super initializePresenters.
	queriesTree := self newList headerTitle: 'Queries'.
	newQueryButton := self newButton
		label: 'Create a new query';
		whenActivatedDo: [ (FQBrowserPresenter owner: self on: self entities) openWithSpec ].
	queryResult := self newList
		items: self entities;
		display: #name
]
