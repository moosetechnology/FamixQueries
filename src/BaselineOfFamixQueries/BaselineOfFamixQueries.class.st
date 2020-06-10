"
BaselineOfMooseSpec
"
Class {
	#name : #BaselineOfFamixQueries,
	#superclass : #BaselineOf,
	#category : #BaselineOfFamixQueries
}

{ #category : #baseline }
BaselineOfFamixQueries >> baseline: spec [
	<baseline>
	spec
		for: #common
		do: [ self famix: spec.

			"Packages"
			spec
				package: 'Famix-Queries' with: [ spec requires: #('Famix') ];
				package: 'Famix-Queries-Tests'
					with: [ spec requires: #('Famix-Queries') ].

			"Groups"
			spec
				group: 'Model' with: #('Famix-Queries');
				group: 'Tests' with: #('Famix-Queries-Tests') ]
]

{ #category : #dependencies }
BaselineOfFamixQueries >> famix: spec [
	spec
		baseline: 'Famix'
		with: [ spec repository: 'github://moosetechnology/Famix:development/src' ]
]

{ #category : #dependencies }
BaselineOfFamixQueries >> midas: spec [
	spec
		baseline: 'Midas'
		with: [ spec repository: 'github://moosetechnology/Midas:master/src' ]
]
