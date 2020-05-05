Class {
	#name : #FQBrowserTestsHelper,
	#superclass : #Object,
	#instVars : [
		'model'
	],
	#category : #'Famix-Queries-Browser-Tests-Helpers'
}

{ #category : #entities }
FQBrowserTestsHelper >> classes [
	^ MooseGroup withAll: {self modelExample allModelClasses} flatten
]

{ #category : #entities }
FQBrowserTestsHelper >> classesAndMethods [
	^ MooseGroup
		withAll:
			{self modelExample allModelClasses.
			self modelExample allModelMethods} flatten
]

{ #category : #entities }
FQBrowserTestsHelper >> entitiesWithNoDownScope [
	^ self modelExample allWithType: FamixStAnnotationInstanceAttribute
]

{ #category : #entities }
FQBrowserTestsHelper >> modelExample [
	^ model
		ifNil: [ model := FamixStModel new.
			MoosePharoImporterTask new
				importerClass: SmalltalkImporter;
				model: model;
				addFromPackageNamed: #'Moose-TestResources-LAN';
				run ]
]

{ #category : #entities }
FQBrowserTestsHelper >> noEntities [
	^ MooseGroup new
]

{ #category : #entities }
FQBrowserTestsHelper >> unnamedEntities [
	^ MooseGroup
		withAll:
			(self modelExample
				copyWithoutAll: (self modelExample allUsing: FamixTNamedEntity))
]
