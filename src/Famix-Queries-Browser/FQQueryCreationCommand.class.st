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

{ #category : #executing }
FQQueryCreationCommand >> execute [
	self context notifyAcceptedQuery	"queryBuilder applyQuery inspect"
]

{ #category : #accessing }
FQQueryCreationCommand >> queryBuilder [
	^ self context queryBuilder
]
