#############################################################################
##
#W  properties.gd
#Y  Copyright (C) 2006-2010                             James D. Mitchell
##
##  Licensing information can be found in the README file of this package.
##
#############################################################################
##
## $Id$
##
##  The functions in this file are used to test whether a given transformation
##  semigroup has a given property. The algorithms can be found in:
##  
##  R. Gray and J. D. Mitchell, Largest subsemigroups of the full transformation 
##  monoid, to appear in Discrete Math.
##
#############################################################################
#############################################################################

# add missing documentation, and tests for new functions...

#JDM missing documentation!
#JDM new for 3.2!

DeclareInfoClass("InfoMonoidProperties");

###########################################################################
##
##	<#GAPDoc Label="IsBand">
##	<ManSection>
##	<Prop Name="IsBand" Arg="S"/>
##	<Description>
##	returns <C>true</C> if the transformation semigroup <C>S</C> is a band and 
##	<C>false</C> otherwise.<P/>
##
##	A semigroup \(S\) is a <E>band</E> if every element is an idempotent, 
##	that is, \(x^2=x\) for all \(x\in S\).
##
##	<Example>
##  gap&gt; gens:=[ Transformation( [ 1, 1, 1, 4, 4, 4, 7, 7, 7, 1 ] ), 
##  &gt; Transformation( [ 2, 2, 2, 5, 5, 5, 8, 8, 8, 2 ] ), 
##  &gt; Transformation( [ 3, 3, 3, 6, 6, 6, 9, 9, 9, 3 ] ), 
##  &gt; Transformation( [ 1, 1, 1, 4, 4, 4, 7, 7, 7, 4 ] ), 
##  &gt; Transformation( [ 1, 1, 1, 4, 4, 4, 7, 7, 7, 7 ] ) ];;
##  gap&gt; S:=Semigroup(gens);;
##  gap&gt; IsBand(S);
##  true
##	</Example> <!-- properties.tst -->
##	</Description>
##	</ManSection>
##	<#/GAPDoc>

DeclareProperty("IsBand", IsTransformationSemigroup);

###########################################################################
##	<#GAPDoc Label="IsBlockGroup">
##	<ManSection>
##	<Prop Name="IsBlockGroup" Arg="S"/>
##	<Description>
##	returns <C>true</C> if the transformation semigroup <C>S</C> is a block 
##	group and <C>false</C> otherwise. A semigroup is a
##	<E>block group</E> if every <M>L</M>-class and every <M>R</M>-class of 
##	<C>S</C> contains at most one idempotent.  
##	</Description> <!-- JDM example!-->
##	</ManSection>
##	<#/GAPDoc>

#JDM new for 3.2!

DeclareProperty("IsBlockGroup", IsTransformationSemigroup);

###########################################################################
##
##	<#GAPDoc Label="IsCliffordSemigroup">
##	<ManSection>
##	<Prop Name="IsCliffordSemigroup" Arg="S"/>
##	<Description>
##	returns <C>true</C> if the transformation semigroup <C>S</C> is a Clifford 
##	semigroup and <C>false</C> otherwise.<P/>
##
##  A semigroup <C>S</C> is a <E>Clifford 
##	semigroup</E> if it is a regular semigroup and its idempotents are central:
##	$$(\forall s\in S)(\exists t\in S)(sts=s)\wedge(\forall s, t\in S)(s^2=s\rightarrow st=ts).$$
##
##	<Example>
##  gap&gt; gens:=[Transformation([1,2,4,5,6,3,7,8]),
##  &gt; Transformation([3,3,4,5,6,2,7,8]),
##  &gt;Transformation([1,2,5,3,6,8,4,4])];;
##  gap&gt; S:=Semigroup(gens);;
##  gap&gt; IsCliffordSemigroup(S);
##  true
##	</Example> <!-- properties.tst -->
##	</Description>
##	</ManSection>
##	<#/GAPDoc>

DeclareProperty("IsCliffordSemigroup", IsTransformationSemigroup);

