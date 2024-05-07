Extension { #name : 'RBNamespace' }

{ #category : '*SmaCC_Development' }
RBNamespace >> smaccDefineTrait: aBuilderBlock [
	| change newClass newClassName |
	change := changes defineClass: aBuilderBlock.
	newClassName := change changeClassName.
	newClass := self classNamed: newClassName. 
	newClass
		ifNil: [ | newMetaclass |
			self unmarkAsRemoved: newClassName.
			newClass := self rbTraitClass named: newClassName.
			newMetaclass := self rbTraitedMetaclassClass named: newClassName.
			newClass model: self.
			newMetaclass model: self.
			newClasses
				at: newClassName
				put: (Array with: newClass with: newMetaclass) ].
	newClass superclass: nil.
	self rootClasses add: newClass.
	newClass classSide superclass: nil.
	newClass instanceVariableNames: #().
	newClass classVariableNames: #().
	newClass poolDictionaryNames: #().
	newClass packageName: change package.
	^ change
]
