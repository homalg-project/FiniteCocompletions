#! @BeginChunk FinBouquetsAsFiniteColimitCocompletion

#! @Example
LoadPackage( "FunctorCategories", ">= 2023.08-20" );
#! true
FinBouquets;
#! FinBouquets
Chat := ModelingCategory( FinBouquets );
#! FiniteCocompletion( FreeCategory( RightQuiver( "q(P,L)[b:P->L]" ) ) )
source_bouquet := CreateBouquet( 3, [ 0, 0, 1 ] );
#! <An object in FinBouquets>
Display( source_bouquet );
#! ( { 0, 1, 2 }, { 0 ↦ 0, 1 ↦ 0, 2 ↦ 1 } )
source_presheaf := ModelingObject( Chat,
                           ModelingObject( FinBouquets, source_bouquet ) );
#! <An object in
#!  PreSheaves( FreeCategory( RightQuiver( "q(P,L)[b:P->L]" ) ), SkeletalFinSets )>
source_coeq_pair := CoYonedaLemmaOnObjects( source_presheaf );
#! <An object in PairOfParallelArrowsCategory( FiniteStrictCoproductCocompletion(
#!  FreeCategory( RightQuiver( "q(P,L)[b:P->L]" ) ) ) )>
IsWellDefined( source_coeq_pair );
#! true
Display( source_coeq_pair );
#! Image of <(V)>:
#! [ 6, [ <(P)>, <(P)>, <(P)>, <(L)>, <(L)>, <(L)> ] ]
#! 
#! An object in FiniteStrictCoproductCocompletion( FreeCategory(
#! RightQuiver( "q(P,L)[b:P->L]" ) ) ) given by the above data
#! 
#! Image of <(A)>:
#! [ 3, [ <(P)>, <(P)>, <(P)> ] ]
#! 
#! An object in FiniteStrictCoproductCocompletion( FreeCategory(
#! RightQuiver( "q(P,L)[b:P->L]" ) ) ) given by the above data
#! 
#! Image of (V)-[(s)]->(A):
#! { 0, 1, 2 } ⱶ[ 0, 0, 1 ]→ { 0,..., 5 }
#! 
#! [ (P)-[(P)]->(P), (P)-[(P)]->(P), (P)-[(P)]->(P) ]
#! 
#! A morphism in FiniteStrictCoproductCocompletion( FreeCategory(
#! RightQuiver( "q(P,L)[b:P->L]" ) ) ) given by the above data
#! 
#! Image of (V)-[(t)]->(A):
#! { 0, 1, 2 } ⱶ[ 3, 4, 5 ]→ { 0,..., 5 }
#! 
#! [ (P)-[(b)]->(L), (P)-[(b)]->(L), (P)-[(b)]->(L) ]
#! 
#! A morphism in FiniteStrictCoproductCocompletion( FreeCategory(
#! RightQuiver( "q(P,L)[b:P->L]" ) ) ) given by the above data
#! 
#! An object in PreSheaves( FreeCategory( RightQuiver( "q(V,A)[s:V->A,t:V->A]" ) ),
#! FiniteStrictCoproductCocompletion(
#! FreeCategory( RightQuiver( "q(P,L)[b:P->L]" ) ) ) ) given by the above data
#! 
#! An object in PairOfParallelArrowsCategory( FiniteStrictCoproductCocompletion(
#! FreeCategory( RightQuiver( "q(P,L)[b:P->L]" ) ) ) ) given by the above data
target_bouquet := CreateBouquet( 2, [ 0, 0, 0, 0, 1 ] );
#! <An object in FinBouquets>
Display( target_bouquet );
#! ( { 0, 1 }, { 0 ↦ 0, 1 ↦ 0, 2 ↦ 0, 3 ↦ 0, 4 ↦ 1 } )
target_presheaf := ModelingObject( Chat,
                           ModelingObject( FinBouquets, target_bouquet ) );
