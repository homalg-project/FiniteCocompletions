# SPDX-License-Identifier: GPL-2.0-or-later
# FiniteCocompletions: Finite (co)product/(co)limit (co)completions
#
# Implementations
#

CapJitAddLogicTemplate(
    rec(
        variable_names := [ "statement" ],
        src_template := "statement and true",
        dst_template := "statement",
    )
);

CapJitAddLogicTemplate(
    rec(
        variable_names := [ "length", "entry" ],
        src_template := "Length( ListWithIdenticalEntries( length, entry ) )",
        dst_template := "length",
    )
);

CapJitAddLogicTemplate(
    rec(
        variable_names := [ "length", "entry", "func" ],
        src_template := "ForAll( ListWithIdenticalEntries( length, entry ), func )",
        dst_template := "func( entry )",
    )
);

CapJitAddLogicTemplate(
    rec(
        variable_names := [ "cat", "list" ],
        src_template := "IsCapCategoryObject( CreateCapCategoryObjectWithAttributes( cat, PairOfIntAndList, list ) )",
        dst_template := "true",
    )
);

CapJitAddLogicTemplate(
    rec(
        variable_names := [ "obj" ],
        src_template := "IS_IDENTICAL_OBJ( obj, obj )",
        dst_template := "true",
    )
);

CapJitAddLogicTemplate(
    rec(
        variable_names := [ "x", "cat", "obj", "list" ],
        src_template := "List( ListWithIdenticalEntries( x, CreateCapCategoryMorphismWithAttributes( cat, obj, obj, PairOfLists, list ) ), CapCategory )",
        dst_template := "ListWithIdenticalEntries( x, cat )",
    )
);

CapJitAddLogicTemplate(
    rec(
        variable_names := [ "x", "cat", "obj", "list" ],
        src_template := "List( ListWithIdenticalEntries( x, CreateCapCategoryMorphismWithAttributes( cat, obj, obj, PairOfLists, list ) ), IsCapCategoryMorphism )",
        dst_template := "ListWithIdenticalEntries( x, true )",
    )
);

CapJitAddLogicTemplate(
    rec(
        variable_names := [ "length", "entry", "y" ],
        src_template := "ListWithIdenticalEntries( length, entry )[y]",
        dst_template := "entry",
    )
);

CapJitAddLogicTemplate(
    rec(
        variable_names := [ "length" ],
        src_template := "ForAll( [ 1 .. length ], i -> true )",
        dst_template := "true",
    )
);

CapJitAddLogicTemplate(
    rec(
        variable_names := [ "number" ],
        src_template := "Product( List( [ 0 .. number - 1 ], x -> 1 ) )",
        dst_template := "1",
    )
);

CapJitAddLogicTemplate(
    rec(
        variable_names := [ "list" ],
        src_template := "Sum( List( list, x -> 1 ) )",
        dst_template := "Length( list )",
    )
);

CapJitAddLogicTemplate(
    rec(
        variable_names := [ "number1", "number2" ],
        src_template := "Length( Tuples( [ 0 .. number1 - 1 ], number2 ) )",
        dst_template := "number1 ^ number2",
    )
);

CapJitAddLogicTemplate(
    rec(
        variable_names := [ "number1", "number2" ],
        src_template := "List( Tuples( [ 0 .. number1 - 1 ], number2 ), x -> 1 )",
        dst_template := "ListWithIdenticalEntries( number1 ^ number2, 1 )",
    )
);

CapJitAddLogicTemplate(
    rec(
        variable_names := [ "number", "index" ],
        src_template := "[ number ][index]",
        dst_template := "number",
    )
);

CapJitAddLogicTemplate(
    rec(
        variable_names := [ "number" ],
        src_template := "number + 1 - 1",
        dst_template := "number",
    )
);

CapJitAddLogicTemplate(
    rec(
        variable_names := [ "number" ],
        src_template := "1 + number - 1",
        dst_template := "number",
    )
);

CapJitAddLogicTemplate(
    rec(
        variable_names := [ "number" ],
        src_template := "[ number .. number ]",
        dst_template := "[ number ]",
    )
);

CapJitAddLogicTemplate(
    rec(
        variable_names := [ "number1", "number2" ],
        src_template := "Sum( ListWithIdenticalEntries( number1, 1 ){[ 1 .. number2 ]} )",
        dst_template := "number2",
    )
);
