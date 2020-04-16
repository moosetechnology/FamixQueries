Class {
	#name : #FQAbstractQueryBuilderTest,
	#superclass : #TestCase,
	#instVars : [
		'entities',
		'queryBuilder',
		'noEntities'
	],
	#category : #'Famix-Queries-Browser-Tests-Builder'
}

{ #category : #testing }
FQAbstractQueryBuilderTest class >> isAbstract [
	^ self == FQAbstractQueryBuilderTest
]

{ #category : #running }
FQAbstractQueryBuilderTest >> model [
	| model |
	model := FamixStModel new.
	MoosePharoImporterTask new
		importerClass: SmalltalkImporter;
		model: model;
		addFromPackageNamed: #'Moose-TestResources-LAN';
		run.
	^ model
]

{ #category : #initialization }
FQAbstractQueryBuilderTest >> queryBuilderClass [
	^ self subclassResponsibility
]

{ #category : #running }
FQAbstractQueryBuilderTest >> setQueryBuilder [
	queryBuilder := self queryBuilderClass newWithEntities: entities
]

{ #category : #running }
FQAbstractQueryBuilderTest >> setUp [
	entities := MooseGroup withAll: self model.
	noEntities := MooseGroup new.
	self setQueryBuilder
]

{ #category : #tests }
FQAbstractQueryBuilderTest >> testErrorOnInitializeQuery [
	self
		should: [ self queryBuilderClass newWithEntities: noEntities ]
		raise: ImpossibleQuery
]
