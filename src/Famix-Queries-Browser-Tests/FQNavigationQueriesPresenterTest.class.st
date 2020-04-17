Class {
	#name : #FQNavigationQueriesPresenterTest,
	#superclass : #FQQueryConfigurationPresenterTest,
	#category : #'Famix-Queries-Browser-Tests-Presenters'
}

{ #category : #helpers }
FQNavigationQueriesPresenterTest >> checkBoxes [
	^ presenter secondParameter presenters
		reject: [ :pres | pres class = SpNullPresenter ]
]

{ #category : #helpers }
FQNavigationQueriesPresenterTest >> presenterClass [
	^ FQNavigationQueriesPresenter
]

{ #category : #helpers }
FQNavigationQueriesPresenterTest >> radioButtons [
	^ presenter firstParameter presenters
		reject: [ :pres | pres class = SpNullPresenter ]
]

{ #category : #tests }
FQNavigationQueriesPresenterTest >> testCheckBoxesEnabledOnlyWhenAvailable [
	| availableAssociations |
	availableAssociations := self queryBuilder availableAssociations.
	
	self
		assert: (self checkBoxes select: #isEnabled) size
		equals: availableAssociations size.
	
	self
		assertCollection: (self checkBoxes select: #isEnabled thenCollect: #label)
		hasSameElements:
			(availableAssociations
				collect: [ :association | association name withoutPrefix: 'FamixT' ])
]

{ #category : #tests }
FQNavigationQueriesPresenterTest >> testCheckBoxesMatchAllPossibleAssociations [
	| allAssociations |
	allAssociations := self queryBuilder allPossibleAssociations.
	
	self assert: self checkBoxes size equals: allAssociations size.
	
	self
		assertCollection:
			(allAssociations
				collect: [ :assoc | assoc name withoutPrefix: 'FamixT' ])
		hasSameElements: (self checkBoxes collect: #label)
]

{ #category : #tests }
FQNavigationQueriesPresenterTest >> testCheckBoxesMatchAvailableAssociations [
	| availableAssociations |
	availableAssociations := self queryBuilder availableAssociations.
	
	self
		assert: (self checkBoxes select: #state) size
		equals: availableAssociations size.
	
	self
		assertCollection:
			(availableAssociations
				collect: [ :assoc | assoc name withoutPrefix: 'FamixT' ])
		hasSameElements: (self checkBoxes select: #state thenCollect: #label)
]

{ #category : #tests }
FQNavigationQueriesPresenterTest >> testCheckBoxesMatchForOtherDirection [
	(self radioButtons detect: [ :rb | rb state not ]) click.
	
	self testCheckBoxesMatchAllPossibleAssociations.
	self testCheckBoxesMatchAvailableAssociations.
	self testCheckBoxesMatchQuery
]

{ #category : #tests }
FQNavigationQueriesPresenterTest >> testCheckBoxesMatchQuery [
	| currentQueryAssociations |
	
	currentQueryAssociations := self queryBuilder currentQueryAssociations
		collect: [ :type | type name withoutPrefix: 'FamixT' ].
	
	self
		assertCollection: currentQueryAssociations
		hasSameElements: (self checkBoxes select: #state thenCollect: #label).
	
	self
		denyCollection: currentQueryAssociations
		hasSameElements: (self checkBoxes reject: #state thenCollect: #label)
]

{ #category : #tests }
FQNavigationQueriesPresenterTest >> testFirstParameter [
	self assert:
		(presenter firstParameter presenters
			allSatisfy: [ :pres | pres class == SpRadioButtonPresenter ]).

	presenter := self presenterClass on: helper noEntities.
	self assert:
		(presenter firstParameter presenters
			allSatisfy: [ :pres | pres class == SpRadioButtonPresenter ])
]

{ #category : #tests }
FQNavigationQueriesPresenterTest >> testRadioButtonsMatchAvailableDirections [
	| directions |
	directions := self queryBuilder availableDirections.
	
	self assert: self radioButtons size equals: directions size.
	
	self
		assertCollection: (self radioButtons collect: #label)
		hasSameElements: (directions collect: #label)
]

{ #category : #tests }
FQNavigationQueriesPresenterTest >> testRadioButtonsMatchQuery [
	self
		assert: (self radioButtons detect: #state) label
		equals: self currentQuery direction label.
	
	(self radioButtons detect: [ :rb | rb state not ]) click.
	self
		assert: (self radioButtons detect: #state) label
		equals: self currentQuery direction label
]

{ #category : #tests }
FQNavigationQueriesPresenterTest >> testSecondParameter [
	self assert:
		(presenter secondParameter presenters
			allSatisfy: [ :pres | 
				pres class == SpCheckBoxPresenter
				"Could be some SpNullPresenter depending on the dynamic layout 
				but it is not the case here" ]).

	presenter := self presenterClass on: helper noEntities.
	self
		assert: presenter secondParameter class
		identicalTo: FQNoPossibleQueryPresenter
]
