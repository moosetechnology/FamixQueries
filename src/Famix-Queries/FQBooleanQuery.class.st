Class {
	#name : #FQBooleanQuery,
	#superclass : #FQPropertyQuery,
	#category : #'Famix-Queries-Terminal'
}

{ #category : #'instance creation' }
FQBooleanQuery class >> fromProperty: aBooleanSelector [
	^ self new
		property: aBooleanSelector;
		yourself
]

{ #category : #running }
FQBooleanQuery >> displayOn: aStream with: aString [
	aStream << aString << ' select: [ :entity | entity '
		<< self property asString << ' ]'
]

{ #category : #running }
FQBooleanQuery >> runOn: aMooseGroup [
	"I should run myself on the MooseGroup as parameter and return a new MooseGroup with my result."

	^ aMooseGroup select: [ :entity | self property value: entity ]
]

{ #category : #'available properties' }
FQBooleanQuery >> type [
	^ FM3Boolean
]
