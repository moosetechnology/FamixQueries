Class {
	#name : #FQQueryCreationCommand,
	#superclass : #CmCommand,
	#category : #'Famix-Queries-Browser-Tools'
}

{ #category : #default }
FQQueryCreationCommand class >> defaultDescription [
	^ 'Apply this query'
]

{ #category : #default }
FQQueryCreationCommand class >> defaultIconName [
	^ #glamorousGo
]

{ #category : #default }
FQQueryCreationCommand class >> defaultName [
	^ 'Apply'
]

{ #category : #testing }
FQQueryCreationCommand >> canBeExecuted [
	^ self context query isValid
]

{ #category : #executing }
FQQueryCreationCommand >> confirmEmptyResult [
	^ UIManager default
		confirm: 'Do you want to apply this query ?'
		label: 'This query result is empty'
]

{ #category : #executing }
FQQueryCreationCommand >> confirmUnchangedResult [
	^ UIManager default
		confirm: 'Do you want to apply this query ?'
		label: 'Query input is identical to result'
]

{ #category : #executing }
FQQueryCreationCommand >> execute [
	self context query result
		ifEmpty: [ self confirmEmptyResult
				ifFalse: [ ^ self ] ].
	self
		flag:
			#FQImprove
				,
					'calling browser entities ?? How to be relevant with binary queries (2 parents)'.
	(self context query result
		hasEqualElements: self context browser entities)
		ifTrue: [ self confirmUnchangedResult
				ifFalse: [ ^ self ] ].
	self context notifyAcceptedQuery.
	self context window close
]
