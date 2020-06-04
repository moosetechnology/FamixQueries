Class {
	#name : #FQAddQuerySequenceToLibraryCommand,
	#superclass : #FQAddQueryToLibraryCommand,
	#category : #'Famix-Queries-Browser-Tools'
}

{ #category : #default }
FQAddQuerySequenceToLibraryCommand class >> defaultName [
	^ 'Save this query sequence'
]

{ #category : #executing }
FQAddQuerySequenceToLibraryCommand >> queryNamed: name [
	^ FQComposedQuery new
		queries: self context selectedQuery parentSequence;
		name: name
]
