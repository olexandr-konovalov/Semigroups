###########################################################################
##
#W  setup.gi
#Y  Copyright (C) 2013-15                                James D. Mitchell
##
##  Licensing information can be found in the README file of this package.
##
#############################################################################
##

SEMIGROUPS.HashFunctionRZMSE := function(x, data, func)
  if x![1] = 0 then
    return 1;
  fi;

  return (x![1] + x![3] + func(x![2], data)) mod data + 1;
end;

###############################################################################
# Setup - install the basic things required for specific acting semigroups    #
###############################################################################

# IsGeneratorsOfActingSemigroup

InstallMethod(IsGeneratorsOfActingSemigroup,
"for a multiplicative element collection",
[IsMultiplicativeElementCollection], ReturnFalse);

# In the below can't do ReturnTrue, since GAP insists that we use
# InstallTrueMethod.
#
# InstallTrueMethod(IsGeneratorsOfActingSemigroup, IsTransformationCollection);
#
# can't do InstallTrueMethod for the above since this is not picked up
# if Semigroups is loaded after any transformation semigroup has been created.
# It seems that since IsTransformationCollection has had its implied filters
# installed, if we add an additional implied filter
# IsGeneratorsOfActingSemigroup, then this is ignored. I think this is a bug.

InstallMethod(IsGeneratorsOfActingSemigroup, "for a transformation collection",
[IsTransformationCollection], x -> true);

InstallMethod(IsGeneratorsOfActingSemigroup, "for a partial perm collection",
[IsPartialPermCollection], x -> true);

InstallMethod(IsGeneratorsOfActingSemigroup, "for a bipartition collection",
[IsBipartitionCollection], x -> true);

InstallMethod(IsGeneratorsOfActingSemigroup,
"for a Rees 0-matrix semigroup element collection",
[IsReesZeroMatrixSemigroupElementCollection],
function(coll)
  local R;
  R := ReesMatrixSemigroupOfFamily(FamilyObj(Representative(coll)));
  return IsGroup(UnderlyingSemigroup(R)) and IsRegularSemigroup(R);
end);

# JDM should remove this since it is not possible to have an generic Rees
# 0-matrix semigroup (or to specify any of the other options)
# InstallMethod(IsActingSemigroup, IsReesZeroMatrixSemigroup);
# FIXME this shouldn't be here because some RZMS are not acting, if they are
# defined over a transformation semigroup for example.

InstallMethod(IsGeneratorsOfActingSemigroup,
"for an matrix over finite field collection",
[IsMatrixOverFiniteFieldCollection], IsGeneratorsOfSemigroup);

# the largest point involved in the action

InstallMethod(ActionDegree, "for a transformation",
[IsTransformation], DegreeOfTransformation);

InstallMethod(ActionDegree, "for a partial perm",
[IsPartialPerm], x -> Maximum(DegreeOfPartialPerm(x),
                              CodegreeOfPartialPerm(x)));

InstallMethod(ActionDegree, "for a bipartition",
[IsBipartition], DegreeOfBipartition);

InstallMethod(ActionDegree, "for a Rees 0-matrix semigroup element",
[IsReesZeroMatrixSemigroupElement],
function(x)
  if x![1] = 0 then
    return 0;
  else
    return NrMovedPoints(x![2]) + 1;
  fi;
end);

InstallMethod(ActionDegree, "for an matrix over finite field object",
[IsMatrixOverFiniteField], DimensionOfMatrixOverSemiring);

InstallMethod(ActionDegree, "for a transformation collection",
[IsTransformationCollection], DegreeOfTransformationCollection);

InstallMethod(ActionDegree, "for a partial perm collection",
[IsPartialPermCollection], x -> Maximum(DegreeOfPartialPermCollection(x),
                                        CodegreeOfPartialPermCollection(x)));

InstallMethod(ActionDegree, "for a bipartition collection",
[IsBipartitionCollection], DegreeOfBipartitionCollection);

InstallMethod(ActionDegree, "for a Rees 0-matrix semigroup element collection",
[IsReesZeroMatrixSemigroupElementCollection],
function(coll)
  local R;
  if ForAny(coll, x -> x![1] <> 0) then
    R := ReesMatrixSemigroupOfFamily(FamilyObj(Representative(coll)));
    return NrMovedPoints(UnderlyingSemigroup(R)) + 1;
  else
    return 0;
  fi;
end);

