Class {
	#name : #FQAbstractQueryBuilder,
	#superclass : #Object,
	#instVars : [
		'query',
		'entities'
	],
	#category : #'Famix-Queries-Browser-Builder'
}

{ #category : #accessing }
FQAbstractQueryBuilder class >> default [
	^ self new
		entities: self entities;
		yourself
]

{ #category : #'plugin interface' }
FQAbstractQueryBuilder class >> entities [
	| model |
	model := FamixStModel new.
	MoosePharoImporterTask new
		importerClass: SmalltalkImporter;
		model: model;
		addFromPackageNamed: #'Moose-TestResources-LAN';
		run.
	^ MooseGroup withAll: model allModelClasses
]

{ #category : #running }
FQAbstractQueryBuilder >> buildQuery [
	^ self queryClass new
]

{ #category : #running }
FQAbstractQueryBuilder >> createQuery [
	^ String streamContents: [ :s | query displayOn: s ]
]

{ #category : #accessing }
FQAbstractQueryBuilder >> entities [
	^ entities
]

{ #category : #accessing }
FQAbstractQueryBuilder >> entities: anObject [
	entities := anObject
]

{ #category : #initialization }
FQAbstractQueryBuilder >> initialize [
	super initialize.
	self buildQuery
]

{ #category : #accessing }
FQAbstractQueryBuilder >> query [
	^ query
]

{ #category : #accessing }
FQAbstractQueryBuilder >> query: anObject [
	query := anObject
]

{ #category : #accessing }
FQAbstractQueryBuilder >> queryClass [
	^ self subclassResponsibility
]
