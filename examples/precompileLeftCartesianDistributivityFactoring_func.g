func := EvalString( ReplacedStringViaRecord( """
  function( T, source, a, b, c, target )
    local objects, generating_morphisms,
          embedding_on_objects, embedding_on_morphisms, extended_functorDC;
    
    objects := CapJitTypedExpression( [ a, b, c ], T -> CapJitDataTypeOfListOf( CapJitDataTypeOfObjectOfCategory( T ) ) );
    
    generating_morphisms := CapJitTypedExpression( [ ], T -> CapJitDataTypeOfListOf( CapJitDataTypeOfMorphismOfCategory( T ) ) );
    
    ## Q → T
    embedding_on_objects :=
      function( objQ )
        
        return objects[objQ];
        
    end;
    
    embedding_on_morphisms :=
      function( morQ )
        
        return generating_morphisms[morQ];
        
    end;
    
    ## DC → T
    extended_functorDC :=
      ExtendFunctorToFreeDistributiveCategoryWithStrictProductAndCoproductsData(
              DC,
              ExtendFunctorToFpCategoryData(
                      C,
                      Pair( embedding_on_objects, embedding_on_morphisms ),
                      T )[2],
              T )[2];
    
    return extended_functorDC[2](
                   source, #extended_functorDC[1]( source ),
                   lfactor_reconstructed,
                   target ); #extended_functorDC[1]( target ) );
    
end
""",
  rec( lfactor_reconstructed := lfactor_reconstructed ) ) );
