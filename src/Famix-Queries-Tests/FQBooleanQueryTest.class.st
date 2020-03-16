Class {
	#name : #FQBooleanQueryTest,
	#superclass : #FQAbstractQueryTest,
	#category : #'Famix-Queries-Tests-Terminal'
}

{ #category : #helpers }
FQBooleanQueryTest >> actualClass [
	^ FQBooleanQuery
]

{ #category : #tests }
FQBooleanQueryTest >> testDisplayOn [
	query := self actualClass fromProperty: #isInstanceSide.
	
	self
		assert: (String streamContents: [ :s | query displayOn: s ])
		equals: 'mooseGroup select: [ :entity | entity isInstanceSide ]'
]

{ #category : #tests }
FQBooleanQueryTest >> testRunOn [
	| grp |
	grp := model allModelClasses.
	
	query := self actualClass fromProperty: #isInstanceSide.
	
	self assert: (query runOn: grp) size equals: 12.
	self
		assertCollection: (query runOn: grp)
		hasSameElements: (model allModelClasses select: #isInstanceSide)
]
