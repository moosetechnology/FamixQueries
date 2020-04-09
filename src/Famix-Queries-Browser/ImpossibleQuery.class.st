Class {
	#name : #ImpossibleQuery,
	#superclass : #Error,
	#instVars : [
		'displayText'
	],
	#category : #'Famix-Queries-Browser-Builder'
}

{ #category : #accessing }
ImpossibleQuery class >> displayText: aText [
	^ self new
		displayText: aText;
		yourself
]

{ #category : #accessing }
ImpossibleQuery >> displayText [
	^ displayText
]

{ #category : #accessing }
ImpossibleQuery >> displayText: anObject [
	displayText := anObject
]
