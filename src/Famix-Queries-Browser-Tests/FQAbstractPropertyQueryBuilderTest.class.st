Class {
	#name : #FQAbstractPropertyQueryBuilderTest,
	#superclass : #FQAbstractQueryBuilderTest,
	#category : #'Famix-Queries-Browser-Tests-Builder'
}

{ #category : #running }
FQAbstractPropertyQueryBuilderTest >> setUp [
	| model |
	model := FamixStModel new.
	MoosePharoImporterTask new
		importerClass: SmalltalkImporter;
		model: model;
		addFromPackageNamed: #'Moose-TestResources-LAN';
		run.
	entities := MooseGroup
		withAll:
			{model allModelClasses.
			model allModelMethods} flatten.
	queryBuilder := self queryBuilderClass newWithEntities: entities
]
