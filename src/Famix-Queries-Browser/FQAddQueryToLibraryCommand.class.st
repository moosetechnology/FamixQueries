Class {
	#name : #FQAddQueryToLibraryCommand,
	#superclass : #CmCommand,
	#category : #'Famix-Queries-Browser-Tools'
}

{ #category : #default }
FQAddQueryToLibraryCommand class >> defaultName [
	^ 'Save this query'
]

{ #category : #executing }
FQAddQueryToLibraryCommand >> execute [
	| name |
	name := self getName.
	FQQueriesLibrary current addNewQuery: (self queryNamed: name)
]

{ #category : #executing }
FQAddQueryToLibraryCommand >> getName [
	| name |
	name := UIManager default request: 'Please name this query'.
	name ifNil: [ ^ nil ].
	name ifEmpty: [ ^ self getName ].
	^ name
]

{ #category : #executing }
FQAddQueryToLibraryCommand >> queryNamed: name [
	^ self context selectedQuery name: name
]
