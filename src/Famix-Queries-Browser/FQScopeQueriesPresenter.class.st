Class {
	#name : #FQScopeQueriesPresenter,
	#superclass : #FQQueryConfigurationPresenter,
	#instVars : [
		'directions',
		'scopes'
	],
	#category : #'Famix-Queries-Browser-Presenters'
}

{ #category : #specs }
FQScopeQueriesPresenter class >> defaultSpec [
	^ SpBoxLayout newHorizontal
		add: #directions;
		add: self scopes;
		add: self creationButton;
		spacing: 5;
		yourself
]

{ #category : #specs }
FQScopeQueriesPresenter class >> open [
	<script>
	(self
		on:
			(FQQueryBuilder default
				buildScopeQueryWithDirection: FQScopeUpDirection;
				yourself)) openWithSpec
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
FQScopeQueriesPresenter >> initializeBuilder [
	queryBuilder buildScopeQuery
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
	scopes := self newDropList
		whenSelectedItemChangedDo: [ :scope | self queryBuilder changeQueryScope: scope ];
		items: self queryBuilder availableScopes;
		display: [ :item | item name withoutPrefix: self modelPrefix ]
]

{ #category : #initialization }
FQScopeQueriesPresenter >> intializeDirectionRadioButtons [
	directions := SpDynamicPresentersListBuilder new
		modelObjects: queryBuilder availableScopeDirections;
		presenter: SpRadioButtonPresenter
			configuredAs: [ :presenter :modelObject | 
			presenter
				label: modelObject label;
				whenActivatedDo: [ self queryBuilder buildScopeQueryWithDirection: modelObject.
					self updateScopes ];
				yourself ];
		layoutBuilder: (SpDynamicTopToBottomRowsLayout rows: 1);
		build.
	directions presenters first
		associatedRadioButtons: directions presenters allButFirst
]

{ #category : #initialization }
FQScopeQueriesPresenter >> updateScopes [
	scopes
		resetSelection;
		items: self queryBuilder availableScopes.
	scopes listItems
		ifEmpty: [ self button disable ]
		ifNotEmpty: [ self button enable ]
]