#! <An object in
#!  PreSheaves( FreeCategory( RightQuiver( "q(P,L)[b:P->L]" ) ), SkeletalFinSets )>
target_coeq_pair := CoYonedaLemmaOnObjects( target_presheaf );
#! <An object in PairOfParallelArrowsCategory( FiniteStrictCoproductCocompletion(
#!  FreeCategory( RightQuiver( "q(P,L)[b:P->L]" ) ) ) )>
Display( target_coeq_pair );
#! Image of <(V)>:
#! [ 7, [ <(P)>, <(P)>, <(L)>, <(L)>, <(L)>, <(L)>, <(L)> ] ]
#! 
#! An object in FiniteStrictCoproductCocompletion( FreeCategory(
#! RightQuiver( "q(P,L)[b:P->L]" ) ) ) given by the above data
#! 
#! Image of <(A)>:
#! [ 5, [ <(P)>, <(P)>, <(P)>, <(P)>, <(P)> ] ]
#! 
#! An object in FiniteStrictCoproductCocompletion( FreeCategory(
#! RightQuiver( "q(P,L)[b:P->L]" ) ) ) given by the above data
#! 
#! Image of (V)-[(s)]->(A):
#! { 0,..., 4 } ⱶ[ 0, 0, 0, 0, 1 ]→ { 0,..., 6 }
#! 
#! [ (P)-[(P)]->(P), (P)-[(P)]->(P), (P)-[(P)]->(P), (P)-[(P)]->(P), (P)-[(P)]->(P) ]
#! 
#! A morphism in FiniteStrictCoproductCocompletion( FreeCategory(
#! RightQuiver( "q(P,L)[b:P->L]" ) ) ) given by the above data
#! 
#! Image of (V)-[(t)]->(A):
#! { 0,..., 4 } ⱶ[ 2, 3, 4, 5, 6 ]→ { 0,..., 6 }
#! 
#! [ (P)-[(b)]->(L), (P)-[(b)]->(L), (P)-[(b)]->(L), (P)-[(b)]->(L), (P)-[(b)]->(L) ]
#! 
#! A morphism in FiniteStrictCoproductCocompletion( FreeCategory(
#! RightQuiver( "q(P,L)[b:P->L]" ) ) ) given by the above data
#! 
#! An object in PreSheaves( FreeCategory( RightQuiver( "q(V,A)[s:V->A,t:V->A]" ) ),
#! FiniteStrictCoproductCocompletion(
#! FreeCategory( RightQuiver( "q(P,L)[b:P->L]" ) ) ) ) given by the above data
#! 
#! An object in PairOfParallelArrowsCategory( FiniteStrictCoproductCocompletion(
#! FreeCategory( RightQuiver( "q(P,L)[b:P->L]" ) ) ) ) given by the above data
bouquet_morphism := CreateBouquetMorphism(
                            source_bouquet,
                            [ 0, 1, 1 ], [ 1, 3, 4 ],
                            target_bouquet );
#! <A morphism in FinBouquets>
IsWellDefined( bouquet_morphism );
#! true
presheaf_morphism := ModelingMorphism( Chat,
                             ModelingMorphism( FinBouquets, bouquet_morphism ) );
#! <A morphism in
#!  PreSheaves( FreeCategory( RightQuiver( "q(P,L)[b:P->L]" ) ), SkeletalFinSets )>
coeq_pair_morphism := CoYonedaLemmaOnMorphisms( presheaf_morphism );
#! <A morphism in PairOfParallelArrowsCategory( FiniteStrictCoproductCocompletion(
#!  FreeCategory( RightQuiver( "q(P,L)[b:P->L]" ) ) ) )>
IsWellDefined( coeq_pair_morphism );
#! true
Display( coeq_pair_morphism );
#! Image of <(V)>:
#! { 0,..., 5 } ⱶ[ 0, 1, 1, 3, 5, 6 ]→ { 0,..., 6 }
#! 
#! [ (P)-[(P)]->(P), (P)-[(P)]->(P), (P)-[(P)]->(P),
#!   (L)-[(L)]->(L), (L)-[(L)]->(L), (L)-[(L)]->(L) ]
#! 
#! A morphism in FiniteStrictCoproductCocompletion( FreeCategory(
#! RightQuiver( "q(P,L)[b:P->L]" ) ) ) given by the above data
#! 
#! Image of <(A)>:
#! { 0, 1, 2 } ⱶ[ 1, 3, 4 ]→ { 0,..., 4 }
#! 
#! [ (P)-[(P)]->(P), (P)-[(P)]->(P), (P)-[(P)]->(P) ]
#! 
#! A morphism in FiniteStrictCoproductCocompletion( FreeCategory(
#! RightQuiver( "q(P,L)[b:P->L]" ) ) ) given by the above data
#! 
#! A morphism in PreSheaves( FreeCategory( RightQuiver( "q(V,A)[s:V->A,t:V->A]" ) ),
#! FiniteStrictCoproductCocompletion(
#! FreeCategory( RightQuiver( "q(P,L)[b:P->L]" ) ) ) ) given by the above data
#! 
#! A morphism in PairOfParallelArrowsCategory( FiniteStrictCoproductCocompletion(
#! FreeCategory( RightQuiver( "q(P,L)[b:P->L]" ) ) ) ) given by the above data
#! @EndExample
#! @EndChunk
