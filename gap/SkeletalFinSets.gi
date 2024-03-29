# SPDX-License-Identifier: GPL-2.0-or-later
# FiniteCocompletions: Finite (co)product/(co)limit (co)completions
#
# Implementations
#

##
InstallMethod( AsList,
        "for a skeletal finite set",
        [ IsObjectInSkeletalCategoryOfFiniteSetsAsFiniteStrictCoproductCompletionOfTerminalCategory ],
        
  function ( s )
    
    return [ 0 .. Length( s ) - 1 ];
    
end );

##
InstallGlobalFunction( SkeletalCategoryOfFiniteSetsAsFiniteStrictCoproductCompletionOfTerminalCategory,
  function( )
    local object_datum_type, object_constructor, object_datum,
          morphism_datum_type, morphism_constructor, morphism_datum,
          I, T, UT,
          modeling_tower_object_constructor, modeling_tower_object_datum,
          modeling_tower_morphism_constructor, modeling_tower_morphism_datum,
          sFinSets;
    
    ##
    object_datum_type := IsBigInt;
    
    ##
    object_constructor := { sFinSets, cardinality } ->
                          CreateCapCategoryObjectWithAttributes( sFinSets,
                                  Length, cardinality );
    
    ##
    object_datum := { sFinSets, M } -> Length( M );
    
    ##
    morphism_datum_type := CapJitDataTypeOfListOf( IsBigInt );
    
    ##
    morphism_constructor :=
      function( sFinSets, source, images, target )
        
        return CreateCapCategoryMorphismWithAttributes( sFinSets,
                   source,
                   target,
                   AsList, images );
        
    end;
    
    ##
    morphism_datum := { sFinSets, phi } -> AsList( phi );
    
    ## building the categorical tower:
    
    ## the initial category in the doctrine of categories
    I := InitialCategory( : FinalizeCategory := true );
    
    ##
    UT := FreeDistributiveCategoryWithStrictProductAndCoproducts( I : FinalizeCategory := true );
    
    ## from the raw object data to the object in the modeling category
    modeling_tower_object_constructor :=
      function( sFinSets, cardinality )
        local DI, UT, T;
        
        DI := ModelingCategory( sFinSets );
        
        UT := ModelingCategory( DI );
        
        T := UnderlyingCategory( UT );
        
        return ObjectConstructor( DI,
                       ObjectConstructor( UT,
                               Pair( cardinality,
                                     ListWithIdenticalEntries( cardinality,
                                             TerminalObject( T ) ) ) ) );
        
    end;
    
    ## from the object in the modeling category to the raw object data
    modeling_tower_object_datum :=
      function( sFinSets, U )
        local DI, UT;
        
        DI := ModelingCategory( sFinSets );
        
        UT := ModelingCategory( DI );
        
        return ObjectDatum( UT,
                       ObjectDatum( DI,
                               U ) )[1];
        
    end;
    
    ## from the raw morphism data to the morphism in the modeling category
    modeling_tower_morphism_constructor :=
      function( sFinSets, source, map, target )
        local DI, UT, T, source_UT, target_UT;
        
        DI := ModelingCategory( sFinSets );
        
        UT := ModelingCategory( DI );
        
        T := UnderlyingCategory( UT );
        
        source_UT := ObjectDatum( DI, source );
        target_UT := ObjectDatum( DI, target );
        
        return MorphismConstructor( DI,
                       source,
                       MorphismConstructor( UT,
                               source_UT,
                               Pair( map,
                                     ListWithIdenticalEntries( ObjectDatum( UT, source_UT )[1],
                                             IdentityMorphism( T, TerminalObject( T ) ) ) ),
                               target_UT ),
                       target );
        
    end;
    
    ## from the raw morphism data to the morphism in the modeling category
    modeling_tower_morphism_datum :=
      function( sFinSets, mor )
        local DI, UT;
        
        DI := ModelingCategory( sFinSets );
        
        UT := ModelingCategory( DI );
        
        return MorphismDatum( UT,
                       MorphismDatum( DI,
                               mor ) )[1];
        
    end;
    
    ##
    sFinSets :=
      ReinterpretationOfCategory( UT,
              rec( name := "SkeletalFinSetsAsFiniteStrictCoproductCompletionOfTerminalCategory",
                   category_filter := IsSkeletalCategoryOfFiniteSetsAsFiniteStrictCoproductCompletionOfTerminalCategory,
                   category_object_filter := IsObjectInSkeletalCategoryOfFiniteSetsAsFiniteStrictCoproductCompletionOfTerminalCategory,
                   category_morphism_filter := IsMorphismInSkeletalCategoryOfFiniteSetsAsFiniteStrictCoproductCompletionOfTerminalCategory,
                   object_datum_type := object_datum_type,
                   morphism_datum_type := morphism_datum_type,
                   object_constructor := object_constructor,
                   object_datum := object_datum,
                   morphism_constructor := morphism_constructor,
                   morphism_datum := morphism_datum,
                   modeling_tower_object_constructor := modeling_tower_object_constructor,
                   modeling_tower_object_datum := modeling_tower_object_datum,
                   modeling_tower_morphism_constructor := modeling_tower_morphism_constructor,
                   modeling_tower_morphism_datum := modeling_tower_morphism_datum,
                   only_primitive_operations := true )
              : FinalizeCategory := false );
    
    # this is a workhorse category -> no logic and caching only via IsIdenticalObj
    CapCategorySwitchLogicOff( sFinSets );
    
    ##
    Assert( 0, HasRangeCategoryOfHomomorphismStructure( sFinSets ) );
    Assert( 0, IsIdenticalObj( sFinSets, RangeCategoryOfHomomorphismStructure( sFinSets ) ) );
    
    if ValueOption( "no_precompiled_code" ) <> true then
        
        ADD_FUNCTIONS_FOR_SkeletalCategoryOfFiniteSetsAsFiniteStrictCoproductCompletionOfTerminalCategoryPrecompiled( sFinSets );
        
    fi;
    
    Finalize( sFinSets );
    
    Assert( 0, [ ] = MissingOperationsForConstructivenessOfCategory( sFinSets, "IsEquippedWithHomomorphismStructure" ) );
    
    return sFinSets;
    
end );

