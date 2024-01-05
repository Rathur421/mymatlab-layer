;; This file is the first file to be loaded and this is the place where additional layers can be declared.
;;
;; For instance, if layer A depends on some functionality of layer B, then in the file layers.el of layer A, we can add:
;;
;; (configuration-layer/declare-layer 'B)
;; The effect is that B is considered a used layer and will be loaded as if it was added to dotspacemacs-configuration-layers variables.
(configuration-layer/declare-shadow-relation 'octave 'matlab)
