# SPDX-License-Identifier: GPL-2.0-or-later
# FiniteCocompletions: Finite (co)product/(co)limit (co)completions
#
# Implementations
#

##
InstallOtherMethodForCompilerForCAP( CreateColimitQuiver,
        "for the category of colimit quivers in a category and a pair",
        [ IsCategoryOfColimitQuivers, IsList ],
        
  function ( ColimitQuivers, pair )
    
    #% CAP_JIT_DROP_NEXT_STATEMENT
    Assert( 0,
            Length( pair ) = 2 and
            IsList( pair[1] ) and
            ForAll( pair[1], IsCapCategoryObject ) and
            IsList( pair[2] ) and
            ForAll( pair[2], IsList ) and
            ForAll( pair[2], e -> IsInt( e[1] ) and IsInt( e[3] ) ) and
            ForAll( pair[2], e -> IsCapCategoryMorphism( e[2] ) ) );
    
    return CreateCapCategoryObjectWithAttributes( ColimitQuivers,
                   DefiningPairOfColimitQuiver, pair );
    
end );

##
InstallOtherMethodForCompilerForCAP( CreateMorphismOfColimitQuivers,
        "for a category of quivers, two objects in a category of quivers, and a pair",
        [ IsCategoryOfColimitQuivers, IsObjectInCategoryOfColimitQuivers, IsList, IsObjectInCategoryOfColimitQuivers ],
        
  function ( ColimitQuivers, source, images, range )
    
    return CreateCapCategoryMorphismWithAttributes( ColimitQuivers,
                   source,
                   range,
                   DefiningPairOfColimitQuiverMorphism, images );
    
end );

