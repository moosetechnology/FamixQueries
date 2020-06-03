Class {
	#name : #FQRootQuery,
	#superclass : #FQUnaryQuery,
	#category : #'Famix-Queries-Browser-Tools'
}

{ #category : #display }
FQRootQuery class >> color [
	^ Color colorFrom: 'DDDDDD'
]

{ #category : #display }
FQRootQuery class >> label [
	^ 'Initial Entities'
]

{ #category : #default }
FQRootQuery >> beDefaultForParent [
	"Nothing to do"

	
]

{ #category : #printing }
FQRootQuery >> defaultName [
	^ 'Model'
]

{ #category : #printing }
FQRootQuery >> displayOn: aStream with: aString [
	aStream << aString
]

{ #category : #comparing }
FQRootQuery >> hasSameParametersAs: aQuery [
	^ self result == aQuery result
]

{ #category : #initialization }
FQRootQuery >> initialize [
	super initialize.
	result := MooseGroup new
]

{ #category : #testing }
FQRootQuery >> isRootQuery [
	^ true
]

{ #category : #testing }
FQRootQuery >> isValid [
	^ true
]

{ #category : #accessing }
FQRootQuery >> result: aMooseGroup [
	result := aMooseGroup
]

{ #category : #running }
FQRootQuery >> runOn: aMooseGroup [
	^ aMooseGroup
]

{ #category : #printing }
FQRootQuery >> storeOn: aStream [
	aStream << self className << ' new'
]
