Class {
	#name : #FQPresenterTestsHelper,
	#superclass : #Object,
	#instVars : [
		'model'
	],
	#category : #'Famix-Queries-Browser-Tests-Presenters'
}

{ #category : #entities }
FQPresenterTestsHelper >> classesAndMethods [
	^ MooseGroup
		withAll:
			{self modelExample allModelClasses.
			self modelExample allModelMethods} flatten
]

{ #category : #entities }
FQPresenterTestsHelper >> entitiesWithNoDownScope [
	^ self modelExample allWithType: FamixStAnnotationInstanceAttribute
]

{ #category : #entities }
FQPresenterTestsHelper >> modelExample [
	^ model
		ifNil: [ model := FamixStModel new.
			MoosePharoImporterTask new
				importerClass: SmalltalkImporter;
				model: model;
				addFromPackageNamed: #'Moose-TestResources-LAN';
				run ]
]

{ #category : #entities }
FQPresenterTestsHelper >> noEntities [
	^ MooseGroup new
]

{ #category : #entities }
FQPresenterTestsHelper >> unnamedEntities [
	^ MooseGroup
		withAll:
			(self modelExample
				copyWithoutAll: (self modelExample allUsing: FamixTNamedEntity))
]
