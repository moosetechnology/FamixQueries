Class {
	#name : #FQNameQueryTest,
	#superclass : #FQAbstractQueryTest,
	#category : #'Famix-Queries-Tests-Terminal'
}

{ #category : #helpers }
FQNameQueryTest >> actualClass [
	^ FQNameQuery
]

{ #category : #tests }
FQNameQueryTest >> testDisplayOn [
	query := FQNameQuery fromString: 'LANP'. 
	
	self assert: (String streamContents: [ :s | query displayOn: s]) equals: 'mooseGroup select: [ :each | each includesSubstring: LANP ]'
]

{ #category : #tests }
FQNameQueryTest >> testRunOn [
	| classes |
	classes := model allModelClasses select: #isInstanceSide.
	query := FQNameQuery fromString: 'LANP'.

	self assert: (query runOn: classes) size equals: 3.
	self assertCollection: ((query runOn: classes) collect: #name) hasSameElements: #('LANPool' 'LANPacket' 'LANPrintServer')
]