##
InstallMethod( ViewObj,
        "for a skeletal finite set",
        [ IsObjectInSkeletalCategoryOfFiniteSetsAsFiniteStrictCoproductCompletionOfTerminalCategory ],
        
  function ( s )
    Print( "|", Length( s ), "|" );
end );

##
InstallMethod( ViewObj,
    "for a map of skeletal finite sets",
        [ IsMorphismInSkeletalCategoryOfFiniteSetsAsFiniteStrictCoproductCompletionOfTerminalCategory ],
        
  function ( phi )
    Print( "|", Length( Source( phi ) ), "| → |", Length( Target( phi ) ), "|" );
end );

##
InstallMethod( ViewObj,
    "for a map of skeletal finite sets",
        [ IsMorphismInSkeletalCategoryOfFiniteSetsAsFiniteStrictCoproductCompletionOfTerminalCategory and IsMonomorphism ],
        
  function ( phi )
    Print( "|", Length( Source( phi ) ), "| ↪ |", Length( Target( phi ) ), "|" );
end );

##
InstallMethod( ViewObj,
    "for a map of skeletal finite sets",
        [ IsMorphismInSkeletalCategoryOfFiniteSetsAsFiniteStrictCoproductCompletionOfTerminalCategory and IsEpimorphism ],
        
  function ( phi )
    Print( "|", Length( Source( phi ) ), "| ↠ |", Length( Target( phi ) ), "|" );
end );

##
InstallMethod( ViewObj,
        "for a map of skeletal finite sets",
        [ IsMorphismInSkeletalCategoryOfFiniteSetsAsFiniteStrictCoproductCompletionOfTerminalCategory and IsIsomorphism ],
        
  function ( phi )
    Print( "|", Length( Source( phi ) ), "| ⭇ |", Length( Target( phi ) ), "|" );
end );

# We want lists of skeletal finite sets and maps to be displayed in a "fancy" way.
# Since `Display` of list redirects to `Print`, we have to make `PrintString` "fancy",
# even if the documentation of `PrintString` suggests that it should not be "fancy".

##
InstallMethod( PrintString,
        "for a skeletal finite set",
        [ IsObjectInSkeletalCategoryOfFiniteSetsAsFiniteStrictCoproductCompletionOfTerminalCategory ],
        
  function ( s )
    local l, string;
    
    l := Length( s );
    
    if l = 0 then
        return "∅";
    elif l = 1 then
        return "{ 0 }";
    elif l = 2 then
        return "{ 0, 1 }";
    elif l = 3 then
        return "{ 0, 1, 2 }";
    fi;
    
    return Concatenation( "{ 0,..., ", String( l - 1 ), " }" );
    
end );

##
InstallMethod( PrintString,
        "for a map of skeletal finite sets",
        [ IsMorphismInSkeletalCategoryOfFiniteSetsAsFiniteStrictCoproductCompletionOfTerminalCategory ],
        
  function ( phi )
    
    return Concatenation(
                   PrintString( Source( phi ) ),
                   " ⱶ", PrintString( AsList( phi ) ), "→ ",
                   PrintString( Range( phi ) ) );
    
end );

##
InstallMethod( DisplayString,
        "for a skeletal finite set",
        [ IsObjectInSkeletalCategoryOfFiniteSetsAsFiniteStrictCoproductCompletionOfTerminalCategory ],
        
  function ( s )
    
    return Concatenation( PrintString( s ), "\n" );
    
end );

##
InstallMethod( DisplayString,
        "for a map of skeletal finite sets",
        [ IsMorphismInSkeletalCategoryOfFiniteSetsAsFiniteStrictCoproductCompletionOfTerminalCategory ],
        
  function ( phi )
    
    return Concatenation( PrintString( phi ), "\n" );
    
end );

##
BindGlobal( "SkeletalFinSetsAsFiniteStrictCoproductCompletionOfTerminalCategory",
        SkeletalCategoryOfFiniteSetsAsFiniteStrictCoproductCompletionOfTerminalCategory( ) );
