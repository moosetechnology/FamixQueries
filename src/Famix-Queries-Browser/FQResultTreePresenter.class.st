Class {
	#name : #FQResultTreePresenter,
	#superclass : #SpTreeTablePresenter,
	#instVars : [
		'browser'
	],
	#category : #'Famix-Queries-Browser-Widgets'
}

{ #category : #initialization }
FQResultTreePresenter >> initialize [
	super initialize.
	self
		lazilyComputeChildren;
		addColumn:
			(SpCompositeTableColumn new
				title: 'Result of current query';
				addColumn:
					(SpStringTableColumn new
						evaluated: [ :item | self stringForItem: item ]))
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
