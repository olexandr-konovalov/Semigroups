#############################################################################
##
#W  ideals.gi
#Y  Copyright (C) 2006-2010                             James D. Mitchell
##
##  Licensing information can be found in the README file of this package.
##
#############################################################################
##
## $Id$
##

# JDM this must be worked on and made fully functional before a release... 



#InstallOtherMethod(Degree, "for an ideal of a transformation semigroup", 
#[IsSemigroupIdeal and IsTransformationSemigroup],
#function(i)
#return Degree(GeneratorsOfMagmaIdeal(i)[1]);
#end);


#InstallMethod(\in, "for an ideal of a transformation semigroup",
#[IsTransformation, IsMinimalIdeal], 
#function(f, i)
#return f in UnderlyingDClassOfMinIdeal(i);
#end);

############################################################################

#InstallMethod(AsSSortedList, "for an ideal of a transformation semigroup",
#[IsMinimalIdeal], 
#i-> AsSSortedList(UnderlyingDClassOfMinIdeal(i)));

############################################################################

#InstallMethod(Enumerator, "for an ideal of a transformation semigroup",
#[IsMinimalIdeal], 
#i-> Enumerator(UnderlyingDClassOfMinIdeal(i)));

############################################################################

InstallMethod(GeneratorsOfSemigroup, "for an ideal of a transformation semigroup",
[IsMinimalIdeal], 
function(i)
local gens, g;

gens:=Union(GreensRClassReps(UnderlyingDClassOfMinIdeal(i)), 
 GreensLClassReps(UnderlyingDClassOfMinIdeal(i)));
 
if Size(Semigroup(gens))=Size(UnderlyingDClassOfMinIdeal(i)) then 
	return gens;
fi;

g:=SchutzenbergerGroup(UnderlyingDClassOfMinIdeal(i));
g:=List(Generators(g), x-> AsTransformation(x, Degree(gens[1])));

return Union(gens, g);
end);

############################################################################

#InstallMethod(GreensLClassRepsData, "for an ideal of a transformation semigroup",
#[IsMinimalIdeal], 
#i-> GreensLClassRepsData(UnderlyingDClassOfMinIdeal(i)));

############################################################################

#InstallMethod(GreensLClassReps, "for an ideal of a transformation semigroup",
#[IsMinimalIdeal], 
#i-> GreensLClassReps(UnderlyingDClassOfMinIdeal(i)));

############################################################################
#JDM this is wrong as the L-classes belong to the wrong semigroup.

#InstallMethod(GreensLClasses, "for an ideal of a transformation semigroup",
#[IsMinimalIdeal], 
#i-> GreensLClasses(UnderlyingDClassOfMinIdeal(i)));

############################################################################

#InstallMethod(GreensRClassRepsData, "for an ideal of a transformation semigroup",
#[IsMinimalIdeal], 
#i-> GreensRClassRepsData(UnderlyingDClassOfMinIdeal(i)));

############################################################################

#InstallMethod(GreensRClassReps, "for an ideal of a transformation semigroup",
#[IsMinimalIdeal], 
#i-> GreensRClassReps(UnderlyingDClassOfMinIdeal(i)));

############################################################################

InstallMethod(Representative, "for an ideal of a transformation semigroup",
[IsMinimalIdeal], 
i-> GeneratorsOfMagmaIdeal(i)[1]);

############################################################################

#InstallMethod(Size, "for an ideal of a transformation semigroup",
#[IsMinimalIdeal], 
#i-> Size(UnderlyingDClassOfMinIdeal(i)));



#JDM more things here!