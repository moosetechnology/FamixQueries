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
			self famix: spec.
			self famixTagging: spec.
		
		"Packages"
		spec
			package: 'Famix-Queries'  with: [ spec requires: #( 'Famix' ) ];
			package: 'Famix-Queries-Tests'
			with: [ spec requires: #( 'Famix-Queries' ) ].

		"Groups"
		spec
			group: 'Model' with: #( 'Famix-Queries' );
			group: 'Tests' with: #( 'Famix-Queries-Tests' ) ]
]

{ #category : #dependencies }
BaselineOfFamixQueries >> famix: spec [

	spec for: #'pharo9.x' do: [ 
		spec
			baseline: 'Famix'
			with: [ 
			spec repository: 'github://moosetechnology/Famix:v1.x.x/src' ] ].

	spec for: #( #'pharo10.x' #'pharo11.x' ) do: [ 
		spec
			baseline: 'Famix'
			with: [ 
			spec repository: 'github://moosetechnology/Famix:development/src' ] ]
]

{ #category : #dependencies }
BaselineOfFamixQueries >> famixTagging: spec [

	spec
		baseline: 'FamixTagging'
		with: [ 
		spec repository: 'github://moosetechnology/FamixTagging:v1.x.x/src' ]
]
