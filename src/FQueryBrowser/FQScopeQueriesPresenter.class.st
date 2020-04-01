Class {
	#name : #FQScopeQueriesPresenter,
	#superclass : #FQQueryConfigurationPresenter,
	#instVars : [
		'up',
		'upAndDown',
		'down',
		'scopes'
	],
	#category : #'FQueryBrowser-Presenters'
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
	self intializeDirections.
	scopes := self newDropList
		whenSelectedItemChangedDo: [ :scope | self model chooseScope: scope ];
		items: self model currentPossibleScopes.
	self updateScopes
]

{ #category : #initialization }
FQScopeQueriesPresenter >> intializeDirections [
	up := self newRadioButton
		label: (self model directions at: #up);
		whenActivatedDo: [ self model chooseDirection: #up.
			self updateScopes ].
	upAndDown := self newRadioButton
		label: (self model directions at: #upAndDown);
		whenActivatedDo: [ self model chooseDirection: #upAndDown.
			self updateScopes ].
	down := self newRadioButton
		label: (self model directions at: #down);
		whenActivatedDo: [ self model chooseDirection: #down.
			self updateScopes ].
	upAndDown
		associatedRadioButtons:
			{up.
			down}
]

{ #category : #initialization }
FQScopeQueriesPresenter >> updateScopes [
	scopes
		resetSelection;
		items: self model currentPossibleScopes
]
