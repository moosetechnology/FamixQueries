Class {
	#name : #FQPropertyQueriesPresenterHelper,
	#superclass : #Object,
	#instVars : [
		'configurators'
	],
	#category : #'Famix-Queries-Browser-Tools'
}

{ #category : #configurators }
FQPropertyQueriesPresenterHelper >> booleanConfigurator [
	^ {FQDropListConfigurator}
]

{ #category : #accessing }
FQPropertyQueriesPresenterHelper >> configuratorFor: aQueryType [
	^ configurators at: aQueryType
]

{ #category : #accessing }
FQPropertyQueriesPresenterHelper >> configuratorTyped: aQueryType forQuery: aQuery onEntities: entities [
	self flag: 'Of course not ! Not always availableProperties !'.
	^ (configurators at: aQueryType)
		collect: [ :configuratorClass | 
			configuratorClass
				items: (aQuery availablePropertiesFor: entities)
				changeBlock: [ :property | aQuery property: property ] ]
]

{ #category : #initialization }
FQPropertyQueriesPresenterHelper >> initialize [
	configurators := Dictionary
		newFromKeys: self propertiesTypes
		andValues:
			{self booleanConfigurator.
			self numericConfigurators.
			self stringConfigurators}
]

{ #category : #configurators }
FQPropertyQueriesPresenterHelper >> numericConfigurators [
	^ {FQDropListConfigurator.
	FQDropListConfigurator.
	FQNumberInputConfigurator}
]

{ #category : #accessing }
FQPropertyQueriesPresenterHelper >> propertiesTypes [
	^ OrderedCollection withAll: {#boolean . #numeric . #string}
]

{ #category : #configurators }
FQPropertyQueriesPresenterHelper >> stringConfigurators [
	^ {FQDropListConfigurator.
	FQDropListConfigurator.
	FQTextInputConfigurator}
]
