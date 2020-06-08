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

{ #category : #running }
FQScopeQueriesPresenter class >> queryClass [
	^ FQScopeQuery
]

{ #category : #specs }
FQScopeQueriesPresenter class >> title [
	^ 'Scope Query'
]

{ #category : #'widgets configuration' }
FQScopeQueriesPresenter >> configureRadioButton: radioButton forScopeDirection: direction [
	radioButton
		label: direction label;
		whenActivatedDo: [ self query resetAndChangeDirection: direction.
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
		modelObjects: self query directionStrategies;
		presenter: SpRadioButtonPresenter
			configuredAs:
				[ :radioButton :direction | self configureRadioButton: radioButton forScopeDirection: direction ];
		layoutBuilder: (SpDynamicTopToBottomRowsLayout rows: 1);
		build.
	firstParameter presenters first
		associatedRadioButtons: firstParameter presenters allButFirst.
	self selectCurrentQueryDirection
]

{ #category : #'widgets configuration' }
FQScopeQueriesPresenter >> scopesDropList [
	^ self newDropList
		items: self query availableScopes;
		display: [ :item | item name withoutPrefix: self modelPrefix ];
		selectItem: self query scope;
		whenSelectedItemChangedDo: [ :scope | 
			self flag: #FQImprove , 'When does that nil happen ?'.
			scope ifNil: [ ^ self ].
			self query scope: scope.
			self notifyQueryChanged ]
]

{ #category : #initialization }
FQScopeQueriesPresenter >> selectCurrentQueryDirection [
	(firstParameter presenters
		detect: [ :radioButton | radioButton label = self query directionStrategy label ])
		state: true
]

{ #category : #update }
FQScopeQueriesPresenter >> updateAccordingToDirection [
	secondParameter := self query availableScopes
		ifNotEmpty: [ self scopesDropList ]
		ifEmpty: [ self noParameterMessage: 'scope' ].
	self update
]
