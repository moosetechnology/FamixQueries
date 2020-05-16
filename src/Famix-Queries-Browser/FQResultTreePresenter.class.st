Class {
	#name : #FQResultTreePresenter,
	#superclass : #SpTreeTablePresenter,
	#instVars : [
		'browser'
	],
	#category : #'Famix-Queries-Browser-Widgets'
}

{ #category : #testing }
FQResultTreePresenter >> canCreateQueries [
	^ owner == browser
]

{ #category : #action }
FQResultTreePresenter >> createQueryForType: aClass [
	browser
		updateForQuery:
			(FQTypeQuery new
				type: aClass;
				beChildOf: browser selectedQuery)
]

{ #category : #initialization }
FQResultTreePresenter >> initialize [
	super initialize.
	self
		"lazilyComputeChildren;"	"useful in case of slowdown. See implementor"
		addColumn:
			(SpCompositeTableColumn new
				title: 'Result of current query';
				addColumn:
					(SpStringTableColumn new
						evaluated: [ :item | self stringForItem: item ]));
		whenSelectionChangedDo: [ :selection | self updateMenu ]
]

{ #category : #accessing }
FQResultTreePresenter >> items [
	^ (self roots collect: [ :root | self childrenFor: root ]) flatten
]

{ #category : #'accessing model' }
FQResultTreePresenter >> setModelBeforeInitialization: aBrowser [
	browser := aBrowser
]

{ #category : #naming }
FQResultTreePresenter >> stringForItem: item [
	self flag: #FQImprove , 'Probably some optimization to do here'.
	item isMooseEntity
		ifFalse: [ ^ self
				stringForType: item
				nbOfEntities: (self items count: [ :entity | entity class == item ]) ].
	^ item name
]

{ #category : #naming }
FQResultTreePresenter >> stringForType: item nbOfEntities: nbEntities [
	self
		flag:
			#FQImprove
				, 'should this call browser or should modelPrefix be defined here ?'.
	^ String
		streamContents: [ :stream | 
			stream << nbEntities asString << ' '
				<<
					(nbEntities > 1
						ifTrue: [ (item name withoutPrefix: browser modelPrefix) asEnglishPlural ]
						ifFalse: [ item name withoutPrefix: browser modelPrefix ]) ]
]

{ #category : #update }
FQResultTreePresenter >> updateForEntities: entities [
	self
		roots: (entities collectAsSet: #class) asOrderedCollection;
		children: [ :type | 
			(entities select: [ :entity | entity class == type ])
				sorted: [ :e1 :e2 | e1 name < e2 name ] ]
]

{ #category : #update }
FQResultTreePresenter >> updateMenu [
	self contextMenu: self newMenu.
	(self canCreateQueries
		and: [ self roots includes: self selectedItem ])
		ifTrue: [ self contextMenu
				addItem: [ :menuItem | 
					menuItem
						name: 'Select ' , (self stringForItem: self selectedItem) substrings last;
						action: [ self createQueryForType: self selectedItem ] ] ]
]
