Class {
	#name : #FQBooleanQuery,
	#superclass : #FQPropertyQuery,
	#category : #'Famix-Queries-Terminal'
}

{ #category : #running }
FQBooleanQuery >> displayOn: aStream [
	aStream
		<< 'mooseGroup select: [ :entity | entity '
		<< self property asString
		<< ' ]'
]

{ #category : #running }
FQBooleanQuery >> runOn: aMooseGroup [
	"I should run myself on the MooseGroup as parameter and return a new MooseGroup with my result."

	^ aMooseGroup select: [ :entity | self property value: entity ]
]
