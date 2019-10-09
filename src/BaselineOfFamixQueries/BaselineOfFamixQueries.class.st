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
			self famix: spec.

			"Packages"
			spec
				package: 'Famix-Queries' with: [ spec requires: #('Famix-Core') ];
				package: 'Famix-Queries-Tests' with: [ spec requires: #('Famix-Queries') ].

			"Groups"
			spec
				group: 'Core' with: #('Famix-Queries');
				group: 'Tests' with: #('Famix-Queries-Tests') ]
]

{ #category : #dependencies }
BaselineOfFamixQueries >> famix: spec [
	spec
		baseline: 'Famix'
			with: [ spec
				loads: #('Core' 'Basic' 'ModelCompatibility' 'ModelJava' 'ModelSmalltalk' 'Importers');
				repository: 'github://moosetechnology/Moose:development/src' ];
		project: 'FamixTests' copyFrom: 'Famix' with: [ spec loads: #('Tests') ]
]
