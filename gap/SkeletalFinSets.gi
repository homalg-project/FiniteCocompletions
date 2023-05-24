# SPDX-License-Identifier: GPL-2.0-or-later
# FiniteCocompletions: Finite (co)product/(co)limit (co)completions
#
# Implementations
#

##
InstallMethod( AsList,
        "for a skeletal finite set",
        [ IsObjectInSkeletalFinSets ],
        
  function ( s )
    
    return [ 0 .. Length( s ) - 1 ];
    
end );

##
InstallGlobalFunction( CategoryOfSkeletalFinSetsAsFiniteStrictCoproductCocompletionOfTerminalCategory,
  function( )
    local object_constructor, object_datum,
          morphism_constructor, morphism_datum,
          I, T, UT,
          modeling_tower_object_constructor, modeling_tower_object_datum,
          modeling_tower_morphism_constructor, modeling_tower_morphism_datum,
          sFinSets;
    
    ##
    object_constructor := { sFinSets, cardinality } ->
                          CreateCapCategoryObjectWithAttributes( sFinSets,
                                  Length, cardinality );
    
    ##
    object_datum := { sFinSets, M } -> Length( M );
    
    ##
    morphism_constructor :=
      function( sFinSets, source, images, range )
        
        return CreateCapCategoryMorphismWithAttributes( sFinSets,
                   source,
                   range,
                   AsList, images );
        
    end;
    
    ##
    morphism_datum := { sFinSets, phi } -> AsList( phi );
    
    ## building the categorical tower:
    
    ## the initial category in the doctrine of categories
    I := InitialCategory( : FinalizeCategory := true );
    
    ## the terminal category in the doctrine of categories
    T := FiniteStrictProductCompletion( I : FinalizeCategory := true );
    
    ##
    UT := FiniteStrictCoproductCocompletion( T : FinalizeCategory := true );
    
    ## from the raw object data to the object in the modeling category
    modeling_tower_object_constructor :=
      function( sFinSets, cardinality )
        local UT;
        
        UT := ModelingCategory( sFinSets );
        
        return ObjectConstructor( UT,
                       Pair( cardinality,
                             ListWithIdenticalEntries( cardinality,
                                     TerminalObject( UnderlyingCategory( UT ) ) ) ) );
        
    end;
    
    ## from the object in the modeling category to the raw object data
    modeling_tower_object_datum := { sFinSets, U } -> ObjectDatum( ModelingCategory( sFinSets ), U )[1];
    
    ## from the raw morphism data to the morphism in the modeling category
    modeling_tower_morphism_constructor :=
      function( sFinSets, source, map, range )
        local UT, T;
        
        UT := ModelingCategory( sFinSets );
        
        T := UnderlyingCategory( UT );
        
        return MorphismConstructor( UT,
                       source,
                       Pair( map,
                             ListWithIdenticalEntries( ObjectDatum( UT, source )[1],
                                     IdentityMorphism( T, TerminalObject( T ) ) ) ),
                       range );
        
    end;
    
    ## from the raw morphism data to the morphism in the modeling category
    modeling_tower_morphism_datum := { sFinSets, mor } -> MorphismDatum( ModelingCategory( sFinSets ), mor )[1];
    
    ##
    sFinSets := ReinterpretationOfCategory( UT,
                        rec( name := "SkeletalFinSetsAsFiniteStrictCoproductCocompletionOfTerminalCategory",
                             object_constructor := object_constructor,
                             object_datum := object_datum,
                             morphism_constructor := morphism_constructor,
                             morphism_datum := morphism_datum,
                             modeling_tower_object_constructor := modeling_tower_object_constructor,
                             modeling_tower_object_datum := modeling_tower_object_datum,
                             modeling_tower_morphism_constructor := modeling_tower_morphism_constructor,
                             modeling_tower_morphism_datum := modeling_tower_morphism_datum,
                             category_filter := IsCategoryOfSkeletalFinSetsAsFiniteStrictCoproductCocompletionOfTerminalCategory,
                             category_object_filter := IsObjectInSkeletalFinSets,
                             category_morphism_filter := IsMorphismInSkeletalFinSets,
                             only_primitive_operations := true ) : FinalizeCategory := false );
    
    # this is a workhorse category -> no logic and caching only via IsIdenticalObj
    CapCategorySwitchLogicOff( sFinSets );
    
    ##
    Assert( 0, HasRangeCategoryOfHomomorphismStructure( sFinSets ) );
    Assert( 0, IsIdenticalObj( sFinSets, RangeCategoryOfHomomorphismStructure( sFinSets ) ) );
    
    if ValueOption( "no_precompiled_code" ) <> true then
        
        ADD_FUNCTIONS_FOR_CategoryOfSkeletalFinSetsAsFiniteStrictCoproductCocompletionOfTerminalCategoryPrecompiled( sFinSets );
        
    fi;
    
    Finalize( sFinSets );
    
    Assert( 0, [ ] = CheckConstructivenessOfCategory( sFinSets, "IsEquippedWithHomomorphismStructure" ) );
    
    return sFinSets;
    
end );

##
InstallMethod( ViewObj,
        "for a skeletal finite set",
        [ IsObjectInSkeletalFinSets ],
        
  function ( s )
    Print( "|", Length( s ), "|" );
end );

##
InstallMethod( ViewObj,
    "for a map of skeletal finite sets",
        [ IsMorphismInSkeletalFinSets ],
        
  function ( phi )
    Print( "|", Length( Source( phi ) ), "| → |", Length( Range( phi ) ), "|" );
end );

##
InstallMethod( ViewObj,
    "for a map of skeletal finite sets",
        [ IsMorphismInSkeletalFinSets and IsMonomorphism ],
        
  function ( phi )
    Print( "|", Length( Source( phi ) ), "| ↪ |", Length( Range( phi ) ), "|" );
end );

##
InstallMethod( ViewObj,
    "for a map of skeletal finite sets",
        [ IsMorphismInSkeletalFinSets and IsEpimorphism ],
        
  function ( phi )
    Print( "|", Length( Source( phi ) ), "| ↠ |", Length( Range( phi ) ), "|" );
end );

##
InstallMethod( ViewObj,
        "for a map of skeletal finite sets",
        [ IsMorphismInSkeletalFinSets and IsIsomorphism ],
        
  function ( phi )
    Print( "|", Length( Source( phi ) ), "| ⭇ |", Length( Range( phi ) ), "|" );
end );

##
InstallMethod( PrintString,
        "for a skeletal finite set",
        [ IsObjectInSkeletalFinSets ],
        
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
InstallMethod( Display,
        "for a skeletal finite set",
        [ IsObjectInSkeletalFinSets ],
        
  function ( s )
    Print( PrintString( s ), "\n" );
end );

##
InstallMethod( Display,
    "for a map of skeletal finite sets",
        [ IsMorphismInSkeletalFinSets ],
        
  function ( phi )
    
    Print( PrintString( Source( phi ) ) );
    Print( " ⱶ", AsList( phi ), "→ " );
    Print( PrintString( Range( phi ) ), "\n" );
    
end );

##
BindGlobal( "SkeletalFinSetsAsFiniteStrictCoproductCocompletionOfTerminalCategory",
        CategoryOfSkeletalFinSetsAsFiniteStrictCoproductCocompletionOfTerminalCategory( ) );
