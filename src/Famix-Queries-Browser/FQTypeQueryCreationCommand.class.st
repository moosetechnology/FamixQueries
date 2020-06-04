Class {
	#name : #FQTypeQueryCreationCommand,
	#superclass : #CmCommand,
	#category : #'Famix-Queries-Browser-Tools'
}

{ #category : #default }
FQTypeQueryCreationCommand class >> defaultName [
	^ 'Create new type query'
]

{ #category : #executing }
FQTypeQueryCreationCommand >> canBeExecuted [
	^ self context canCreateQueries
		and: [ self context roots includesAll: self context selectedItems ]
]

{ #category : #executing }
FQTypeQueryCreationCommand >> execute [
	self canBeExecuted
		ifFalse: [ ^ self ].
	self context createTypeQuery
]