InstallMethod(ActionDegree, "for a matrix object collection",
[IsHomogeneousList and IsMatrixOverFiniteFieldCollection],
function(coll)
  if Length(coll) = 0 then
    ErrorNoReturn("Semigroups: ActionDegree: usage,\n",
                  "the argument <coll> must be non-empty");
  fi;
  return DimensionOfMatrixOverSemiring(coll[1]);
end);

InstallMethod(ActionDegree, "for a transformation semigroup",
[IsTransformationSemigroup], DegreeOfTransformationSemigroup);

InstallMethod(ActionDegree, "for a partial perm semigroup",
[IsPartialPermSemigroup], x -> Maximum(DegreeOfPartialPermSemigroup(x),
                                       CodegreeOfPartialPermSemigroup(x)));

InstallMethod(ActionDegree, "for a partial perm inverse semigroup",
[IsPartialPermSemigroup and IsInverseSemigroup], DegreeOfPartialPermSemigroup);

InstallMethod(ActionDegree, "for a bipartition semigroup",
[IsBipartitionSemigroup], DegreeOfBipartitionSemigroup);

InstallMethod(ActionDegree, "for a Rees 0-matrix subsemigroup with generators",
[IsReesZeroMatrixSubsemigroup and HasGeneratorsOfSemigroup],
function(R)
  local parent;
  if ForAny(GeneratorsOfSemigroup(R), x -> x![1] <> 0) then
    parent := ReesMatrixSemigroupOfFamily(ElementsFamily(FamilyObj(R)));
    return NrMovedPoints(UnderlyingSemigroup(parent)) + 1;
  else
    return 0;
  fi;
end);

InstallMethod(ActionDegree, "for an matrix over finite field semigroup",
[IsMatrixOverFiniteFieldSemigroup],
function(S)
    return ActionDegree(Representative(S));
end);

# the number of points in the range of the action

InstallMethod(ActionRank, "for a transformation and integer",
[IsTransformation, IsInt], RANK_TRANS_INT);

InstallMethod(ActionRank, "for a transformation semigroup",
[IsTransformationSemigroup],
function(s)
  local deg;
  deg := DegreeOfTransformationSemigroup(s);
  return function(f)
    return RANK_TRANS_INT(f, deg);
  end;
end);

InstallMethod(ActionRank, "for a partial perm and integer",
[IsPartialPerm, IsInt],
function(f, n)
  return RankOfPartialPerm(f);
end);

InstallMethod(ActionRank, "for a partial perm semigroup",
[IsPartialPermSemigroup],
function(s)
  return RankOfPartialPerm;
end);

InstallMethod(ActionRank, "for a bipartition",
[IsBipartition, IsInt], BIPART_RANK);

InstallMethod(ActionRank, "for a bipartition semigroup",
[IsBipartitionSemigroup],
function(S)
  return RankOfBipartition;
end);

InstallMethod(ActionRank,
"for a Rees 0-matrix semigroup element and integer",
[IsReesZeroMatrixSemigroupElement, IsInt],
function(f, n)
  local parent;
  if f![1] = 0 then
    return 0;
  else
    parent := ReesMatrixSemigroupOfFamily(FamilyObj(f));
    return NrMovedPoints(UnderlyingSemigroup(parent)) + 1;
  fi;
end);

InstallMethod(ActionRank, "for a Rees 0-matrix subsemigroup",
[IsReesZeroMatrixSubsemigroup],
function(R)
  return function(x)
    local parent;
    if x![1] = 0 then
      return 0;
    else
      parent := ReesMatrixSemigroupOfFamily(ElementsFamily(FamilyObj(R)));
      return NrMovedPoints(UnderlyingSemigroup(parent)) + 1;
    fi;
  end;
end);

InstallMethod(ActionRank, "for a matrix object and integer",
[IsMatrixOverFiniteField, IsInt],
function(x, i)
  return Rank(RowSpaceBasis(x));
end);

InstallMethod(ActionRank, "for a matrix semigroup",
[IsMatrixOverFiniteFieldSemigroup],
function(S)
  return x -> Rank(RowSpaceBasis(x));
end);

# the minimum possible rank of an element

InstallMethod(MinActionRank, "for a transformation semigroup",
[IsTransformationSemigroup], x -> 1);

InstallMethod(MinActionRank, "for a partial perm semigroup",
[IsPartialPermSemigroup], x -> 0);

InstallMethod(MinActionRank, "for a bipartition semigroup",
[IsBipartitionSemigroup], x -> 0);

InstallMethod(MinActionRank, "for a Rees 0-matrix subsemigroup",
[IsReesZeroMatrixSubsemigroup], x -> 0);

