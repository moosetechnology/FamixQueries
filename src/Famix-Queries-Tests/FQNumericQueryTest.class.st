Class {
	#name : #FQNumericQueryTest,
	#superclass : #FQAbstractQueryTest,
	#category : #'Famix-Queries-Tests-Terminal'
}

{ #category : #helpers }
FQNumericQueryTest >> actualClass [
	^ FQNumericQuery
]

{ #category : #tests }
FQNumericQueryTest >> testDisplayOn [
	query := self actualClass fromProperty: #numberOfMethods comparator: #> value: 10.

	self
		assert: (String streamContents: [ :s | query displayOn: s ])
		equals: 'mooseGroup select: [ :entity | entity numberOfMethods > 10 ]'
]

{ #category : #tests }
FQNumericQueryTest >> testRunOn [
	| classes |
	classes := model allModelClasses.
	query := self actualClass
		fromProperty: #numberOfMethods
		comparator: #>
		value: 10.
	self assert: (query runOn: classes) size equals: 4.
	self
		assertCollection: (query runOn: classes)
		hasSameElements:
			(model allModelClasses select: [ :class | class numberOfMethods > 10 ])
]
