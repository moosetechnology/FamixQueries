"
Implements a manual select query.
It has a ""script"" (a pharo block with one argument) that select entities from a collection of MooseEntities
"
Class {
	#name : 'FQSelectScriptQuery',
	#superclass : 'FQScriptQuery',
	#category : 'Famix-Queries-Queries-Unary',
	#package : 'Famix-Queries',
	#tag : 'Queries-Unary'
}

{ #category : 'default' }
FQSelectScriptQuery >> beDefaultForParent [
	script := [ :each | false ]
]

{ #category : 'printing' }
FQSelectScriptQuery >> defaultName [
	^ String
		streamContents: [ :s | 
			s << 'select: ' <<
			(script asString truncateWithElipsisTo: 20) ]
]

{ #category : 'running' }
FQSelectScriptQuery >> rawRunOn: aMooseGroup [
	"I should run myself on the MooseGroup as parameter and return a new MooseGroup with my result."

	^ aMooseGroup select: script
]
