#cfastfm.pxd
#
# Declarations of "external" C functions and structures
# distutils: include_dirs = /usr/include/suitesparse

cdef extern from "suitesparse/cs.h":
    ctypedef struct cs_di:  # matrix in compressed-column or triplet form */
        int nzmax      # maximum number of entries */
        int m          # number of rows */
        int n          # number of columns */
        int *p         # column pointers (size n+1) or col indices (size nzmax) */
        int *i         # row indices, size nzmax */
        double *x      # numerical values, size nzmax */
        int nz         # # of entries in triplet matrix, -1 for compressed-col */

    double cs_di_norm(const cs_di *X) # max colsum

cdef extern from "./../fastFM-core/src/fast_fm.h":

    ctypedef struct ffm_param:
        int n_iter
        int k
        double init_sigma
        int TASK
        int SOLVER
        double stepsize
        int rng_seed
        int n_comparison

    void ffm_predict(double *w_0, double * w, double * V, cs_di *X, double *y_pred, int k)

    void ffm_fit(double *w_0, double *w, double *V,
        cs_di *X, double *y,
        double lambda_w, double lambda_V, ffm_param *param)

    void ffm_mcmc_fit_predict(double *w_0, double *w, double *V,
        cs_di *X_train, cs_di *X_test, double *y_train, double *y_pred,
        double *lambda_w, double *lambda_V,
        double *alpha, double *mu_w, double *mu_V, ffm_param *param)