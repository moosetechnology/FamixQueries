"
I am a query that can be applied on a MooseGroup.

----- Query -----
I select entities according to one of their properties.
A property is a Boolean, numeric or String value. 
Selection is based:
	- on the value of the entity if it is Boolean. Example: 'aMooseGroup select: #isAbstract'.
	- on the comparison between the entity and a reference value 
		Examples: 'aMooseGroup select: [ :entity | entity numberOfMethods > 10 ]'
			'aMooseGroup select: [ :entity | entity name includesSubstring: 'Prefix' ]'.

----- Parameters -----
I have tree parameters:
	- property <Symbol>: the selector used to access the entities property.
	- comparator <Symbol>: the comparison operator. Not necessary for Boolean queries.
	- valueToCompare <Number or String>: the reference value. Not necessary for Boolean queries.

----- API -----
- Running : see FQAbstractQuery comment
- Printing : see FQAbstractQuery comment
- Changing parameters: 
	Use setting accessors.
- Comparing:
	Two type queries are equal if their parameters are the same.
- Available properties:
	Accessors to properties of the correct type that are common to all entities in the input MooseGroup.

----- Validity -----
I am valid if my parameters are set.
See subclasses for details

----- Instance Creation -----
See subclasses
"
Class {
	#name : #FQPropertyQuery,
	#superclass : #FQUnaryQuery,
	#instVars : [
		'property',
		'valueToCompare',
		'comparator'
	],
	#category : #'Famix-Queries-Queries-Unary'
}

{ #category : #accessing }
FQPropertyQuery class >> availablePropertyTypes [
	^ FQPropertyQuery allSubclasses
]

{ #category : #accessing }
FQPropertyQuery class >> label [
	^ 'Property Query'
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
FQPropertyQuery >> defaultName [
	^ String
		streamContents: [ :aStream | 
			aStream << self property.
			self hasComparisonParameters
				ifTrue: [ aStream << ' ' << self comparator << ' '
						<< self valueToCompareAsString ] ]
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

{ #category : #comparing }
FQPropertyQuery >> hasSameParametersAs: aQuery [
	^ property == aQuery property
]

{ #category : #testing }
FQPropertyQuery >> isValid [
	^ self property isSymbol
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
	aStream << self className << ' new property: '.
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
