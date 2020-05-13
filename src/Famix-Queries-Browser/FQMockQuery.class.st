Class {
	#name : #FQMockQuery,
	#superclass : #FQUnaryQuery,
	#instVars : [
		'label'
	],
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
FQMockQuery >> label: aString [
	label := aString
]

{ #category : #printing }
FQMockQuery >> printOn: aStream [
	aStream << 'Initial Entities'
]

{ #category : #accessing }
FQMockQuery >> result: aMooseGroup [
	result := aMooseGroup
]

{ #category : #accessing }
FQMockQuery >> roassalLabel [
	self flag: #FQImprove.
	^ label ifNil: [ label := 'Model' ]
]

{ #category : #running }
FQMockQuery >> runOn: aMooseGroup [
	^ aMooseGroup
]
