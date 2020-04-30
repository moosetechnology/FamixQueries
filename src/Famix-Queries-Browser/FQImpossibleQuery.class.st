Class {
	#name : #FQImpossibleQuery,
	#superclass : #Error,
	#instVars : [
		'builder'
	],
	#category : #'Famix-Queries-Browser-Errors'
}

{ #category : #accessing }
FQImpossibleQuery class >> builder: aBuilder [
	^ self new
		builder: aBuilder;
		yourself
]

{ #category : #accessing }
FQImpossibleQuery >> builder [
	^ builder
]

{ #category : #accessing }
FQImpossibleQuery >> builder: anObject [
	builder := anObject
]
