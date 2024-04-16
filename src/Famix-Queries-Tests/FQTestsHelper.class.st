Class {
	#name : #FQTestsHelper,
	#superclass : #Object,
	#instVars : [
		'model',
		'classes',
		'methods',
		'classesAndMethods'
	],
	#category : #'Famix-Queries-Tests-Helper'
}

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

{ #category : #initialization }
FQTestsHelper >> initialize [

	model := FamixStModel new.
	MoosePharoImporterTask new
		model: model;
		addFromPackageNamed: #'Moose-TestResources-LAN';
		run
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
]

{ #category : #entities }
FQTestsHelper >> noEntities [
	^ MooseGroup new
]