###########################################################################
##
##	<#GAPDoc Label="IsCommutativeSemigroup">
##	<ManSection>
##	<Prop Name="IsCommutativeSemigroup" Arg="S"/>
##	<Description>
##	returns <C>true</C> if the transformation semigroup <C>S</C> is commutative 
##	and <C>false</C> otherwise. The function 
##	<Ref Prop="IsCommutative" BookName="ref"/> can also be used to test if a 
##	semigroup is commutative.  <P/>
##
##	A semigroup <C>S</C> is <E>commutative</E> if 
##	<C>xy=yx</C> for all <C>x,y</C> in <C>S</C>.
##
##	<Example>
##  gap&gt; gens:=[ Transformation( [ 2, 4, 5, 3, 7, 8, 6, 9, 1 ] ), 
##  &gt;  Transformation( [ 3, 5, 6, 7, 8, 1, 9, 2, 4 ] ) ];;
##  gap&gt; S:=Semigroup(gens);;
##  gap&gt; IsCommutativeSemigroup(S);
##  true
##  gap&gt; IsCommutative(S);
##  true
##	</Example> <!-- properties.tst -->
##	</Description>
##	</ManSection>
##	<#/GAPDoc>

DeclareProperty("IsCommutativeSemigroup", IsTransformationSemigroup);

###########################################################################
##
##	<#GAPDoc Label="IsCompletelyRegularSemigroup">
##	<ManSection>
##	<Prop Name="IsCompletelyRegularSemigroup" Arg="S"/>
##	<Description>
##	returns <C>true</C> if the transformation semigroup <C>S</C> is completely 
##	regular and <C>false</C> otherwise.<P/>
##	A semigroup is <E>completely regular</E> 
##	if every element is contained in a subgroup.
##
##	<Example>	
##  gap&gt; gens:=[ Transformation( [ 1, 2, 4, 3, 6, 5, 4 ] ), 
##  &gt;  Transformation( [ 1, 2, 5, 6, 3, 4, 5 ] ), 
##  &gt;  Transformation( [ 2, 1, 2, 2, 2, 2, 2 ] ) ];;
##  gap&gt; S:=Semigroup(gens);;
##  gap&gt; IsCompletelyRegularSemigroup(S);
##  true
##  gap&gt; S:=RandomSemigroup(5,5);;
##  gap&gt; IsSimpleSemigroup(S);
##  false
##	</Example> <!-- properties.tst -->
##	</Description>
##	</ManSection>
##	<#/GAPDoc>

DeclareProperty("IsCompletelyRegularSemigroup", IsTransformationSemigroup);

###########################################################################
##
##	<#GAPDoc Label="IsCompletelySimpleSemigroup">
##	<ManSection><Heading>IsSimpleSemigroup</Heading>
##	<Prop Name="IsSimpleSemigroup" Arg="S"/>
##	<Prop Name="IsCompletelySimpleSemigroup" Arg="S"/>
##	<Description>
##	returns <C>true</C> if the transformation semigroup <C>S</C> is simple and 
##	<C>false</C> otherwise.<P/>
##
##	A semigroup is <E>simple</E> if it has no proper
##	2-sided ideals. A semigroup is <E>completely simple</E> if it is simple and 
##	possesses minimal left and right ideals. A finite semigroup is simple if and 
##	only if it is completely simple. 
##
##	<Example>
##  gap&gt; gens:=[ Transformation( [ 2, 2, 4, 4, 6, 6, 8, 8, 10, 10, 12, 12, 2 ] ), 
##  &gt;  Transformation( [ 1, 1, 3, 3, 5, 5, 7, 7, 9, 9, 11, 11, 3 ] ), 
##  &gt;  Transformation( [ 1, 7, 3, 9, 5, 11, 7, 1, 9, 3, 11, 5, 5 ] ), 
##  &gt;  Transformation( [ 7, 7, 9, 9, 11, 11, 1, 1, 3, 3, 5, 5, 7 ] ) ];;
##  gap&gt; S:=Semigroup(gens);;
##  gap&gt; IsSimpleSemigroup(S);
##  true
##  gap&gt; IsCompletelySimpleSemigroup(S);
##  true
##  gap&gt; S:=RandomSemigroup(5,5);;
##  gap&gt; IsSimpleSemigroup(S);
##  false
##	</Example> <!-- properties.tst -->
##	</Description>
##	</ManSection>
##	<#/GAPDoc>

