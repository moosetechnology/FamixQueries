Class {
	#name : #FQPropertyQuery,
	#superclass : #FQAbstractQuery,
	#instVars : [
		'property',
		'valueToCompare',
		'comparator'
	],
	#category : #'Famix-Queries-Terminal'
}

{ #category : #accessing }
FQPropertyQuery class >> availablePropertyTypes [
	^ FQPropertyQuery allSubclasses
]

{ #category : #comparing }
FQPropertyQuery >> = aQuery [
	^ self class == aQuery class and: [ property == aQuery property ]
]

{ #category : #'available parameters' }
FQPropertyQuery >> availablePropertiesFor: aMooseGroup [
	| collectedProperties |
	collectedProperties := aMooseGroup entities
		collect: [ :entity | 
			entity mooseDescription allPrimitiveProperties
				select: [ :prop | prop type class == self type and: prop isMultivalued not ] ].
	^ collectedProperties
		ifNotEmpty: [ (collectedProperties
				fold:
					[ :availableProperties :entityProperties | availableProperties & entityProperties ])
				collect: #name ]
]

{ #category : #accessing }
FQPropertyQuery >> comparator [
	^ comparator
]

{ #category : #accessing }
FQPropertyQuery >> comparator: anObject [
	comparator := anObject
]

{ #category : #printing }
FQPropertyQuery >> displayOn: aStream with: aString [
	aStream << aString << ' select: [ :entity | entity '
		<< self property asString.
	self hasComparisonParameters
		ifTrue: [ aStream
				space;
				<< self comparator asString;
				space;
				<< self valueToCompareAsString ].
	aStream << ' ]'
]

{ #category : #testing }
FQPropertyQuery >> hasComparisonParameters [
	^ true
]

{ #category : #testing }
FQPropertyQuery >> isValid [
	^ self property isNotNil
]

{ #category : #accessing }
FQPropertyQuery >> property [
	^ property
]

{ #category : #accessing }
FQPropertyQuery >> property: anObject [
	property := anObject
]

{ #category : #running }
FQPropertyQuery >> runOn: aMooseGroup [
	^ aMooseGroup
		select: [ :entity | 
			(self property value: entity)
				perform: self comparator
				with: self valueToCompare ]
]

{ #category : #printing }
FQPropertyQuery >> storeOn: aStream [
	aStream << self simpleClassName << ' new property: '.
	self property storeOn: aStream.
	self hasComparisonParameters
		ifFalse: [ ^ self ].
	aStream << '; comparator: '.
	self comparator storeOn: aStream.
	aStream
		<< '; valueToCompare: ';
		<< self valueToCompareAsString
]

{ #category : #'available parameters' }
FQPropertyQuery >> type [
	^ self subclassResponsibility
]

{ #category : #accessing }
FQPropertyQuery >> valueToCompare [
	^ valueToCompare
		ifNil: [ valueToCompare := self class defaultValueToCompare ]
]

{ #category : #accessing }
FQPropertyQuery >> valueToCompare: anObject [
	valueToCompare := anObject
]

{ #category : #printing }
FQPropertyQuery >> valueToCompareAsString [
	^ self subclassResponsibility
]
