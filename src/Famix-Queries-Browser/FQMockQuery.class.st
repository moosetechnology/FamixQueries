Class {
	#name : #FQMockQuery,
	#superclass : #FQUnaryQuery,
	#category : #'Famix-Queries-Browser'
}

{ #category : #'as yet unclassified' }
FQMockQuery class >> color [
	^ Color colorFrom: 'DDDDDD'
]

{ #category : #'as yet unclassified' }
FQMockQuery class >> label [
	^ 'Initial Entities'
]

{ #category : #comparing }
FQMockQuery >> = aQuery [
	^ self class == aQuery class
]

{ #category : #printing }
FQMockQuery >> displayOn: aStream with: aString [
	aStream << aString
]

{ #category : #testing }
FQMockQuery >> isValid [
	^ true
]

{ #category : #accessing }
FQMockQuery >> result: aMooseGroup [
	result := aMooseGroup
]

{ #category : #accessing }
FQMockQuery >> roassalLabel [
	^ 'Initial Entities'
]

{ #category : #running }
FQMockQuery >> runOn: aMooseGroup [
	^ aMooseGroup
]
