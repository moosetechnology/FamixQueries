Class {
	#name : #FQResultTreePresenter,
	#superclass : #SpTreeTablePresenter,
	#instVars : [
		'browser',
		'items'
	],
	#category : #'Famix-Queries-Browser-Widgets'
}

{ #category : #commands }
FQResultTreePresenter class >> buildCommandsGroupWith: presenter forRoot: aCmCommandsGroup [
	aCmCommandsGroup
		register:
			((MiInspectCommand forSpecWithIconNamed: #glamorousInspect)
				context: presenter);
		register:
			((MiPropagateCommand forSpecWithIconNamed: #moosePropagate)
				context: presenter);
		register:
			((FQTypeQueryCreationCommand forSpecWithIconNamed: #add)
				context: presenter) beHiddenWhenCantBeRun
]

{ #category : #accessing }
FQResultTreePresenter class >> headerTitle [
	^ 'Result of current query'
]

{ #category : #testing }
FQResultTreePresenter >> canCreateQueries [
	^ owner == browser
]

{ #category : #initialization }
FQResultTreePresenter >> childrenOf: item [
	^ (self roots includes: item)
		ifTrue: [ item entities sort: #name ascending ]
		ifFalse: {}
]

{ #category : #action }
FQResultTreePresenter >> createQueryForType: aClass [
	browser
		updateForQuery:
			(FQTypeQuery new
				type: aClass;
				beChildOf: browser selectedQuery)
]

{ #category : #action }
FQResultTreePresenter >> createQueryForTypes: classes [
	| newTypeQuery |
	newTypeQuery := FQTypeQuery new beChildOf: browser selectedQuery.
	classes do: [ :aClass | newTypeQuery type: aClass ].
	browser updateForQuery: newTypeQuery
]

{ #category : #action }
FQResultTreePresenter >> createTypeQuery [
	^ self
		createQueryForTypes: (self selectedItems flatten collect: #class) copyWithoutDuplicates
]

{ #category : #initialization }
FQResultTreePresenter >> initialize [
	super initialize.
	"self lazilyComputeChildren"	"useful in case of slowdown. See implementor"
	self
		addColumn:
			((SpCompositeTableColumn new title: self class headerTitle)
				addColumn:
					(SpStringTableColumn new
						evaluated: [ :item | self stringForItem: item ]));
		whenSelectionChangedDo: [ :selection | self updateMenu ];
		children: [ :item | self childrenOf: item ];
		beMultipleSelection
]

{ #category : #accessing }
FQResultTreePresenter >> items [
	^ items ifNil: [ items := MooseGroup new ]
]

{ #category : #accessing }
FQResultTreePresenter >> miSelectedItem [
	^ (self selectedItems
		collect: [ :item | 
			item isCollection
				ifTrue: [ item entities ]
				ifFalse: [ item ] ]) flattened copyWithoutDuplicates asMooseGroup
]

{ #category : #'accessing model' }
FQResultTreePresenter >> setModelBeforeInitialization: aBrowser [
	browser := aBrowser
]

{ #category : #naming }
FQResultTreePresenter >> stringForItem: item [
	(self roots includes: item)
		ifTrue: [ ^ item details ].
	^ item name
]

{ #category : #update }
FQResultTreePresenter >> updateForEntities: entities [
	items := entities.
	self
		roots:
			(((entities collectAsSet: #class)
				collect:
					[ :type | (items select: [ :entity | entity class == type ]) asMooseGroup ])
				asOrderedCollection
				sort: [ :root | root commonSuperclass name ] ascending).
	self update
]

{ #category : #update }
FQResultTreePresenter >> updateMenu [
	self contextMenuFromCommandsGroup: [ self rootCommandsGroup ]
]
