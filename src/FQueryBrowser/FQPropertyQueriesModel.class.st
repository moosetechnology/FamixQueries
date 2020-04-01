Class {
	#name : #FQPropertyQueriesModel,
	#superclass : #FQQueriesModel,
	#instVars : [
		'query',
		'propertiesTypes',
		'parametersDict'
	],
	#category : #'FQueryBrowser-Models'
}

{ #category : #'instance creation' }
FQPropertyQueriesModel class >> default [
	^ self basicNew
		propertiesTypes: self propertiesTypes;
		initialize;
		"parametersDict: self propertiesParameters;"
			yourself
]

{ #category : #boolean }
FQPropertyQueriesModel class >> defaultBooleanProperties [
	^ #(#isAbstract #isPrivate #isPublic #hasModifiers)
]

{ #category : #numeric }
FQPropertyQueriesModel class >> defaultNumericComparators [
	^ #(#< #<= #= #>= #>)
]

{ #category : #numeric }
FQPropertyQueriesModel class >> defaultNumericProperties [
	^ #(#numberOfMethods #numberOfLinesOfCode #numberOfArguments)
]

{ #category : #string }
FQPropertyQueriesModel class >> defaultStringComparators [
	^ #(#includesSubstring: #beginsWith: #matchesRegex:)
]

{ #category : #string }
FQPropertyQueriesModel class >> defaultStringProperties [
	^ #(#name #selector #sourceCode)
]

{ #category : #accessing }
FQPropertyQueriesModel class >> propertiesTypes [
	^ OrderedCollection withAll: {#boolean . #numeric . #string}
]

{ #category : #configurators }
FQPropertyQueriesModel >> booleanConfigurator [
	^ {(FQDropListConfigurator
		model: self
		parameterToChange: 2
		items: self class defaultBooleanProperties)}
]

{ #category : #'query creation' }
FQPropertyQueriesModel >> createQuery [
	^ (query asOrderedCollection reject: #isNil) asArray printString
]

{ #category : #initialization }
FQPropertyQueriesModel >> initialize [
	super initialize.
	self initializeParametersDict.
	query := Array new: 4
]

{ #category : #initialization }
FQPropertyQueriesModel >> initializeParametersDict [
	parametersDict := Dictionary
		newFromKeys: self propertiesTypes
		andValues:
			{self booleanConfigurator.
			self numericConfigurators.
			self stringConfigurators}
]

{ #category : #'instance creation' }
FQPropertyQueriesModel >> newQueryTyped: aQueryType [
	query := (Array new: 4)
		at: 1 put: aQueryType;
		yourself
]

{ #category : #configurators }
FQPropertyQueriesModel >> numericConfigurators [
	^ {(FQDropListConfigurator
		model: self
		parameterToChange: 2
		items: self class defaultNumericProperties).
	(FQDropListConfigurator
		model: self
		parameterToChange: 3
		items: self class defaultNumericComparators).
	(FQNumberInputConfigurator
		model: self
		parameterToChange: 4
		defaultText: 'Your numeric value')}
]

{ #category : #accessing }
FQPropertyQueriesModel >> parametersDict [
	^ parametersDict
]

{ #category : #accessing }
FQPropertyQueriesModel >> parametersDict: anObject [
	parametersDict := anObject
]

{ #category : #accessing }
FQPropertyQueriesModel >> propertiesTypes [
	^ propertiesTypes
]

{ #category : #accessing }
FQPropertyQueriesModel >> propertiesTypes: anObject [
	propertiesTypes := anObject
]

{ #category : #initialization }
FQPropertyQueriesModel >> propertyType: aType selector: aSelector comparator: aComparator value: aValue [
	query := {aType.
	aSelector.
	aComparator.
	aValue}
]

{ #category : #accessing }
FQPropertyQueriesModel >> queryAt: index [
	^ query at: index
]

{ #category : #accessing }
FQPropertyQueriesModel >> queryAt: index put: value [
	query at: index put: value
]

{ #category : #configurators }
FQPropertyQueriesModel >> stringConfigurators [
	^ {(FQDropListConfigurator
		model: self
		parameterToChange: 2
		items: self class defaultStringProperties).
	(FQDropListConfigurator
		model: self
		parameterToChange: 3
		items: self class defaultStringComparators).
	(FQTextInputConfigurator
		model: self
		parameterToChange: 4
		defaultText: 'Your string or regex')}
]
