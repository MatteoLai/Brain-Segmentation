# Brain-Segmentation
Segmentation of a DICOM CT brain image using Chan-Vese algorithm.

This repo contains 
- _main_CTbrain.m_, the main script;
- _CT_brain.dmc_, a CT brain image in DICOM format;
- all the functions needed to segment the gray matter and a glioblastoma in the image using Chan-Vese algorithm.
     In particular:
     - _initialization.m_ generates the initial curve, input for _Chan-Vese.m_;
     - _D_x.m_ and _D_y.m_ implement the derivatives along x and y, allowing to select the forward, backward or centered one - used in _Chan-Vese.m_;
     - _Dxx.m_ and _Dyy.m_ implement the second derivatives along x and y - used in _KG.m_;
     - _G.m_ and _KG.m_ implement respectively the gradient module and the gradient module-curvature product - used in _Chan-Vese.m_;
     - _Chan-Vese.m_ implement the Chan-Vese algorithm

The main script apply Chan-Vese algorithm to segment the brighter areas, useful to:
 a) segment the glioblastoma
 b) mask the image and apply again Chan-Vese to segment the gray matter

