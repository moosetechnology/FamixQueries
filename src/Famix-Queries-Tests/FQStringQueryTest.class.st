Class {
	#name : #FQStringQueryTest,
	#superclass : #FQAbstractQueryTest,
	#category : #'Famix-Queries-Tests-Terminal'
}

{ #category : #helpers }
FQStringQueryTest >> actualClass [
	^ FQStringQuery
]

{ #category : #tests }
FQStringQueryTest >> testDisplayOn [
	query := self actualClass fromProperty: #name selector: #includesSubstring: withPattern: 'LANP'.

	self
		assert: (String streamContents: [ :s | query displayOn: s ])
		equals: 'mooseGroup select: [ :entity | entity name includesSubstring: LANP ]'
]

{ #category : #tests }
FQStringQueryTest >> testRunOn [
	| classes |
	classes := model allModelClasses select: #isInstanceSide.

	query := self actualClass fromProperty: #name selector: #includesSubstring: withPattern: 'LANP'.

	self assert: (query runOn: classes) size equals: 3.
	self assertCollection: ((query runOn: classes) collect: #name) hasSameElements: #('LANPool' 'LANPacket' 'LANPrintServer')
]