if not IsBound(IsCompletelySimpleSemigroup) then 
	DeclareProperty("IsCompletelySimpleSemigroup", IsSemigroup);
	InstallTrueMethod(IsCompletelySimpleSemigroup, IsFinite and 
	IsSimpleSemigroup);
fi;

# the below is not used to avoid conflicts with smallsemi!

#if not IsBound(IsCompletelySimpleSemigroup) then 
#	DeclareSynonymAttr("IsCompletelySimpleSemigroup", IsFinite and 
#		IsSimpleSemigroup);
#fi;

###########################################################################
##	<#GAPDoc Label="IsGreensRTrivial">
##	<ManSection>
##	<Prop Name="IsGreensRTrivial" Arg="S"/>
##	<Prop Name="IsGreensLTrivial" Arg="S"/>
##	<Prop Name="IsGreensHTrivial" Arg="S"/>
##	<Prop Name="IsAperiodicSemigroup" Arg="S"/>
##	<Prop Name="IsCombinatorialSemigroup" Arg="S"/>
##	<Description>
##	returns <C>true</C> if Green's <M>R</M>-relation, <M>L</M>-relation, or
##  <M>H</M>-relation, respectively, on the
##	transformation semigroup <C>S</C> is trivial and <C>false</C> otherwise. A 
##	semigroup is <E>aperiodic</E> if its group <M>H</M>-classes are trivial. A 
##  finite semigroup is aperiodic if and only if it is <M>H</M>-trivial. 
##	</Description><!-- JDM example!-->
##	</ManSection>
##	<#/GAPDoc>

#JDM new for 3.2!

DeclareProperty("IsGreensRTrivial", IsTransformationSemigroup);
DeclareProperty("IsGreensLTrivial", IsTransformationSemigroup);
DeclareProperty("IsGreensHTrivial", IsTransformationSemigroup);
DeclareSynonymAttr("IsAperiodicSemigroup", IsGreensHTrivial);
DeclareSynonymAttr("IsCombinatorialSemigroup", IsGreensHTrivial);

###########################################################################
##
##	<#GAPDoc Label="IsGroupAsSemigroup">
##	<ManSection>
##	<Prop Name="IsGroupAsSemigroup" Arg="S"/>
##	<Description>
##	returns <C>true</C> if the transformation semigroup <C>S</C> is a group and 
##	<C>false</C> otherwise.
##
##	<Example>
##  gap&gt; gens:=[ Transformation( [ 2, 4, 5, 3, 7, 8, 6, 9, 1 ] ), 
##  &gt;  Transformation( [ 3, 5, 6, 7, 8, 1, 9, 2, 4 ] ) ];;
##  gap&gt; S:=Semigroup(gens);;
##  gap&gt; IsGroupAsSemigroup(S);
##  true
##	</Example> <!-- properties.tst -->
##	</Description>
##	</ManSection>
##	<#/GAPDoc>

DeclareProperty("IsGroupAsSemigroup", IsTransformationSemigroup);

###########################################################################
##
##	<#GAPDoc Label="IsInverseSemigroup">
##	<ManSection>
##	<Prop Name="IsInverseSemigroup" Arg="S"/>
##	<Description>
##	returns <C>true</C> if the transformation semigroup <C>S</C> is an inverse
##	semigroup and <C>false</C> otherwise.<P/>
##
##	A semigroup <C>S</C> is an <E>inverse semigroup</E> if every element 
##	<C>x</C> in <C>S</C> has a unique semigroup inverse, that is, a unique 
##	element <C>y</C> such that <C>xyx=x</C> and <C>yxy=y</C>.
##
##	<Example>
##  gap&gt; gens:=[Transformation([1,2,4,5,6,3,7,8]),
##  &gt; Transformation([3,3,4,5,6,2,7,8]),
##  &gt;Transformation([1,2,5,3,6,8,4,4])];;
##  gap&gt; S:=Semigroup(gens);;
##  gap&gt; IsInverseSemigroup(S);
##  true
##	</Example> <!-- properties.tst -->
##	</Description>
##	</ManSection>
##	<#/GAPDoc>

