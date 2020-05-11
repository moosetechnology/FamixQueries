Class {
	#name : #FQQueryCombinationCommand,
	#superclass : #CmCommand,
	#category : #'Famix-Queries-Browser-Tools'
}

{ #category : #default }
FQQueryCombinationCommand class >> defaultDescription [
	^ 'Apply definitely this query'
]

{ #category : #default }
FQQueryCombinationCommand class >> defaultIconName [
	^ #glamorousGo
]

{ #category : #default }
FQQueryCombinationCommand class >> defaultName [
	^ 'Create Query'
]

{ #category : #testing }
FQQueryCombinationCommand >> canBeExecuted [
	self flag: #FQSpecPb , 'Should be used when Spec is upgraded'.
	^ self queryBuilder queryIsValid
]

{ #category : #executing }
FQQueryCombinationCommand >> execute [
	self context newQuery result
		ifEmpty: [ (UIManager default
				confirm: 'Do you want to apply this query ?'
				label: 'This query result is empty')
				ifFalse: [ ^ self ] ].
	self context notifyAcceptedQuery.
	self context window close
]
