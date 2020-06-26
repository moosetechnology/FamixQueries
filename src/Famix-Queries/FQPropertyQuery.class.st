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
FQPropertyQuery class >> availablePropertiesFor: aMooseGroup [
	^ ((aMooseGroup allEntityTypes collect: [ :entity | entity famePropertiesOfType: self type ])
		fold: [ :availableProperties :entityProperties | availableProperties & entityProperties ]) collect: #implementingSelector
]

{ #category : #'available parameters' }
FQPropertyQuery class >> comparators [
	self subclassResponsibility
]

{ #category : #default }
FQPropertyQuery class >> isAbstract [
	^ self == FQPropertyQuery
]

{ #category : #accessing }
FQPropertyQuery class >> label [
	^ 'Property Query'
]

{ #category : #'available parameters' }
FQPropertyQuery class >> type [
	^ self subclassResponsibility
]

{ #category : #'available parameters' }
FQPropertyQuery >> availableProperties [
	self flag: #FQTest.
	^ (parent isNil or: [ parent result isEmpty ])
		ifTrue: [ #() ]
		ifFalse: [ self availablePropertiesFor: parent result ]
]

{ #category : #'available parameters' }
FQPropertyQuery >> availablePropertiesFor: aMooseGroup [
	^ self class availablePropertiesFor: aMooseGroup
]

{ #category : #default }
FQPropertyQuery >> beDefaultForParent [
	property := self availableProperties
		ifEmpty: [ nil ]
		ifNotEmpty: [ :properties | properties first ].
	self hasComparisonParameters
		ifTrue: [ comparator := self class comparators first ]
]

{ #category : #accessing }
FQPropertyQuery >> comparator [
	^ comparator ifNil: [ comparator := self class defaultComparator ]
]

{ #category : #accessing }
FQPropertyQuery >> comparator: anObject [
	comparator := anObject.
	self resetResult.
	self flag: #FQTest , 'Test reset result'
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
	property := anObject.
	self resetResult.
	self flag: #FQTest , 'Test reset result'
]

{ #category : #running }
FQPropertyQuery >> runOn: aMooseGroup [
	self flag: #FQImprove , 'This false on error is not optimal'.
	^ aMooseGroup
		select: [ :entity | 
			[ (self property value: entity)
				ifNil: [ false ]
				ifNotNil:
					[ :entityProperty | entityProperty perform: self comparator with: self valueToCompare ] ]
				on: MessageNotUnderstood
				do: [ false ] ]
]

{ #category : #printing }
FQPropertyQuery >> storeOn: aStream [
	aStream << self className << ' property: '.
	self property storeOn: aStream.
	self hasComparisonParameters
		ifFalse: [ ^ self ].
	aStream << ' comparator: '.
	self comparator storeOn: aStream.
	aStream << ' valueToCompare: '.
	self valueToCompare storeOn: aStream
]

{ #category : #accessing }
FQPropertyQuery >> type [
	^ self class type
]

{ #category : #accessing }
FQPropertyQuery >> valueToCompare [
	^ valueToCompare
		ifNil: [ valueToCompare := self class defaultValueToCompare ]
]

{ #category : #accessing }
FQPropertyQuery >> valueToCompare: anObject [
	valueToCompare := anObject.
	self resetResult.
	self flag: #FQTest , 'Test reset result'
]

{ #category : #printing }
FQPropertyQuery >> valueToCompareAsString [
	^ self subclassResponsibility
]
