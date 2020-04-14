Class {
	#name : #ImpossibleQuery,
	#superclass : #Error,
	#instVars : [
		'builder'
	],
	#category : #'Famix-Queries-Browser-Builder'
}

{ #category : #accessing }
ImpossibleQuery class >> builder: aBuilder [
	^ self new
		builder: aBuilder;
		yourself
]

{ #category : #accessing }
ImpossibleQuery >> builder [
	^ builder
]

{ #category : #accessing }
ImpossibleQuery >> builder: anObject [
	builder := anObject
]
