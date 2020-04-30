Class {
	#name : #FQTreeTablePresenter,
	#superclass : #SpTreeTablePresenter,
	#category : #'Famix-Queries-Browser-Presenters'
}

{ #category : #commands }
FQTreeTablePresenter class >> buildCommandsGroupWith: presenterIntance forRoot: rootCommandGroup [
	rootCommandGroup
		register:
			(FQAddQueryCommand forSpec
				iconName: #add;
				yourself)
]

{ #category : #'accessing model' }
FQTreeTablePresenter >> adaptToOwner [
	self
		addColumn:
			(SpCompositeTableColumn new
				title: 'Queries';
				addColumn: (SpStringTableColumn new evaluated: [ :wrapper | wrapper label ]));
		roots: {owner initialQuery};
		children: #children;
		selectItem: owner initialQuery;
		contextMenuFromCommandsGroup: [ self rootCommandsGroup ];
		activateOnDoubleClick;
		whenSelectionChangedDo: [ :selection | owner selectedQuery: selection selectedItem ];
		whenActivatedDo: [ :selection | (FQQueryCreationPresenter on: owner) openWithSpec ]
]
