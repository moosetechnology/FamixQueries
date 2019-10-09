Class {
	#name : #FQAbstractQuery,
	#superclass : #Object,
	#instVars : [
		'pattern'
	],
	#category : #'Famix-Queries-Core'
}

{ #category : #testing }
FQAbstractQuery class >> isAbstract [
	^ self = FQAbstractQuery
]

{ #category : #running }
FQAbstractQuery >> displayOn: aStream [ 
	self subclassResponsibility
]

{ #category : #running }
FQAbstractQuery >> runOn: aMooseGroup [
	"I should run myself on the MooseGroup as parameter and return a new MooseGroup with my result."

	^ self subclassResponsibility
]
