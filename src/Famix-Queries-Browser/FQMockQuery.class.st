Class {
	#name : #FQMockQuery,
	#superclass : #FQUnaryQuery,
	#category : #'Famix-Queries-Browser-Tools'
}

{ #category : #'as yet unclassified' }
FQMockQuery class >> color [
	^ Color colorFrom: 'DDDDDD'
]

{ #category : #'as yet unclassified' }
FQMockQuery class >> label [
	^ 'Initial Entities'
]

{ #category : #accessing }
FQMockQuery >> defaultName [
	^ 'Model'
]

{ #category : #printing }
FQMockQuery >> displayOn: aStream with: aString [
	aStream << aString
]

{ #category : #comparing }
FQMockQuery >> hasSameParametersAs: aQuery [
	^ self result == aQuery result
]

{ #category : #testing }
FQMockQuery >> isValid [
	^ true
]

{ #category : #accessing }
FQMockQuery >> name: aString [
	name := aString
]

{ #category : #accessing }
FQMockQuery >> result: aMooseGroup [
	result := aMooseGroup
]

{ #category : #running }
FQMockQuery >> runOn: aMooseGroup [
	^ aMooseGroup
]