##
InstallMethod( CategoryOfColimitQuivers,
        "for a category",
        [ IsCapCategory ],
        
  function ( C )
    local object_datum_type, object_constructor, object_datum,
          morphism_datum_type, morphism_constructor, morphism_datum,
          UC, Coeq,
          modeling_tower_object_constructor, modeling_tower_object_datum,
          modeling_tower_morphism_constructor, modeling_tower_morphism_datum,
          ColimitQuivers;
    
    ##
    object_datum_type :=
      CapJitDataTypeOfNTupleOf( 2,
              CapJitDataTypeOfListOf( CapJitDataTypeOfObjectOfCategory( C ) ),
              CapJitDataTypeOfListOf(
                      CapJitDataTypeOfNTupleOf( 3,
                              rec( filter := IsInt ),
                              CapJitDataTypeOfMorphismOfCategory( C ),
                              rec( filter := IsInt ) ) ) );
    
    ##
    object_constructor := CreateColimitQuiver;
    
    ##
    object_datum := { ColimitQuivers, o } -> DefiningPairOfColimitQuiver( o );
    
    ##
    morphism_datum_type :=
      CapJitDataTypeOfNTupleOf( 2,
              CapJitDataTypeOfNTupleOf( 2,
                      CapJitDataTypeOfListOf( rec( filter := IsInt ) ),
                      CapJitDataTypeOfListOf( CapJitDataTypeOfMorphismOfCategory( C ) ) ),
              CapJitDataTypeOfListOf( rec( filter := IsInt ) ) );
    
    ##
    morphism_constructor := CreateMorphismOfColimitQuivers;
    
    ##
    morphism_datum := { ColimitQuivers, m } -> DefiningPairOfColimitQuiverMorphism( m );
    
    ## building the categorical tower:
    UC := FiniteStrictCoproductCocompletion( C : FinalizeCategory := true );
    
    Coeq := PairOfParallelArrowsCategory( UC : FinalizeCategory := true );
    
    ## from the raw object data to the object in the modeling category
    modeling_tower_object_constructor :=
      function( ColimitQuivers, pair )
        local Coeq, PSh, UC, C, objects, decorated_morphisms, V, A, map_s, mor_s, s, map_t, mor_t, t;
        
        Coeq := ModelingCategory( ColimitQuivers );
        
        PSh := ModelingCategory( Coeq );
        
        UC := Range( PSh );
        
        C := UnderlyingCategory( UC );
        
        objects := pair[1];
        decorated_morphisms := pair[2];
        
        V := ObjectConstructor( UC,
                     Pair( Length( objects ), objects ) );
        
        A := ObjectConstructor( UC,
                     Pair( Length( decorated_morphisms ),
                           List( decorated_morphisms, m -> objects[1 + m[1]] ) ) );
        
        map_s := List( decorated_morphisms, m -> m[1] );
        
        mor_s := List( decorated_morphisms, m -> IdentityMorphism( C, objects[1 + m[1]] ) );
        
        s := MorphismConstructor( UC,
                     A,
                     Pair( map_s, mor_s ),
                     V );
        
        map_t := List( decorated_morphisms, m -> m[3] );
        
        mor_t := List( decorated_morphisms, m -> m[2] );
        
        t := MorphismConstructor( UC,
                     A,
                     Pair( map_t, mor_t ),
                     V );
        
        return ObjectConstructor( Coeq, Pair( s, t ) );
        
    end;
    
    ## from the object in the modeling category to the raw object data
    modeling_tower_object_datum :=
      function( ColimitQuivers, obj )
        local Coeq, PSh, UC, pair, s, t, V, objects, s_datum, t_datum, decorated_morphisms;
        
        Coeq := ModelingCategory( ColimitQuivers );
        
        PSh := ModelingCategory( Coeq );
        
        UC := Range( PSh );
        
        pair := ObjectDatum( Coeq, obj );
        
        s := pair[1];
        t := pair[2];
        
        V := Range( s );
        
        objects := ObjectDatum( UC, V )[2];
        
        s_datum := MorphismDatum( UC, s );
        t_datum := MorphismDatum( UC, t );
        
        decorated_morphisms := ListN( s_datum[1],
                                      t_datum[2],
                                      t_datum[1],
                                      { s_index, mor, t_index } -> Triple( s_index, mor, t_index ) );
        
        return Pair( objects, decorated_morphisms );
        
    end;
    
    ## from the raw morphism data to the morphism in the modeling category
    modeling_tower_morphism_constructor :=
      function( ColimitQuivers, source, images, range )
        local Coeq, PSh, UC, source_datum, range_datum, V, source_s_datum, A;
        
        Coeq := ModelingCategory( ColimitQuivers );
        
        PSh := ModelingCategory( Coeq );
        
        UC := Range( PSh );
        
        source_datum := ObjectDatum( Coeq, source );
        range_datum := ObjectDatum( Coeq, range );
        
        V := MorphismConstructor( UC,
                     Range( source_datum[1] ),
                     images[1],
                     Range( range_datum[1] ) );
        
        source_s_datum := MorphismDatum( UC, source_datum[1] );
        
        A := MorphismConstructor( UC,
                     Source( source_datum[1] ),
                     Pair( images[2],
                           source_s_datum[2] ),
                     Source( range_datum[1] ) );
        
        return MorphismConstructor( Coeq,
                       source,
                       Pair( V, A ),
                       range );
        
    end;
    
    ## from the morphism in the modeling category to the raw morphism data
    modeling_tower_morphism_datum :=
      function( ColimitQuivers, mor )
        local Coeq, PSh, UC, mor_datum, V_datum, A_datum;
        
        Coeq := ModelingCategory( ColimitQuivers );
        
        PSh := ModelingCategory( Coeq );
        
        UC := Range( PSh );
        
        mor_datum := MorphismDatum( Coeq, mor );
        
        V_datum := MorphismDatum( UC, mor_datum[1] );
        A_datum := MorphismDatum( UC, mor_datum[2] );
        
        return Pair( V_datum, A_datum[1] );
        
    end;
    
    ## the wrapper category interacts with the user through the raw data but uses
    ## the tower to derive the algorithms turning the category into a constructive topos;
    ## after compilation the tower is gone and the only reminiscent which hints to the tower
    ## is the attribute ModelingCategory:
    ColimitQuivers :=
      ReinterpretationOfCategory( Coeq,
              rec( name := Concatenation( "CategoryOfColimitQuivers( ", Name( C ), " )" ),
                   category_filter := IsCategoryOfColimitQuivers,
                   category_object_filter := IsObjectInCategoryOfColimitQuivers,
                   category_morphism_filter := IsMorphismInCategoryOfColimitQuivers,
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
    
    SetUnderlyingCategory( ColimitQuivers, C );
    
    ColimitQuivers!.compiler_hints.category_attribute_names :=
      [ "UnderlyingCategory",
        ];
    
    if ValueOption( "no_precompiled_code" ) <> true then
        
    fi;
    
    Finalize( ColimitQuivers );
    
    return ColimitQuivers;
    
end );

##
InstallMethod( AssociatedCategoryOfColimitQuiversOfSourceCategory,
        [ IsPreSheafCategory ],
        
  function( PSh )
    
    return CategoryOfColimitQuivers( Source( PSh ) );
    
end );

##
InstallMethod( EmbeddingOfUnderlyingCategory,
        "for the category of colimit quivers in a category",
        [ IsCategoryOfColimitQuivers ],
        
  function( ColimitQuivers )
    local Y;
    
    Y := CapFunctor( "Embedding functor", UnderlyingCategory( ColimitQuivers ), ColimitQuivers );
    
    AddObjectFunction( Y, objC -> ObjectConstructor( ColimitQuivers, Pair( [ objC ], [ ] ) ) );
    
    AddMorphismFunction( Y, { source, morC, range } -> MorphismConstructor( ColimitQuivers, source, Pair( [ [ 0 ], [ morC ] ], [ ] ), range ) );
    
    return Y;
    
end );

##
InstallMethod( \.,
        "for the category of colimit quivers in a category and a positive integer",
        [ IsCategoryOfColimitQuivers, IsPosInt ],
        
  function( ColimitQuivers, string_as_int )
    local name, C, Y, Yc;
    
    name := NameRNam( string_as_int );
    
    C := UnderlyingCategory( ColimitQuivers );
    
    Y := EmbeddingOfUnderlyingCategory( ColimitQuivers );
    
    Yc := Y( C.(name) );
    
    if IsObjectInCategoryOfColimitQuivers( Yc ) then
        
        SetIsProjective( Yc, true );
        
    elif IsMorphismInCategoryOfColimitQuivers( Yc ) then
        
        if CanCompute( ColimitQuivers, "IsMonomorphism" ) then
            IsMonomorphism( Yc );
        fi;
        
        if CanCompute( ColimitQuivers, "IsSplitMonomorphism" ) then
            IsSplitMonomorphism( Yc );
        fi;
        
        if CanCompute( ColimitQuivers, "IsEpimorphism" ) then
            IsEpimorphism( Yc );
        fi;
        
        if CanCompute( ColimitQuivers, "IsSplitEpimorphism" ) then
            IsSplitEpimorphism( Yc );
        fi;
        
        ## IsIsomorphism = IsSplitMonomorphism and IsSplitEpimorphism
        ## we add this here in case the logic is deactivated
        if CanCompute( ColimitQuivers, "IsIsomorphism" ) then
            IsIsomorphism( Yc );
        fi;
        
    fi;
    
    return Yc;
    
end );

####################################
#
# View, Print, Display and LaTeX methods:
#
####################################

##
InstallMethod( Display,
        "for an object in the category of colimit quivers in a category",
        [ IsObjectInCategoryOfColimitQuivers ],
        
  function ( quiver )
    
    Display( ObjectDatum( quiver ) );
    
    Print( "\nAn object in ", Name( CapCategory( quiver ) ), " given by the above data\n" );
    
end );

##
InstallMethod( Display,
        "for a morphism in the category of colimit quivers in a category",
        [ IsMorphismInCategoryOfColimitQuivers ],
        
  function ( quiver_morphism )

    Print( "Source: " );
    Display( Source( quiver_morphism ) );
    Print( "\nDatum:  " );
    Display( MorphismDatum( quiver_morphism ) );
    Print( "\nRange:  " );
    Display( Range( quiver_morphism ) );
    
    Print( "\nA morphism in ", Name( CapCategory( quiver_morphism ) ), " given by the above data\n" );
    
end );
