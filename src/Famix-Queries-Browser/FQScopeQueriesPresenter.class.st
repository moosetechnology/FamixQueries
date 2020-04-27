Class {
	#name : #FQScopeQueriesPresenter,
	#superclass : #FQQueryConfigurationPresenter,
	#category : #'Famix-Queries-Browser-Presenters'
}

{ #category : #specs }
FQScopeQueriesPresenter class >> addSecondParameterToLayout: defaultLayout [
	defaultLayout
		add:
			(SpBoxLayout newVertical
				add: #secondParameter
					expand: true
					fill: true
					padding: 50;
				yourself)
]

{ #category : #specs }
FQScopeQueriesPresenter class >> open [
	<script>
	super open
]

{ #category : #initialization }
FQScopeQueriesPresenter class >> queryBuilderClass [
	^ FQScopeQueryBuilder
]

{ #category : #specs }
FQScopeQueriesPresenter class >> title [
	^ 'Scope Query'
]

{ #category : #'widgets configuration' }
FQScopeQueriesPresenter >> configureRadioButton: radioButton forScopeDirection: direction [
	radioButton
		label: direction label;
		whenActivatedDo: [ [ self queryBuilder changeQueryDirection: direction ]
				on: FQImpossibleQuery
				do: [ self flag: 'Manage this error better !!' ].
			self updateAccordingToDirection.
			self notifyQueryChanged ]
]

{ #category : #initialization }
FQScopeQueriesPresenter >> initializePresenters [
	self intializeDirectionRadioButtons.
	self initializeScopesDropList
]

{ #category : #initialization }
FQScopeQueriesPresenter >> initializeScopesDropList [
	self updateAccordingToDirection
]

{ #category : #initialization }
FQScopeQueriesPresenter >> intializeDirectionRadioButtons [
	firstParameter := SpDynamicPresentersListBuilder new
		modelObjects: queryBuilder availableScopeDirections;
		presenter: SpRadioButtonPresenter
			configuredAs:
				[ :radioButton :direction | self configureRadioButton: radioButton forScopeDirection: direction ];
		layoutBuilder: (SpDynamicTopToBottomRowsLayout rows: 1);
		build.
	firstParameter presenters first
		associatedRadioButtons: firstParameter presenters allButFirst
]

{ #category : #'widgets configuration' }
FQScopeQueriesPresenter >> scopesDropList [
	^ self newDropList
		items: self queryBuilder availableScopes;
		display: [ :item | item name withoutPrefix: self modelPrefix ];
		whenSelectedItemChangedDo: [ :scope | 
			self queryBuilder changeQueryScope: scope.
			self notifyQueryChanged ]
]

{ #category : #update }
FQScopeQueriesPresenter >> updateAccordingToDirection [
	secondParameter := self queryBuilder availableScopes
		ifNotEmpty: [ self scopesDropList ]
		ifEmpty: [ self noParameterMessage: 'scope' ].
	self update
]
