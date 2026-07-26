import Grunbaum

/-!
# Kernel axiom audit

Run this file with `lake env lean Grunbaum/Audit.lean`.  Every declaration
below is expected to use exactly Lean's standard logical foundations
`propext`, `Classical.choice`, and `Quot.sound`; in particular, none may use
the proof-placeholder axiom or a project-defined axiom.
-/

#print axioms prekopa_leindler
#print axioms brunn_minkowski_euclideanSpace
#print axioms Grunbaum.concaveOn_cdfRoot
#print axioms Grunbaum.integral_cdf_rpow_inv_natCast
#print axioms Grunbaum.cdf_rpow_inv_natCast_le_at_mean
#print axioms Grunbaum.cdfRoot_centroid_lower_bound
#print axioms Grunbaum.grunbaum_centroid_halfspace
#print axioms Grunbaum.sharpClosedHalfspace_ratio
#print axioms Grunbaum.universalCentroidHalfspaceLowerBound_le_grunbaumConstant