InstallMethod(MinActionRank, "for a matrix semigroup",
[IsMatrixOverFiniteFieldSemigroup], x -> 0);

# options passed to LambdaOrb(s) when it is created

InstallMethod(LambdaOrbOpts, "for a transformation semigroup",
[IsTransformationSemigroup], S -> rec(forflatplainlists := true));

InstallMethod(LambdaOrbOpts, "for a partial perm semigroup",
[IsPartialPermSemigroup], S -> rec(forflatplainlists := true));

InstallMethod(LambdaOrbOpts, "for a bipartition semigroup",
[IsBipartitionSemigroup], S -> rec());

InstallMethod(LambdaOrbOpts, "for a Rees 0-matrix subsemigroup",
[IsReesZeroMatrixSubsemigroup], S -> rec());

InstallMethod(LambdaOrbOpts, "for a matrix semigroup",
[IsMatrixOverFiniteFieldSemigroup], s -> rec());

InstallMethod(RhoOrbOpts, "for a transformation semigroup",
[IsTransformationSemigroup], S -> rec(forflatplainlists := true));

InstallMethod(RhoOrbOpts, "for a partial perm semigroup",
[IsPartialPermSemigroup], S -> rec(forflatplainlists := true));

InstallMethod(RhoOrbOpts, "for a bipartition semigroup",
[IsBipartitionSemigroup], S -> rec());

InstallMethod(RhoOrbOpts, "for a Rees 0-matrix subsemigroup",
[IsReesZeroMatrixSubsemigroup], S -> rec());

InstallMethod(RhoOrbOpts, "for a matrix semigroup",
[IsMatrixOverFiniteFieldSemigroup], s -> rec());

# the lambda and rho acts
InstallMethod(LambdaAct, "for a transformation semigroup",
[IsTransformationSemigroup],
function(S)
  local deg;
  deg := DegreeOfTransformationSemigroup(S);
  return
    function(set, f)
      return OnPosIntSetsTrans(set, f, deg);
    end;
end);

InstallMethod(LambdaAct, "for a partial perm semigroup",
[IsPartialPermSemigroup], x -> OnPosIntSetsPartialPerm);

InstallMethod(LambdaAct, "for a bipartition semigroup",
[IsBipartitionSemigroup], x -> BLOCKS_RIGHT_ACT);

InstallMethod(LambdaAct, "for a Rees 0-matrix subsemigroup",
[IsReesZeroMatrixSubsemigroup], x -> function(pt, x)
  if x![1] = 0 or pt = 0 then
    return 0;
  elif pt = -1 or x![4][pt][x![1]] <> 0 then
    return x![3];
  else
    return 0;
  fi;
end);

InstallMethod(LambdaAct, "for a matrix semigroup",
[IsMatrixOverFiniteFieldSemigroup],
S -> function(vsp, mat)
  return MatrixOverFiniteFieldRowSpaceRightAction(S, vsp, mat);
end);

InstallMethod(RhoAct, "for a transformation semigroup",
[IsTransformationSemigroup],
function(S)
  local deg;
  deg := DegreeOfTransformationSemigroup(S);
  return
    function(set, f)
      return ON_KERNEL_ANTI_ACTION(set, f, deg);
    end;
end);

# JDM new c method for this!
InstallMethod(RhoAct, "for a partial perm semigroup",
[IsPartialPermSemigroup], S ->
  function(set, f)
    return OnPosIntSetsPartialPerm(set, f ^ -1);
  end);

InstallMethod(RhoAct, "for a partial perm semigroup",
[IsBipartitionSemigroup], x -> BLOCKS_LEFT_ACT);

InstallMethod(RhoAct, "for a Rees 0-matrix subsemigroup",
[IsReesZeroMatrixSubsemigroup], x -> function(pt, x)
  if x![1] = 0 or pt = 0 then
    return 0;
  elif pt = -1 or x![4][x![3]][pt] <> 0 then
    return x![1];
  else
    return 0;
  fi;
end);

InstallMethod(RhoAct, "for a matrix semigroup", [IsMatrixOverFiniteFieldSemigroup],
function(S)
  return function(vsp, mat)
    return LambdaAct(S)(vsp, TransposedMat(mat));
  end;
end);

# the seed or dummy start point for LambdaOrb

InstallMethod(LambdaOrbSeed, "for a transformation semigroup",
[IsTransformationSemigroup], S -> [0]);

