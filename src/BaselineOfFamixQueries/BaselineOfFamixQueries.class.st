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
			self midas: spec.

			"Packages"
			spec
				package: 'Famix-Queries' with: [ spec requires: #('Famix') ];
				package: 'Famix-Queries-Tests'
					with: [ spec requires: #('Famix-Queries') ];
				package: 'Famix-Queries-Browser'
					with: [ spec requires: #('Famix-Queries' 'Midas') ];
				package: 'Famix-Queries-Browser-Tests'
					with: [ spec requires: #('Famix-Queries-Browser' 'Famix-Queries-Tests') ].

			"Groups"
			spec
				group: 'Model' with: #('Famix-Queries');
				group: 'Browser' with: #('Famix-Queries-Browser');
				group: 'Tests' with: #('Famix-Queries-Browser-Tests') ]
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

{ #category : #dependencies }
BaselineOfFamixQueries >> roassal3: spec [
	spec
		baseline: 'Roassal3'
		with: [ spec repository: 'github://ObjectProfile/Roassal3/src' ]
]
