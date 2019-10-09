Class {
	#name : #FQNameQuery,
	#superclass : #FQAbstractQuery,
	#category : #'Famix-Queries-Terminal'
}

{ #category : #'instance creation' }
FQNameQuery class >> fromString: aString [
	^ self new
		pattern: aString;
		yourself
]

{ #category : #running }
FQNameQuery >> displayOn: aStream [
	aStream << 'mooseGroup select: [ :each | each includesSubstring: ' << self pattern << ' ]'
]

{ #category : #accessing }
FQNameQuery >> pattern [
	^ pattern
]

{ #category : #accessing }
FQNameQuery >> pattern: aString [ 
	pattern := aString
]

{ #category : #running }
FQNameQuery >> runOn: aMooseGroup [ 
	^ aMooseGroup select: [ :each | each name includesSubstring: self pattern ]
]
