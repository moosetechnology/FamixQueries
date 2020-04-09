Class {
	#name : #FQAbstractQueryBuilderTest,
	#superclass : #TestCase,
	#instVars : [
		'entities',
		'queryBuilder'
	],
	#category : #'Famix-Queries-Browser-Tests-Builder'
}

{ #category : #initialization }
FQAbstractQueryBuilderTest >> queryBuilderClass [
	^ self subclassResponsibility
]

{ #category : #running }
FQAbstractQueryBuilderTest >> setUp [
	| model |
	model := FamixStModel new.
	MoosePharoImporterTask new
		importerClass: SmalltalkImporter;
		model: model;
		addFromPackageNamed: #'Moose-TestResources-LAN';
		run.
	entities := MooseGroup withAll: model.
	queryBuilder := self queryBuilderClass newWithEntities: entities
]