InstallMethod(LambdaOrbSeed, "for a partial perm semigroup",
[IsPartialPermSemigroup], S -> [0]);

InstallMethod(LambdaOrbSeed, "for a bipartition semigroup",
[IsBipartitionSemigroup], 
function(S)
  return BLOCKS_NC([[1 .. DegreeOfBipartitionSemigroup(S) + 1]]);
end);

InstallMethod(LambdaOrbSeed, "for a Rees 0-matrix subsemigroup",
[IsReesZeroMatrixSubsemigroup], S -> -1);

InstallMethod(LambdaOrbSeed, "for a matrix semigroup",
[IsMatrixOverFiniteFieldSemigroup],
function(S)
    local deg;
    deg := DimensionOfMatrixOverSemiringCollection(S) + 1;
    return NewRowBasisOverFiniteField(IsPlistRowBasisOverFiniteFieldRep,
                                      BaseDomain(S),
                                      NullMat(deg, deg, BaseDomain(S)));
end);

# the seed or dummy start point for RhoOrb

InstallMethod(RhoOrbSeed, "for a transformation semigroup",
[IsTransformationSemigroup], S -> [0]);

InstallMethod(RhoOrbSeed, "for a partial perm semigroup",
[IsPartialPermSemigroup], S -> [0]);

InstallMethod(RhoOrbSeed, "for a bipartition semigroup",
[IsBipartitionSemigroup],
function(S)
  return BLOCKS_NC([[1 .. DegreeOfBipartitionSemigroup(S) + 1]]);
end);

InstallMethod(RhoOrbSeed, "for a Rees 0-matrix subsemigroup",
[IsReesZeroMatrixSubsemigroup], S -> -1);

InstallMethod(RhoOrbSeed, "for a matrix semigroup",
[IsMatrixOverFiniteFieldSemigroup], LambdaOrbSeed);

# the function calculating the lambda or rho value of an element

InstallMethod(LambdaFunc, "for a transformation semigroup",
[IsTransformationSemigroup],
function(S)
  local deg;
  deg := DegreeOfTransformationSemigroup(S);
  return
    function(f)
      return IMAGE_SET_TRANS_INT(f, deg);
    end;
end);

InstallMethod(LambdaFunc, "for a partial perm semigroup",
[IsPartialPermSemigroup], x -> IMAGE_SET_PPERM);

InstallMethod(LambdaFunc, "for a bipartition semigroup",
[IsBipartitionSemigroup], x -> BIPART_RIGHT_BLOCKS);

InstallMethod(LambdaFunc, "for a Rees 0-matrix subsemigroup",
[IsReesZeroMatrixSubsemigroup], R -> function(x)
  if x![1] <> 0 then
    return x![3];
  else
    return 0;
  fi;
end);

InstallMethod(LambdaFunc, "for a matrix semigroup",
[IsMatrixOverFiniteFieldSemigroup],
s -> function(mat)
  # a function that returns the row space
    return RowSpaceBasis(mat);
end);

InstallMethod(RhoFunc, "for a transformation semigroup",
[IsTransformationSemigroup],
function(S)
  local deg;
  deg := DegreeOfTransformationSemigroup(S);
  return
    function(f)
      return FLAT_KERNEL_TRANS_INT(f, deg);
    end;
end);

InstallMethod(RhoFunc, "for a partial perm semigroup",
[IsPartialPermSemigroup], x -> DOMAIN_PPERM);

InstallMethod(RhoFunc, "for a bipartition semigroup",
[IsBipartitionSemigroup], x -> BIPART_LEFT_BLOCKS);

InstallMethod(RhoFunc, "for a Rees 0-matrix subsemigroup",
[IsReesZeroMatrixSubsemigroup], R -> (x -> x![1]));

InstallMethod(RhoFunc, "for a matrix semigroup",
[IsMatrixOverFiniteFieldSemigroup],
function(S)
  # a function that returns the column space
  return
    function(mat)
      return LambdaFunc(S)(TransposedMat(mat));
    end;
end);

# the function used to calculate the rank of lambda or rho value

InstallMethod(LambdaRank, "for a transformation semigroup",
[IsTransformationSemigroup], x -> Length);

InstallMethod(LambdaRank, "for a partial perm semigroup",
[IsPartialPermSemigroup], x -> Length);

InstallMethod(LambdaRank, "for a bipartition semigroup",
[IsBipartitionSemigroup], x -> BLOCKS_RANK);