###########################################################################
##	<#GAPDoc Label="IsIrredundantGeneratingSet">
##	<ManSection>
##	<Oper Name="IsIrredundantGeneratingSet" Arg="[S, ]U"/>
##	<Description>
##	returns <C>true</C> if <C>u</C> is not an element of the subsemigroup 
##	generated by <C>U</C> without <C>u</C> for all <C>u</C> in <C>U</C>.<P/>
##	
##	If the optional first argument is present, then 
##	<C>IsIrredundantGeneratingSet</C> first checks that <C>U</C> generates 
##	<C>S</C>.
##	
##	<Example>	
##	
##	</Example><!-- JDM example!-->
##	</Description>
##	</ManSection>
##	<#/GAPDoc>

#JDM new for 3.2!

DeclareOperation("IsIrredundantGeneratingSet", [IsTransformationCollection]);

###########################################################################
##
##	<#GAPDoc Label="IsLeftZeroSemigroup">
##	<ManSection>
##	<Prop Name="IsLeftZeroSemigroup" Arg="S"/>
##	<Description>
##	returns <C>true</C> if the transformation semigroup <C>S</C> is 
##	a left zero semigroup and <C>false</C> otherwise.<P/>
##
##	A semigroup <C>S</C> is a <E>left zero semigroup</E> if <C>xy=x</C> for all 
##	<C>x,y</C> in <C>S</C>.
##
##	<Example>
##  gap&gt; gens:=[ Transformation( [ 2, 1, 4, 3, 5 ] ), 
##  &gt;  Transformation( [ 3, 2, 3, 1, 1 ] ) ];;
##  gap&gt; S:=Semigroup(gens);;
##  gap&gt; IsRightZeroSemigroup(S);
##  false
##  gap&gt; gens:=[Transformation( [ 1, 2, 3, 3, 1 ] ), 
##  &gt; Transformation( [ 1, 2, 3, 3, 3 ] ) ];;
##  gap&gt; S:=Semigroup(gens);;
##  gap&gt; IsLeftZeroSemigroup(S);
##  true
##	</Example> <!-- properties.tst -->
##	</Description>
##	</ManSection>
##	<#/GAPDoc>

DeclareProperty("IsLeftZeroSemigroup", IsTransformationSemigroup);


#JDM missing documentation!
#JDM new for 3.2!

DeclareProperty("IsMonoidAsSemigroup", IsTransformationSemigroup);

###########################################################################
##	<#GAPDoc Label="IsOrthodoxSemigroup">
##	<ManSection>
##	<Prop Name="IsOrthodoxSemigroup" Arg="S"/>
##	<Description>
##	returns <C>true</C> if the transformation semigroup <C>S</C> is 
##	orthodox and <C>false</C> otherwise.<P/>
##	
##	A semigroup is an <E>orthodox semigroup</E> if its idempotent elements 
##	form a subsemigroup.
##
##	<Example>
##  gap&gt; gens:=[ Transformation( [ 1, 1, 1, 4, 5, 4 ] ), 
##  &gt;  Transformation( [ 1, 2, 3, 1, 1, 2 ] ), 
##  &gt;  Transformation( [ 1, 2, 3, 1, 1, 3 ] ), 
##  &gt;  Transformation( [ 5, 5, 5, 5, 5, 5 ] ) ];;
##  gap&gt; S:=Semigroup(gens);;
##  gap&gt; IsOrthodoxSemigroup(S);
##  true
##	</Example> <!-- properties.tst -->
##	</Description>
##	</ManSection>
##	<#/GAPDoc>

DeclareProperty("IsOrthodoxSemigroup", IsTransformationSemigroup);

