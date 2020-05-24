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
		do: [ "self roassal3: spec."
			self midas: spec.

			"Packages"
			spec
				package: 'Famix-Queries';
				package: 'Famix-Queries-Tests'
					with: [ spec requires: #('Famix-Queries') ];
				package: 'Famix-Queries-Browser'
					with: [ spec requires: #('Famix-Queries' 'Midas')	"'Roassal3'" ];
				package: 'Famix-Queries-Browser-Tests'
					with: [ spec requires: #('Famix-Queries-Browser' 'Famix-Queries-Tests') ].

			"Groups"
			spec
				group: 'Core' with: #('Famix-Queries');
				group: 'Tests' with: #('Famix-Queries-Tests');
				group: 'Browser' with: #('Famix-Queries-Browser');
				group: 'Browser-Tests' with: #('Famix-Queries-Browser-Tests') ]
]

{ #category : #dependencies }
BaselineOfFamixQueries >> famix: spec [
	spec
		baseline: 'Famix'
			with: [ spec
				loads: #('Core');
				repository: 'github://moosetechnology/Moose:development/src' ];
		project: 'FamixTests' copyFrom: 'Famix' with: [ spec loads: #('EntitiesSmalltalk' 'TestsResources' 'Importers') ]
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
