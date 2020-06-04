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

{ #category : #naming }
FQResultTreePresenter >> modelPrefix [
	"Does not work with FAMIXEntities"

	^ self roots first mooseModel className withoutSuffix: 'Model'
]

{ #category : #'accessing model' }
FQResultTreePresenter >> setModelBeforeInitialization: aBrowser [
	browser := aBrowser
]

{ #category : #naming }
FQResultTreePresenter >> stringForItem: item [
	(self roots includes: item)
		ifTrue: [ ^ self stringForRoot: item ].
	^ item name
]

{ #category : #naming }
FQResultTreePresenter >> stringForRoot: item [
	^ String
		streamContents: [ :s | 
			| typeName |
			typeName := item first className withoutPrefix: self modelPrefix.
			s
				print: item size;
				<< Character space;
				<<
					(item size > 1
						ifTrue: [ typeName asEnglishPlural ]
						ifFalse: [ typeName ]) ]
]

{ #category : #update }
FQResultTreePresenter >> updateForEntities: entities [
	items := entities.
	self
		roots:
			((entities collectAsSet: #class)
				collect:
					[ :type | (items select: [ :entity | entity class == type ]) asMooseGroup ])
				asOrderedCollection.
	self update
]

{ #category : #update }
FQResultTreePresenter >> updateMenu [
	self contextMenuFromCommandsGroup: [ self rootCommandsGroup ].
	"	self contextMenu: self newMenu."
	"	self contextMenu
		addItem: [ :menuItem | 
			menuItem
				name: 'Inspect';
				action: [ self miSelectedItem inspect ] ].
	(self canCreateQueries
		and: [ self roots includesAll: self selectedItems ])
		ifFalse: [ ^ self ]."
"	self contextMenu
		addItem: [ :menuItem | 
			menuItem
				name: 'Create new type query';
				action:
						[ self createTypeQuery ] ]"
]