InstallMethod(LambdaRank, "for a Rees 0-matrix subsemigroup",
[IsReesZeroMatrixSubsemigroup], R ->
function(x)
  local parent;
  if x = 0 then
    return 0;
  else
    parent := ReesMatrixSemigroupOfFamily(ElementsFamily(FamilyObj(R)));
    return NrMovedPoints(UnderlyingSemigroup(parent)) + 1;
  fi;
end);

#T Why are there row spaces and matrices passed in here?
InstallMethod(LambdaRank, "for a matrix semigroup",
[IsMatrixOverFiniteFieldSemigroup], x -> Rank);

InstallMethod(RhoRank, "for a transformation semigroup",
[IsTransformationSemigroup], S -> function(x)
  if IsEmpty(x) then
    return 0;
  else
    return MaximumList(x);
  fi;
end);

InstallMethod(RhoRank, "for a partial perm semigroup",
[IsPartialPermSemigroup], x -> Length);

InstallMethod(RhoRank, "for a bipartition semigroup",
[IsBipartitionSemigroup], x -> BLOCKS_RANK);

InstallMethod(RhoRank, "for a Rees 0-matrix subsemigroup",
[IsReesZeroMatrixSubsemigroup], R -> LambdaRank(R));

InstallMethod(RhoRank, "for a matrix semigroup",
[IsMatrixOverFiniteFieldSemigroup],
function(S)
  return LambdaRank(S);
end);

# if g=LambdaInverse(X, f) and X^f=Y, then Y^g=X and g acts on the right
# like the inverse of f on Y.

InstallMethod(LambdaInverse, "for a transformation semigroup",
[IsTransformationSemigroup], S -> INV_LIST_TRANS);

InstallMethod(LambdaInverse, "for a partial perm semigroup",
[IsPartialPermSemigroup], S -> function(x, f)
                                 return f ^ -1;
                               end);

InstallMethod(LambdaInverse, "for a bipartition semigroup",
[IsBipartitionSemigroup], S -> BLOCKS_INV_RIGHT);

InstallMethod(LambdaInverse, "for a Rees 0-matrix subsemigroup",
[IsReesZeroMatrixSubsemigroup], S ->
function(k, x)
  local i;
  if x![1] = 0 or k = 0 then
    return x;
  fi;
  i := First([1 .. Length(x![4][x![3]])], i -> x![4][x![3]][i] <> 0);
  return Objectify(FamilyObj(x)!.type,
                   [i,
                    (x![4][k][x![1]] * x![2] * x![4][x![3]][i]) ^ -1,
                    k,
                    x![4]]);
end);

# if g = RhoInverse(X, f) and f ^ X = Y (this is a left action), then
# g ^ Y = X and g acts on the left like the inverse of f on Y.

InstallMethod(LambdaInverse, "for a matrix semigroup",
[IsMatrixOverFiniteFieldSemigroup], s ->
function(rsp, mat)
  return MatrixOverFiniteFieldLocalRightInverse(s, rsp, mat);
end);

InstallMethod(RhoInverse, "for a transformation semigroup",
[IsTransformationSemigroup], S -> INV_KER_TRANS);

InstallMethod(RhoInverse, "for a partial perm semigroup",
[IsPartialPermSemigroup], S ->
  function(dom, f)
    return f ^ -1;
  end);

#JDM better method for this!!

InstallMethod(RhoInverse, "for a Rees 0-matrix subsemigroup",
[IsReesZeroMatrixSubsemigroup], S ->
function(k, x)
  local i;
  if x![1] = 0 or k = 0 then
    return x;
  fi;
  i := First([1 .. Length(x![4])], i -> x![4][i][x![1]] <> 0);
  return Objectify(FamilyObj(x)!.type,
                   [k,
                    (x![4][i][x![1]] * x![2] * x![4][x![3]][k]) ^ -1,
                    i,
                    x![4]]);
end);

InstallMethod(RhoInverse, "for a bipartition semigroup",
[IsBipartitionSemigroup], S -> BLOCKS_INV_LEFT);

InstallMethod(RhoInverse, "for a matrix semigroup",
[IsMatrixOverFiniteFieldSemigroup], s ->
function(rsp, mat)
  return TransposedMat(MatrixOverFiniteFieldLocalRightInverse(s,
                          rsp, TransposedMat(mat)));
end);

InstallMethod(LambdaBound, "for a transformation semigroup",
[IsTransformationSemigroup], s ->
function(r)
  if r < 100 then
    return Factorial(r);
  else
    return infinity;
  fi;
end);

InstallMethod(RhoBound, "for a transformation semigroup",
[IsTransformationSemigroup], LambdaBound);

