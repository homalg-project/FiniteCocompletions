#! @Chunk SkeletalWellDefined

#! @Example
LoadPackage( "FiniteCocompletions" );
#! true
sFinSets :=
  SkeletalFinSetsAsFiniteStrictCoproductCompletionOfTerminalCategory;
#! SkeletalFinSetsAsFiniteStrictCoproductCompletionOfTerminalCategory
Display( sFinSets );
#! A CAP category with name
#! SkeletalFinSetsAsFiniteStrictCoproductCompletionOfTerminalCategory:
#! 
#! 34 primitive operations were used to derive 168 operations for this category
#! which algorithmically
#! * IsCategoryWithDecidableLifts
#! * IsEquippedWithHomomorphismStructure
#! * IsFiniteCompleteCategory
#! * IsDistributiveCategory
#! and furthermore mathematically
#! * IsStrictCartesianCategory
#! * IsStrictCocartesianCategory
s := ObjectConstructor( sFinSets, 7 );
#! |7|
ObjectDatum( s );
#! 7
t := ObjectConstructor( sFinSets, 4 );
#! |4|
ObjectDatum( t );
#! 4
psi := MorphismConstructor( s, [ 0, 2, 1, 2, 1, 3 ], t );
#! |7| → |4|
IsWellDefined( psi );
#! false
psi := MorphismConstructor( s, [ 0, 2, 1, 2, 1, 3, -2 ], t );
#! |7| → |4|
IsWellDefined( psi );
#! false
psi := MorphismConstructor( s, [ 1, 2, 1, 4, 2, 1, 3 ], t );
#! |7| → |4|
IsWellDefined( psi );
#! false
psi:= MorphismConstructor( s, [ 0, 2, 1, 3, 2, 1, 3 ], t );
#! |7| → |4|
IsWellDefined( psi );
#! true
Display( psi );
#! { 0,..., 6 } ⱶ[ 0, 2, 1, 3, 2, 1, 3 ]→ { 0,..., 3 }
MorphismDatum( psi );
#! [ 0, 2, 1, 3, 2, 1, 3 ]
#! @EndExample
