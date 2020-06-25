Extension { #name : #Object }

{ #category : #'*Famix-Queries' }
Object >> famePropertiesOfType: aFM3Class [
	"Select the fame properties of a certain type for the entity meta description."

	^ self mooseDescription allPrimitiveProperties select: [ :prop | prop type class = aFM3Class and: [ prop isMultivalued not ] ]
]