InstallMethod(LambdaBound, "for a partial perm semigroup",
[IsPartialPermSemigroup], s ->
function(r)
  if r < 100 then
    return Factorial(r);
  else
    return infinity;
  fi;
end);
InstallMethod(RhoBound, "for a partial perm semigroup",
[IsPartialPermSemigroup], LambdaBound);

InstallMethod(LambdaBound, "for a bipartition semigroup",
[IsBipartitionSemigroup], s ->
function(r)
  if r < 100 then
    return Factorial(r);
  else
    return infinity;
  fi;
end);
InstallMethod(RhoBound, "for a bipartition semigroup",
[IsBipartitionSemigroup], LambdaBound);

InstallMethod(LambdaBound, "for a Rees 0-matrix semigroup",
[IsReesZeroMatrixSubsemigroup], s ->
function(r)
  if r < 100 then
    return Factorial(r);
  else
    return infinity;
  fi;
end);

InstallMethod(RhoBound, "for a Rees 0-matrix semigroup",
[IsReesZeroMatrixSubsemigroup], LambdaBound);

InstallMethod(LambdaBound, "for a matrix semigroup",
[IsMatrixOverFiniteFieldSemigroup], S ->
function(r)
  if r < 100 then
    return Size(GL(DimensionOfMatrixOverSemiringCollection(S), BaseDomain(S)));
  else
    return infinity;
  fi;
end);

InstallMethod(RhoBound, "for a matrix semigroup",
[IsMatrixOverFiniteFieldSemigroup], LambdaBound);

# LamdaIdentity(s) returns a function that returns
# the identity element of the Schutzenberger group
# elements produced by LambdaPerm

# FIXME these functions don't need the argument <r> any more

InstallMethod(LambdaIdentity, "for a transformation semigroup",
[IsTransformationSemigroup],
  s -> function(r)
    return ();
  end);

InstallMethod(RhoIdentity, "for a transformation semigroup",
[IsTransformationSemigroup],
  s -> function(r)
    return ();
  end);

InstallMethod(LambdaIdentity, "for a partial perm semigroup",
[IsPartialPermSemigroup],
  s -> function(r)
    return ();
  end);

InstallMethod(RhoIdentity, "for a partial perm semigroup",
[IsPartialPermSemigroup],
  s -> function(r)
    return ();
  end);

InstallMethod(LambdaIdentity, "for a partial perm semigroup",
[IsBipartitionSemigroup],
  s -> function(r)
    return ();
  end);

InstallMethod(RhoIdentity, "for a partial perm semigroup",
[IsBipartitionSemigroup],
  s -> function(r)
    return ();
  end);

InstallMethod(LambdaIdentity, "for a Rees 0-matrix semigroup",
[IsReesZeroMatrixSubsemigroup],
  s -> function(r)
    return ();
  end);

InstallMethod(RhoIdentity, "for a Rees 0-matrix semigroup",
[IsReesZeroMatrixSubsemigroup],
  s -> function(r)
    return ();
  end);

InstallMethod(LambdaIdentity, "for a matrix semigroup",
[IsMatrixOverFiniteFieldSemigroup], S ->
function(r)
  return IdentityMatrixOverFiniteField(Representative(S), r);
end);

InstallMethod(RhoIdentity, "for a matrix semigroup",
[IsMatrixOverFiniteFieldSemigroup], S ->
function(r)
  return IdentityMatrixOverFiniteField(Representative(S), r);
end);

# LambdaPerm(s) returns a permutation from two acting semigroup elements with
# equal LambdaFunc and RhoFunc. This is required to check if one of the two
# elements belongs to the schutz gp of a lambda orb.

InstallMethod(LambdaPerm, "for a transformation semigroup",
[IsTransformationSemigroup], S -> PermLeftQuoTransformationNC);

InstallMethod(LambdaPerm, "for a partial perm semigroup",
[IsPartialPermSemigroup], S -> PERM_LEFT_QUO_PPERM_NC);

InstallMethod(LambdaPerm, "for a partial perm semigroup",
[IsBipartitionSemigroup], S -> BIPART_PERM_LEFT_QUO);

InstallMethod(LambdaPerm, "for a Rees 0-matrix subsemigroup",
[IsReesZeroMatrixSubsemigroup], S ->
function(x, y)
  if x![1] = 0 or y![1] = 0 then
    return ();
  fi;
  return x![2] ^ -1 * y![2];
end);

