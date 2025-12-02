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
	spec for: #common do: [ 
		
		"Dependencies"
		self famixTagging: spec.

		"Packages"
		spec
			package: 'Famix-Queries'
			with: [ spec requires: #( 'FamixTagging' ) ];
			package: 'Famix-Queries-Tests'
			with: [ spec requires: #( 'Famix-Queries' ) ].

		"Groups"
		spec
			group: 'Model' with: #( 'Famix-Queries' );
			group: 'Tests' with: #( 'Famix-Queries-Tests' ) ]
]

{ #category : #dependencies }
BaselineOfFamixQueries >> famixTagging: spec [

	spec
		baseline: 'FamixTagging'
		with: [
		spec repository: 'github://moosetechnology/FamixTagging:moose12/src' ]
]
