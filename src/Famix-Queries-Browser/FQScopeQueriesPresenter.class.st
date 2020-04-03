Class {
	#name : #FQScopeQueriesPresenter,
	#superclass : #FQQueryConfigurationPresenter,
	#instVars : [
		'up',
		'upAndDown',
		'down',
		'scopes'
	],
	#category : #'Famix-Queries-Browser-Presenters'
}

{ #category : #specs }
FQScopeQueriesPresenter class >> defaultSpec [
	^ SpBoxLayout newHorizontal
		add:
			(SpBoxLayout newVertical
				add: #up;
				add: #upAndDown;
				add: #down;
				yourself);
		add: self scopes;
		add: self creationButton;
		spacing: 5;
		yourself
]

{ #category : #specs }
FQScopeQueriesPresenter class >> open [
	<script>
	(self on: FQScopeQueriesModel default) openWithSpec
]

{ #category : #specs }
FQScopeQueriesPresenter class >> scopes [
	^ SpBoxLayout newVertical
		add: #scopes
			expand: true
			fill: true
			padding: 50;
		yourself
]

{ #category : #specs }
FQScopeQueriesPresenter class >> title [
	^ 'Scope Query'
]

{ #category : #initialization }
FQScopeQueriesPresenter >> initializePresenters [
	super initializePresenters.
	self intializeDirectionRadioButtons.
	self initializeScopeDropList.
	self updateScopes
]

{ #category : #initialization }
FQScopeQueriesPresenter >> initializeScopeDropList [
	| newScopes prefix |
	newScopes := self queryBuilder availableScopes.
	prefix := (newScopes collect: #name)
		inject: newScopes first name
		into: [ :pref :name | 
			| size |
			size := name charactersExactlyMatching: pref.
			name first: size ].
	scopes := self newDropList
		whenSelectedItemChangedDo: [ :scope | self queryBuilder changeQueryScope: scope ];
		items: self queryBuilder availableScopes;
		display: [ :item | item name withoutPrefix: prefix ]
]

{ #category : #initialization }
FQScopeQueriesPresenter >> intializeDirectionRadioButtons [
	up := self newRadioButton
		label: 'Up';
		whenActivatedDo: [ self queryBuilder buildScopeQuery: #up.
			self updateScopes ].
	upAndDown := self newRadioButton
		label: 'Up and Down';
		whenActivatedDo: [ self queryBuilder buildScopeQuery: #upAndDown.
			self updateScopes ].
	down := self newRadioButton
		label: 'Down';
		whenActivatedDo: [ self queryBuilder buildScopeQuery: #down.
			self updateScopes ].
	upAndDown
		associatedRadioButtons:
			{up.
			down}.
	queryBuilder buildScopeQuery: #upAndDown
]

{ #category : #initialization }
FQScopeQueriesPresenter >> updateScopes [
	scopes
		resetSelection;
		items: self queryBuilder availableScopes
]