###########################################################################
##
##	<#GAPDoc Label="IsRectangularBand">
##	<ManSection>
##	<Prop Name="IsRectangularBand" Arg="S"/>
##	<Description>
##	returns <C>true</C> if the transformation semigroup <C>S</C> is a 
##	rectangular band and <C>false</C> otherwise.<P/>
##
##	A semigroup <C>S</C> is a <E>rectangular band</E> if for all <C>x,y,z</C> in 
##	<C>S</C> we have that <C>x^2=x</C> and <C>xyz=xz</C>.
##
##	<Example>
##  gap&gt; gens:=[ Transformation( [ 1, 1, 1, 4, 4, 4, 7, 7, 7, 1 ] ), 
##  &gt; Transformation( [ 2, 2, 2, 5, 5, 5, 8, 8, 8, 2 ] ), 
##  &gt; Transformation( [ 3, 3, 3, 6, 6, 6, 9, 9, 9, 3 ] ), 
##  &gt; Transformation( [ 1, 1, 1, 4, 4, 4, 7, 7, 7, 4 ] ), 
##  &gt; Transformation( [ 1, 1, 1, 4, 4, 4, 7, 7, 7, 7 ] ) ];;
##  gap&gt; S:=Semigroup(gens);;
##  gap&gt; IsRectangularBand(S);
##  true
##	</Example> <!-- properties.tst -->
##	</Description>
##	</ManSection>
##	<#/GAPDoc>

DeclareProperty("IsRectangularBand", IsTransformationSemigroup);

###########################################################################
##
##	<#GAPDoc Label="IsRegularSemigroup">
##	<ManSection>
##	<Prop Name="IsRegularSemigroup" Arg="S"/>
##	<Description>
##	returns <C>true</C> if the transformation semigroup <C>S</C> is a regular
##	semigroup and <C>false</C> otherwise. The algorithm used here is essentially 
##	the same algorithm as that used for 
##	<Ref Attr="GreensRClasses" BookName="ref"/> in <Package>MONOID</Package>. If 
##	<C>S</C> is regular, then <C>S</C> will have the attribute 
##	<C>GreensRClasses</C> after <C>IsRegularSemigroup</C> is invoked. <P/>
##
##	A semigroup <C>S</C> is <E>regular</E> if for all <C>x</C> in <C>S</C> there 
##	exists <C>y</C> in <C>S</C> such that <C>xyx=x</C>.
##
##	<Example>
##  gap&gt; IsRegularSemigroup(FullTransformationSemigroup(5));
##  true
##	</Example> <!-- properties.tst -->
##	</Description>
##	</ManSection>
##	<#/GAPDoc>

###########################################################################
##
##	<#GAPDoc Label="IsRightZeroSemigroup">
##	<ManSection>
##	<Prop Name="IsRightZeroSemigroup" Arg="S"/>
##	<Description>
##	returns <C>true</C> if the transformation semigroup <C>S</C> is 
##	a right zero semigroup and <C>false</C> otherwise.<P/>
##
##	A semigroup <C>S</C> is a <E>right zero semigroup</E> if <C>xy=y</C> for all 
##	<C>x,y</C> in <C>S</C>.
##
##	<Example>
##  gap&gt; gens:=[ Transformation( [ 2, 1, 4, 3, 5 ] ), 
##  &gt;  Transformation( [ 3, 2, 3, 1, 1 ] ) ];;
##  gap&gt; S:=Semigroup(gens);;
##  gap&gt; IsRightZeroSemigroup(S);
##  false
##  gap&gt; gens:=[Transformation( [ 1, 2, 3, 3, 1 ] ), 
##  &gt;  Transformation( [ 1, 2, 4, 4, 1 ] )];;
##  gap&gt; S:=Semigroup(gens);;
##  gap&gt; IsRightZeroSemigroup(S);
##  true
##	</Example> <!-- properties.tst -->
##	</Description>
##	</ManSection>
##	<#/GAPDoc>

DeclareProperty("IsRightZeroSemigroup", IsTransformationSemigroup);

