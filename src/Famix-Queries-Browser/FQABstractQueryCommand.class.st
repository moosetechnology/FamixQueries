Class {
	#name : #FQABstractQueryCommand,
	#superclass : #CmCommand,
	#category : #'Famix-Queries-Browser-Tools'
}

{ #category : #accessing }
FQABstractQueryCommand >> browser [
	^ self context
]
