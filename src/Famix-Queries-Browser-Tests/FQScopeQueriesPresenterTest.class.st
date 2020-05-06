Class {
	#name : #FQScopeQueriesPresenterTest,
	#superclass : #FQQueryConfigurationPresenterTest,
	#category : #'Famix-Queries-Browser-Tests-Presenters'
}

{ #category : #helpers }
FQScopeQueriesPresenterTest >> dropList [
	^ presenter secondParameter
]

{ #category : #helpers }
FQScopeQueriesPresenterTest >> presenterClass [
	^ FQScopeQueriesPresenter
]

{ #category : #helpers }
FQScopeQueriesPresenterTest >> radioButtons [
	^ presenter firstParameter presenters
		reject: [ :pres | pres class = SpNullPresenter ]
]

{ #category : #tests }
FQScopeQueriesPresenterTest >> testChangingDirectionChangesAvailableScopes [
	| initialScopes |
	initialScopes := self queryBuilder availableScopes copy.
	
	(self radioButtons
		detect: [ :radioButton | radioButton state not ]) click.
	
	self
		denyCollection: initialScopes
		hasSameElements: self queryBuilder availableScopes
]

{ #category : #tests }
FQScopeQueriesPresenterTest >> testDropListMatchesAvailableScopes [
	| scopes |
	scopes := self queryBuilder availableScopes.
	
	self assert: self dropList listItems size equals: scopes size.
	
	self assertCollection: scopes hasSameElements: self dropList listItems .
]

{ #category : #tests }
FQScopeQueriesPresenterTest >> testDropListMatchesForOtherDirection [

	(self radioButtons
		detect: [ :radioButton | radioButton state not ]) click.

	self testDropListMatchesAvailableScopes.
	self testDropListMatchesQuery
]

{ #category : #tests }
FQScopeQueriesPresenterTest >> testDropListMatchesQuery [
	self
		assert: self dropList selectedItem
		equals: self currentQuery scope.
	
	self dropList selectItem:
		(self queryBuilder availableScopes
			detect: [ :scope | self currentQuery scope ~~ scope ]).

	self
		assert: self dropList selectedItem
		equals: self currentQuery scope
]

{ #category : #tests }
FQScopeQueriesPresenterTest >> testFirstParameter [
	self assert:
		(presenter firstParameter presenters
			allSatisfy: [ :pres | pres class == SpRadioButtonPresenter ]).

	self resetPresenterWithEntities: helper noEntities.
	self assert:
		(presenter firstParameter presenters
			allSatisfy: [ :pres | pres class == SpRadioButtonPresenter ])
]

{ #category : #tests }
FQScopeQueriesPresenterTest >> testNoScopesForADirection [
	self resetPresenterWithEntities: helper entitiesWithNoDownScope.
	
	(presenter firstParameter presenters
		detect: [ :radioButton | radioButton label = 'Down' ]) click.
	
	self
		assert: presenter secondParameter class
		identicalTo: FQNoPossibleQueryPresenter
]

{ #category : #tests }
FQScopeQueriesPresenterTest >> testQueryValidity [
	self assert: self queryBuilder queryIsValid.
	
	(self radioButtons detect: [ :rb | rb state not ]) click.
	self assert: self queryBuilder queryIsValid.
	
	self dropList selectItem: (self dropList listItems copyWithout: self dropList selectedItem) anyOne.
	self assert: self queryBuilder queryIsValid.
	
	self resetPresenterWithEntities: helper entitiesWithNoDownScope.
	(presenter firstParameter presenters
		detect: [ :radioButton | radioButton label = 'Down' ]) click.
	self deny: self queryBuilder queryIsValid.
	
	self resetPresenterWithEntities: helper noEntities.
	self deny: self queryBuilder queryIsValid. 
]

{ #category : #tests }
FQScopeQueriesPresenterTest >> testRadioButtonsMatchAvailableDirections [
	| directions |
	directions := self queryBuilder availableScopeDirections.
	
	self assert: self radioButtons size equals: directions size.
	
	self
		assertCollection: (directions collect: #label)
		hasSameElements: (self radioButtons collect: #label)
]

{ #category : #tests }
FQScopeQueriesPresenterTest >> testRadioButtonsMatchQuery [
	self
		assert: (self radioButtons detect: #state) label
		equals: self currentQuery directionStrategy label.
	
	(self radioButtons detect: [ :rb | rb state not ]) click.
	self
		assert: (self radioButtons detect: #state) label
		equals: self currentQuery directionStrategy label
]

{ #category : #tests }
FQScopeQueriesPresenterTest >> testSecondParameter [
	self
		assert: presenter secondParameter class
		identicalTo: SpDropListPresenter.
	
	self resetPresenterWithEntities: helper noEntities.
	self
		assert: presenter secondParameter class
		identicalTo: FQNoPossibleQueryPresenter
]