###########################################################################
##
##	<#GAPDoc Label="IsSemiBand">
##	<ManSection>
##	<Prop Name="IsSemiBand" Arg="S"/>
##	<Description>
##	returns <C>true</C> if the transformation semigroup <C>S</C> is a 
##	semiband and <C>false</C> otherwise.<P/>
##
##	A semigroup <C>S</C> is a <E>semiband</E> if it is generated by its 
##	idempotent elements, that is, elements satisfying <C>x^2=x</C>.
##
##	<Example>
##  gap&gt; S:=FullTransformationSemigroup(4);;
##  gap&gt; x:=Transformation( [ 1, 2, 3, 1 ] );;
##  gap&gt; D:=GreensDClassOfElement(S, x);;
##  gap&gt; T:=Semigroup(Elements(D));;
##  gap&gt; IsSemiBand(T);
##  true
##	</Example> <!-- properties.tst -->
##	</Description>
##	</ManSection>
##	<#/GAPDoc>

DeclareProperty("IsIdempotentGenerated", IsTransformationSemigroup);

#JDM new for 3.2!
DeclareSynonymAttr("IsSemiBand", IsIdempotentGenerated);

###########################################################################
##	<#GAPDoc Label="IsSemilatticeAsSemigroup">
##	<ManSection>
##	<Prop Name="IsSemilatticeAsSemigroup" Arg="S"/>
##	<Description>
##	returns <C>true</C> if the semigroup <C>S</C> is a semilattice 
##	 and <C>false</C> otherwise. A semigroup is a
##	<E>semilattice</E> if it is commutative and every element is an 
##  idempotent.
##  <Example>
##  gap> a:=Transformation( [ 2, 5, 1, 7, 3, 7, 7 ] );;
##  gap> b:=Transformation( [ 3, 6, 5, 7, 2, 1, 7 ] );;
##  gap> s:=Semigroup(a,b);;                    
##  &lt;semigroup with 2 generators>
##  gap> Size(s);
##  631
##  gap> IsInverseSemigroup(s);
##  true
##  gap> e:=Semigroup(Idempotents(s)); 
##  &lt;semigroup with 32 generators>
##  gap> IsSemilatticeAsSemigroup(e);
##  true
##  </Example> <!-- dev/properties.tst -->
##	</Description>
##	</ManSection>
##	<#/GAPDoc>

#JDM new for 3.2!

if not IsBound(IsSemilatticeAsSemigroup) then 
  DeclareProperty("IsSemilatticeAsSemigroup", IsSemigroup);
  InstallTrueMethod(IsSemilatticeAsSemigroup, IsCommutative and IsBand);
fi;

###########################################################################
##
##	<#GAPDoc Label="IsZeroSemigroup">
##	<ManSection>
##	<Prop Name="IsZeroSemigroup" Arg="S"/>
##	<Description> 
##	returns <C>true</C> if the transformation semigroup <C>S</C> is 
##	a zero semigroup or if <C>S</C> was created using the 
##	<Ref Oper="ZeroSemigroup"/> command. Otherwise <C>false</C> is returned.<P/>
##
##	A semigroup <C>S</C> is a <E>zero semigroup</E> if there exists an element 
##	<C>0</C> in <C>S</C> such that <C>xy=0</C> for all <C>x,y</C> in <C>S</C>.
##
##	<Example>
##  gap&gt; gens:=[ Transformation( [ 4, 7, 6, 3, 1, 5, 3, 6, 5, 9 ] ), 
##  &gt; Transformation( [ 5, 3, 5, 1, 9, 3, 8, 7, 4, 3 ] ), 
##  &gt; Transformation( [ 5, 10, 10, 1, 7, 6, 6, 8, 7, 7 ] ), 
##  &gt; Transformation( [ 7, 4, 3, 3, 2, 2, 3, 2, 9, 3 ] ), 
##  &gt; Transformation( [ 8, 1, 3, 4, 9, 6, 3, 7, 1, 6 ] ) ];;
##  gap&gt; S:=Semigroup(gens);;
##  gap&gt; IsZeroSemigroup(S);
##  false
##	</Example> <!-- properties.tst -->
##	</Description>
##	</ManSection>
##	<#/GAPDoc>

DeclareProperty("IsZeroSemigroup", IsTransformationSemigroup);

