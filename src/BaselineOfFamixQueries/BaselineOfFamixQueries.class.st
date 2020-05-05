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
		do: [ "Dependencies"
			"self famix: spec."
			self roassal3: spec.

			"Packages"
			spec
				package: 'Famix-Queries' "with: [ spec requires: #('Famix') ]";
				package: 'Famix-Queries-Tests'
					with: [ spec requires: #('Famix-Queries') ];
				package: 'Famix-Queries-Browser'
					with: [ spec requires: #('Famix-Queries' 'Roassal3') ];
				package: 'Famix-Queries-Browser-Tests'
					with: [ spec requires: #('Famix-Queries-Browser') ].

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
BaselineOfFamixQueries >> roassal3: spec [
	spec
		baseline: 'Roassal3'
		with: [ spec repository: 'github://ObjectProfile/Roassal3/src' ]
]
