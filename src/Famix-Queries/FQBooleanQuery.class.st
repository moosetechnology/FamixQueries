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

{ #category : #testing }
FQBooleanQuery >> hasComparisonParameters [
	^ false
]

{ #category : #running }
FQBooleanQuery >> runOn: aMooseGroup [
	^ aMooseGroup select: [ :entity | self property value: entity ]
]

{ #category : #'available parameters' }
FQBooleanQuery >> type [
	^ FM3Boolean
]

{ #category : #printing }
FQBooleanQuery >> valueToCompareAsString [
	self shouldNotImplement
]