###########################################################################
##
##	<#GAPDoc Label="IsZeroGroup">
##	<ManSection>
##	<Prop Name="IsZeroGroup" Arg="S"/>
##	<Description> 
##	returns <C>true</C> if the transformation semigroup <C>S</C> is 
##	a zero group or if <C>S</C> was created using the <Ref Oper="ZeroGroup"/> 
##	command. Otherwise <C>false</C> is returned.<P/>
##
##	A semigroup <C>S</C> <C>S</C> is a <E>zero group</E> if there exists an 
##	element <C>0</C> in <C>S</C> such that <C>S</C> without <C>0</C> is a group 
##	and for all <C>x</C> in <C>S</C> we have that <C>x0=0x=0</C>.
##	<Example>
##  gap&gt; S:=ZeroGroup(DihedralGroup(10));;
##  gap&gt; iso:=IsomorphismTransformationSemigroup(S);;
##  gap&gt; T:=Range(iso);;
##  gap&gt; IsZeroGroup(T);
##  true
##	</Example> <!-- properties.tst -->
##	</Description>
##	</ManSection>
##	<#/GAPDoc>

#DeclareAttribute("IsZeroGroup", IsSemigroup);
#JDM why's this commented out? 

###########################################################################
##	<#GAPDoc Label="MultiplicativeZero">
##	<ManSection>
##	<Prop Name="MultiplicativeZero" Arg="S"/>
##	<Description> 
##	returns the multiplicative zero of the transformation semigroup <C>S</C> if 
##	it has one and returns <C>fail</C> otherwise. 
##
##	<Example>
##  gap> s:=Semigroup( Transformation( [ 1, 4, 2, 6, 6, 5, 2 ] ), 
##  > Transformation( [ 1, 6, 3, 6, 2, 1, 6 ] ));;
##  gap> MultiplicativeZero(s);
##  Transformation( [ 1, 1, 1, 1, 1, 1, 1 ] )
##  s:=Semigroup(Transformation( [ 2, 8, 3, 7, 1, 5, 2, 6 ] ), 
##  > Transformation( [ 3, 5, 7, 2, 5, 6, 3, 8 ] ), 
##  > Transformation( [ 6, 7, 4, 1, 4, 1, 6, 2 ] ), 
##  > Transformation( [ 8, 8, 5, 1, 7, 5, 2, 8 ] ));;
##  gap> MultiplicativeZero(s);
##  fail
##	</Example> <!-- properties.tst -->
##	</Description>
##	</ManSection>
##	<#/GAPDoc>

###########################################################################
##	<#GAPDoc Label="SmallGeneratingSet">
##	<ManSection>
##	<Oper Name="SmallGeneratingSet" Arg="S"/>
##	<Description>
##	returns a generating set for the transformation semigroup <C>S</C> with a  
##	relatively small number of elements. As neither irredundancy, nor minimal 
##	length is proven it runs much faster than 
##	<Ref Oper="MinimalGeneratingSet"/>. It can be used whenever a small 
##	generating set is desired which does not necessarily needs to be optimal. 
##	<C>SmallGeneratingSet</C> may return different result in different &GAP; 
##	sessions.
##	
##	<Example>	
##	
##	</Example><!-- JDM example!-->
##	</Description>
##	</ManSection>
##	<#/GAPDoc>

DeclareOperation("IrredundantGeneratingSubset", [IsTransformationCollection]);
DeclareOperation("PropertiesOfSemigroup", [IsTransformationSemigroup]);
DeclareOperation("EasyPropertiesOfSemigroup", [IsTransformationSemigroup]);
DeclareAttribute("MinimalIdeal", IsTransformationSemigroup);
DeclareAttribute("UnderlyingDClassOfMinIdeal", IsSemigroupIdeal and IsTransformationSemigroup);
DeclareProperty("IsMinimalIdeal", IsSemigroupIdeal and IsTransformationSemigroup);
DeclareProperty("IsSemigroupWithCommutingIdempotents", IsSemigroup);
DeclareAttribute("GroupOfUnits", IsSemigroup);

#JDM new for 3.2!
