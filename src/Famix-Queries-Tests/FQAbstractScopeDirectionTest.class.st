Class {
	#name : #FQAbstractScopeDirectionTest,
	#superclass : #TestCase,
	#instVars : [
		'model'
	],
	#category : #'Famix-Queries-Tests-Tools'
}

{ #category : #running }
FQAbstractScopeDirectionTest >> setUp [
	super setUp.
	model
		ifNil: [ model := FamixStModel new.
			MoosePharoImporterTask new
				importerClass: SmalltalkImporter;
				model: model;
				addFromPackageNamed: #'Moose-TestResources-LAN';
				run ]
]

{ #category : #tests }
FQAbstractScopeDirectionTest >> testAvailableScopesDown [
	| directionStrategy classes availableScopes resultScopes |
	
	directionStrategy := FQScopeDown.
	classes := model allModelClasses.
	
	resultScopes := directionStrategy availableScopesFor: classes.
	availableScopes := classes first allChildrenTypes reject: #isTrait.
	
	self assert: resultScopes size equals: availableScopes size.
	self assertCollection: resultScopes hasSameElements: availableScopes
]

{ #category : #tests }
FQAbstractScopeDirectionTest >> testAvailableScopesFor [
	self testAvailableScopesUp.
	self testAvailableScopesUpDown.
	self testAvailableScopesDown
]

{ #category : #tests }
FQAbstractScopeDirectionTest >> testAvailableScopesIncludesNoTrait [
| directionStrategy classes |
	
	classes := model allModelClasses.
	
	directionStrategy := FQScopeUp.
	self assert: (( directionStrategy availableScopesFor: classes) noneSatisfy: #isTrait).
	
	directionStrategy := FQScopeUpAndDown.
	self assert: (( directionStrategy availableScopesFor: classes) noneSatisfy: #isTrait).
	
	directionStrategy := FQScopeDown.
	self assert: (( directionStrategy availableScopesFor: classes) noneSatisfy: #isTrait)
]

{ #category : #tests }
FQAbstractScopeDirectionTest >> testAvailableScopesUp [
	| directionStrategy classes availableScopes resultScopes |
	
	directionStrategy := FQScopeUp.
	classes := model allModelClasses.
	
	resultScopes := directionStrategy availableScopesFor: classes.
	availableScopes := classes first allParentTypes reject: #isTrait.
	
	self assert: resultScopes size equals: availableScopes size.
	self assertCollection: resultScopes hasSameElements: availableScopes
]

{ #category : #tests }
FQAbstractScopeDirectionTest >> testAvailableScopesUpDown [
	| directionStrategy classes availableScopes resultScopes |
	
	directionStrategy := FQScopeUpAndDown.
	classes := model allModelClasses.
	
	resultScopes := directionStrategy availableScopesFor: classes.
	availableScopes := {classes first allParentTypes. 
		classes first allChildrenTypes} flatten asSet reject: #isTrait.
	
	self assert: resultScopes size equals: availableScopes size.
	self assertCollection: resultScopes hasSameElements: availableScopes
]
