Class {
	#name : #FQAbstractQueryTest,
	#superclass : #TestCase,
	#instVars : [
		'model',
		'query',
		'classesAndMethods'
	],
	#category : #'Famix-Queries-Tests-Core'
}

{ #category : #testing }
FQAbstractQueryTest class >> isAbstract [
	^ self = FQAbstractQueryTest
]

{ #category : #testing }
FQAbstractQueryTest class >> shouldInheritSelectors [
	^ true
]

{ #category : #helpers }
FQAbstractQueryTest >> actualClass [
	^ self subclassResponsibility
]

{ #category : #'public access' }
FQAbstractQueryTest >> evaluate: aString [
	^ FQAbstractQuery readFrom: aString
]

{ #category : #running }
FQAbstractQueryTest >> setUp [
	super setUp.
	model
		ifNil: [ model := FamixStModel new.
			MoosePharoImporterTask new
				importerClass: SmalltalkImporter;
				model: model;
				addFromPackageNamed: #'Moose-TestResources-LAN';
				run ].
	classesAndMethods := MooseGroup
		withAll:
			{model allModelClasses.
			model allModelMethods} flatten
]

{ #category : #tests }
FQAbstractQueryTest >> testDisplayOn [
	self subclassResponsibility
]

{ #category : #tests }
FQAbstractQueryTest >> testEquals [
	self subclassResponsibility
]

{ #category : #tests }
FQAbstractQueryTest >> testIsValid [
	self subclassResponsibility
]

{ #category : #tests }
FQAbstractQueryTest >> testRunOn [
	self subclassResponsibility
]