# Returns a permutation mapping LambdaFunc(S)(x) to LambdaFunc(S)(y) so that
# yx ^ -1(i) = p(i) when RhoFunc(S)(x) = RhoFunc(S)(y)!!

InstallMethod(LambdaPerm, "for a matrix semigroup",
[IsMatrixOverFiniteFieldSemigroup], S ->
function(x, y)
  return MatrixOverFiniteFieldSchutzGrpElement(S, x, y);
end);

InstallMethod(LambdaConjugator, "for a transformation semigroup",
[IsTransformationSemigroup], S -> TRANS_IMG_CONJ);

InstallMethod(LambdaConjugator, "for a partial perm semigroup",
[IsPartialPermSemigroup], S ->
function(x, y)
  return MappingPermListList(IMAGE_PPERM(x), IMAGE_PPERM(y));
end);

InstallMethod(LambdaConjugator, "for a bipartition semigroup",
[IsBipartitionSemigroup], S -> BIPART_LAMBDA_CONJ);

InstallMethod(LambdaConjugator, "for a Rees 0-matrix subsemigroup",
[IsReesZeroMatrixSubsemigroup], S ->
function(x, y)
  return ();
end);

InstallMethod(LambdaConjugator, "for a matrix semigroup",
[IsMatrixOverFiniteFieldSemigroup], S ->
function(x, y)
    return MatrixOverFiniteFieldLambdaConjugator(S, x, y);
end);

# the function used to test if there is an idempotent with the specified
# lambda and rho values.

InstallMethod(IdempotentTester, "for a transformation semigroup",
[IsTransformationSemigroup], S ->
function(img, ker)
  if IsEmpty(img) then
    return IsEmpty(ker);
  fi;
  return IsInjectiveListTrans(img, ker) and Length(img) = MaximumList(ker);
end);

InstallMethod(IdempotentTester, "for a partial perm semigroup",
[IsPartialPermSemigroup], S -> EQ);

InstallMethod(IdempotentTester, "for a bipartition semigroup",
[IsBipartitionSemigroup], S -> BLOCKS_E_TESTER);

InstallMethod(IdempotentTester, "for a Rees 0-matrix subsemigroup",
[IsReesZeroMatrixSubsemigroup], R ->
function(j, i)
  local parent;
  if i = 0 and j = 0 then
    return true;
  fi;
  parent := ReesMatrixSemigroupOfFamily(ElementsFamily(FamilyObj(R)));
  return Matrix(parent)[j][i] <> 0;
end);

InstallMethod(IdempotentTester, "for a matrix semigroup",
[IsMatrixOverFiniteFieldSemigroup], S -> function(x, y)
    return MatrixOverFiniteFieldIdempotentTester(S, x, y);
end);

# the function used to create an idempotent with the specified lambda and rho
# values.

InstallMethod(IdempotentCreator, "for a transformation semigroup",
[IsTransformationSemigroup], S -> IDEM_IMG_KER_NC);

InstallMethod(IdempotentCreator, "for a partial perm semigp",
[IsPartialPermSemigroup], S -> PartialPermNC);

InstallMethod(IdempotentCreator, "for a bipartition semigroup",
[IsBipartitionSemigroup], S -> BLOCKS_E_CREATOR);

InstallMethod(IdempotentCreator, "for a Rees 0-matrix subsemigroup",
[IsReesZeroMatrixSubsemigroup], R ->
function(j, i)
  local mat;
  if i = 0 and j = 0 then
    return Objectify(TypeReesMatrixSemigroupElements(R), [0]);
  fi;
  mat := Matrix(ReesMatrixSemigroupOfFamily(ElementsFamily(FamilyObj(R))));
  return Objectify(TypeReesMatrixSemigroupElements(R),
                   [i, mat[j][i] ^ -1, j, mat]);
end);

InstallMethod(IdempotentCreator, "for a matrix semigroup",
[IsMatrixOverFiniteFieldSemigroup], S -> function(x, y)
    return MatrixOverFiniteFieldIdempotentCreator(S, x, y);
end);

# the action of elements of the stabiliser of a lambda-value on any element of
# the semigroup with that lambda-value

# StabilizerAction will be \* for transformation and partial perm semigroups
# and something else for semigroups of bipartitions.

InstallMethod(StabilizerAction, "for a transformation semigroup",
[IsTransformationSemigroup], S -> PROD);

InstallMethod(StabilizerAction, "for a partial perm semigroup",
[IsPartialPermSemigroup], S -> PROD);

