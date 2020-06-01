Class {
	#name : #FQTestsHelper,
	#superclass : #Object,
	#instVars : [
		'model',
		'classes',
		'methods',
		'classesAndMethods'
	],
	#classInstVars : [
		'current'
	],
	#category : #'Famix-Queries-Tests-Helper'
}

{ #category : #accessing }
FQTestsHelper class >> current [
	^ current ifNil: [ current := self new ]
]

{ #category : #entities }
FQTestsHelper >> classes [
	^ classes
		ifNil: [ classes := MooseGroup
				withAll: {self modelExample allModelClasses} flatten ]
]

{ #category : #entities }
FQTestsHelper >> classesAndMethods [
	^ classesAndMethods
		ifNil: [ classesAndMethods := MooseGroup
				withAll:
					{self classes.
					self methods} flatten ]
]

{ #category : #entities }
FQTestsHelper >> entitiesWithNoDownScope [
	^ self modelExample allWithType: FamixStAnnotationInstanceAttribute
]

{ #category : #entities }
FQTestsHelper >> entitiesWithNoIncomingAssociations [
	^ self modelExample allWithType: FamixStAnnotationInstanceAttribute
]

{ #category : #entities }
FQTestsHelper >> methods [
	^ methods
		ifNil: [ methods := MooseGroup
				withAll: {self modelExample allModelMethods} flatten ]
]

{ #category : #entities }
FQTestsHelper >> modelExample [
	^ model
		ifNil: [ model := FamixStModel new.
			MoosePharoImporterTask new
				importerClass: SmalltalkImporter;
				model: model;
				addFromPackageNamed: #'Moose-TestResources-LAN';
				run ]
]

{ #category : #entities }
FQTestsHelper >> noEntities [
	^ MooseGroup new
]

{ #category : #queries }
FQTestsHelper >> queryFromCodeInPresenter: aPresenter [
	^ (Smalltalk compiler evaluate: aPresenter queryCode text)
		beChildOf: aPresenter browser selectedQuery;
		"Necessary to be equal to actual query"
			yourself
]
