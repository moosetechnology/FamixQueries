Class {
	#name : #FQMockQuery,
	#superclass : #FQUnaryQuery,
	#category : #'Famix-Queries-Browser-Tools'
}

{ #category : #display }
FQMockQuery class >> color [
	^ Color colorFrom: 'DDDDDD'
]

{ #category : #display }
FQMockQuery class >> label [
	^ 'Initial Entities'
]

{ #category : #default }
FQMockQuery >> beDefaultForParent [
	"Nothing to do"

	
]

{ #category : #printing }
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

{ #category : #initialization }
FQMockQuery >> initialize [
	super initialize.
	result := MooseGroup new
]

{ #category : #testing }
FQMockQuery >> isValid [
	^ true
]

{ #category : #accessing }
FQMockQuery >> result: aMooseGroup [
	result := aMooseGroup
]

{ #category : #running }
FQMockQuery >> runOn: aMooseGroup [
	^ aMooseGroup
]
