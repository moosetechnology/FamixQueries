Class {
	#name : #FQQueryCreationCommand,
	#superclass : #CmCommand,
	#category : #'Famix-Queries-Browser-Tools'
}

{ #category : #default }
FQQueryCreationCommand class >> defaultDescription [
	^ 'Apply definitely this query'
]

{ #category : #default }
FQQueryCreationCommand class >> defaultIconName [
	^ #glamorousGo
]

{ #category : #default }
FQQueryCreationCommand class >> defaultName [
	^ 'Create Query'
]

{ #category : #testing }
FQQueryCreationCommand >> canBeExecuted [
	self flag: 'Should be used when Spec is upgraded'.
	^ self queryBuilder queryIsValid
]

{ #category : #executing }
FQQueryCreationCommand >> execute [
	self queryBuilder applyQuery
		ifEmpty: [ (UIManager default
				confirm: 'Do you want to apply this query ?'
				label: 'This query result is empty')
				ifFalse: [ ^ self ] ].
	(self queryBuilder applyQuery
		includesAll: self queryBuilder entities)
		ifTrue: [ (UIManager default
				confirm: 'Do you want to apply this query ?'
				label: 'Query input is identical to result')
				ifFalse: [ ^ self ] ].
	self context notifyAcceptedQuery
]

{ #category : #accessing }
FQQueryCreationCommand >> queryBuilder [
	^ self context queryBuilder
]
