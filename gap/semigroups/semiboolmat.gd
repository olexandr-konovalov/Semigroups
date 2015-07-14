############################################################################
##
#W  semigroups-matrix-boolean.gd
#Y  Copyright (C) 2015                                   James D. Mitchell
##
##  Licensing information can be found in the README file of this package.
##
#############################################################################
##

# This file contains methods for semigroups of boolean matrices.

DeclareSynonym("IsBooleanMatSemigroup", 
               IsSemigroup and IsBooleanMatCollection);

InstallTrueMethod(IsFinite, IsBooleanMatSemigroup);

DeclareAttribute("AsBooleanMatSemigroup", IsSemigroup);
DeclareAttribute("IsomorphismBooleanMatSemigroup", IsSemigroup);