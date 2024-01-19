"
Implements a manual collect query.
It has a ""script"" (a pharo block with one argument) that collect entities from a collection of MooseEntities
"
Class {
	#name : #FQCollectScriptQuery,
	#superclass : #FQScriptQuery,
	#category : #'Famix-Queries-Queries-Unary'
}

{ #category : #default }
FQCollectScriptQuery >> beDefaultForParent [
	script := [ :each | false ]
]

{ #category : #printing }
FQCollectScriptQuery >> defaultName [
	^ String
		streamContents: [ :s | 
			s << 'collect: ' <<
			(script asString truncateWithElipsisTo: 20) ]
]

{ #category : #running }
FQCollectScriptQuery >> rawRunOn: aMooseGroup [

	^ (aMooseGroup rawAllUsing: TEntityMetaLevelDependency) inject: Set new into: [ :res :entity |
		  | collected |
		  collected := script value: entity.
		  collected isCollection
			  ifTrue: [ res addAll: collected ]
			  ifFalse: [ res add: collected ].
		  res ]
]