InstallMethod(StabilizerAction, "for a bipartition semigroup",
[IsBipartitionSemigroup], S -> BIPART_STAB_ACTION);

InstallMethod(StabilizerAction, "for a Rees 0-matrix subsemigroup",
[IsReesZeroMatrixSubsemigroup], S ->
function(x, p)

  if x![1] = 0 then
    return x;
  fi;
  return Objectify(TypeObj(x), [x![1], x![2] * p, x![3], x![4]]);
end);

InstallMethod(StabilizerAction, "for a matrix semigroup",
[IsMatrixOverFiniteFieldSemigroup], S ->
function(x, y)
  return MatrixOverFiniteFieldStabilizerAction(S, x, y);
end);

# IsActingSemigroupWithFixedDegreeMultiplication should be <true> if and only
# if it is only possible to multiply elements of the type in the semigroup with
# equal degrees.

InstallMethod(IsActingSemigroupWithFixedDegreeMultiplication,
"for a transformation semigroup",
[IsTransformationSemigroup and IsActingSemigroup], ReturnFalse);

InstallTrueMethod(IsActingSemigroupWithFixedDegreeMultiplication,
IsBipartitionSemigroup and IsActingSemigroup);

InstallMethod(IsActingSemigroupWithFixedDegreeMultiplication,
"for an acting partial perm semigroup",
[IsPartialPermSemigroup and IsActingSemigroup], ReturnFalse);

#this is not really relevant here.
InstallMethod(IsActingSemigroupWithFixedDegreeMultiplication,
"for an acting Rees 0-matrix subsemigroup",
[IsReesZeroMatrixSubsemigroup and IsActingSemigroup], ReturnFalse);

InstallTrueMethod(IsActingSemigroupWithFixedDegreeMultiplication,
                  IsMatrixOverFiniteFieldSemigroup);

InstallMethod(SchutzGpMembership, "for a transformation semigroup",
[IsTransformationSemigroup],
function(S)
  return function(stab, x)
    return SiftedPermutation(stab, x) = ();
  end;
end);

InstallMethod(SchutzGpMembership, "for a partial perm semigroup",
[IsPartialPermSemigroup],
function(S)
  return function(stab, x)
    return SiftedPermutation(stab, x) = ();
  end;
end);

InstallMethod(SchutzGpMembership, "for a Rees 0-matrix subsemigroup",
[IsReesZeroMatrixSubsemigroup],
function(S)
  return function(stab, x)
    return SiftedPermutation(stab, x) = ();
  end;
end);

InstallMethod(SchutzGpMembership, "for a bipartition semigroup",
[IsBipartitionSemigroup],
function(S)
  return function(stab, x)
    return SiftedPermutation(stab, x) = ();
  end;
end);

InstallMethod(SchutzGpMembership, "for a matrix semigroup",
[IsMatrixOverFiniteFieldSemigroup], S ->
function(stab, x)
  return x in stab;
end);

# One or a fake one for those types of object without one.

InstallMethod(FakeOne, "for a transformation collection",
[IsTransformationCollection], One);

InstallMethod(FakeOne, "for a partial perm collection",
[IsPartialPermCollection], One);

InstallMethod(FakeOne, "for a bipartition collection",
[IsBipartitionCollection], One);

InstallMethod(FakeOne, "for a Rees 0-matrix semigroup element collection",
[IsReesZeroMatrixSemigroupElementCollection], R -> SEMIGROUPS.UniversalFakeOne);

# Matrix semigroup elements
InstallMethod(FakeOne, "for an FFE coll coll coll",
[IsFFECollCollColl], One);

# missing hash functions
InstallMethod(ChooseHashFunction, "for a Rees 0-matrix semigroup element",
[IsReesZeroMatrixSemigroupElement, IsInt],
function(x, hashlen)
  local R, under, func;

  R := ReesMatrixSemigroupOfFamily(FamilyObj(x));
  if IsMultiplicativeZero(R, x) then
    x := Representative(UnderlyingSemigroup(R));
    under := ChooseHashFunction(x, hashlen).func;
  else
    under := ChooseHashFunction(x![2], hashlen).func;
  fi;
  func := function(x, hashlen)
    return SEMIGROUPS.HashFunctionRZMSE(x, hashlen, under);
  end;

  return rec(func := func,
             data := hashlen);
end);

# fallback method for hashing

InstallMethod(ChooseHashFunction, "for an object and an int",
[IsObject, IsInt],
1,
function(p, hashlen)
  return rec(func := function(v, data)
                       return 1;
                    end,
              data := fail);
end);
