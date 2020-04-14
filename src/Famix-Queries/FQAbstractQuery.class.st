Class {
	#name : #FQAbstractQuery,
	#superclass : #Object,
	#category : #'Famix-Queries-Core'
}

{ #category : #testing }
FQAbstractQuery class >> isAbstract [
	^ self = FQAbstractQuery
]

{ #category : #running }
FQAbstractQuery >> displayOn: aStream [ 
	self displayOn: aStream with: 'aMooseGroup' 
]

{ #category : #running }
FQAbstractQuery >> displayOn: aStream with: aString [
	^ self subclassResponsibility
]

{ #category : #testing }
FQAbstractQuery >> isValid [
	^ self subclassResponsibility
]

{ #category : #running }
FQAbstractQuery >> runOn: aMooseGroup [
	"I should run myself on the MooseGroup as parameter and return a new MooseGroup with my result."

	^ self subclassResponsibility
]
