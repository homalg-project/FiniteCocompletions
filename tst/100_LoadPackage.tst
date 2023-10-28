# SPDX-License-Identifier: GPL-2.0-or-later
# FiniteCocompletions: Finite (co)product/(co)limit (co)completions
#
# This file tests if the package can be loaded without errors or warnings.
#
# do not load suggested dependencies automatically
gap> PushOptions( rec( OnlyNeeded := true ) );
gap> package_loading_info_level := InfoLevel( InfoPackageLoading );;
gap> SetInfoLevel( InfoPackageLoading, PACKAGE_ERROR );;
gap> LoadPackage( "CategoryConstructor", false );
true
gap> LoadPackage( "FinSetsForCAP", false );
true
gap> LoadPackage( "FreydCategoriesForCAP", false );
true
gap> LoadPackage( "FunctorCategories", false );
true
gap> LoadPackage( "LazyCategories", false );
true
gap> LoadPackage( "FiniteCocompletions", false );
true
gap> SetInfoLevel( InfoPackageLoading, PACKAGE_INFO );;
gap> LoadPackage( "CategoryConstructor" );
true
gap> LoadPackage( "FinSetsForCAP" );
true
gap> LoadPackage( "FreydCategoriesForCAP" );
true
gap> LoadPackage( "FunctorCategories" );
true
gap> LoadPackage( "LazyCategories" );
true
gap> LoadPackage( "FiniteCocompletions" );
true
gap> SetInfoLevel( InfoPackageLoading, package_loading_info_level );;
