Class {
	#name : #FQAddQueryCommand,
	#superclass : #FQABstractQueryCommand,
	#category : #'Famix-Queries-Browser-Tools'
}

{ #category : #default }
FQAddQueryCommand class >> defaultIconName [
	^ #add
]

{ #category : #default }
FQAddQueryCommand class >> defaultName [
	^ 'Add Query after this one'
]

{ #category : #executing }
FQAddQueryCommand >> execute [
	(FQQueryCreationPresenter on: self browser owner) openWithSpec
]
