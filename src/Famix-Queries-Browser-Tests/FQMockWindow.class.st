Class {
	#name : #FQMockWindow,
	#superclass : #Object,
	#instVars : [
		'wasClosed'
	],
	#category : #'Famix-Queries-Browser-Tests-Helpers'
}

{ #category : #'mocking spec behavior' }
FQMockWindow >> application [
	^ SpApplication defaultApplication
]

{ #category : #'initialize-release' }
FQMockWindow >> close [
	wasClosed := true
]

{ #category : #initialization }
FQMockWindow >> initialize [
	super initialize.
	wasClosed := false
]

{ #category : #'mocking spec behavior' }
FQMockWindow >> isWindowPresenter [
	^ true
]

{ #category : #'mocking spec behavior' }
FQMockWindow >> root [
	^ self
]

{ #category : #'initialize-release' }
FQMockWindow >> wasClosed [
	^ wasClosed
]
