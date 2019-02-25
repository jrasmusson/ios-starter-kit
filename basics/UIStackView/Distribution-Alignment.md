# Distribution & Alignment

## Fill

* Fills all spaces 
* Default setting
* Uses intrinsic size, but is controlled via CHCR (hugging/compressing)
* Determines which control to stretch by noting which has lowest Content Hugging Priority (CHP)
* If all controls have same CHP, then Xcode will complain layout is ambiguous

<img src="https://github.com/jrasmusson/ios-starter-kit/blob/master/basics/UIStackView/images/fill.png" alt="drawing" width="400"/>

## Fill Equally

* Makes all controls the same size
* Only distribution NOT to use instrinsic size

<img src="https://github.com/jrasmusson/ios-starter-kit/blob/master/basics/UIStackView/images/fill-equally.png" alt="drawing" width="400"/>

## Fill Proportionally

* maintains same proportion as layout shrinks and grows
* Unlike previous two, needs intrinsic size
* Fill and Fill Equally tell controls how big they should be
* This one is opposite - controls say how big they should be - this just maintains proportions

<img src="https://github.com/jrasmusson/ios-starter-kit/blob/master/basics/UIStackView/images/fill-proportionally.png" alt="drawing" width="400"/>

## Equal Spacing

* Uses intrinsic size
* Maintains equal space between each control
* If ambiguity stack shrinks based on index in `arrangedSubviwes` array

<img src="https://github.com/jrasmusson/ios-starter-kit/blob/master/basics/UIStackView/images/equal-spacing.png" alt="drawing" width="400"/>

## Equal Centering

* Equally spaces the center of controls

<img src="https://github.com/jrasmusson/ios-starter-kit/blob/master/basics/UIStackView/images/equal-centering.png" alt="drawing" width="400"/>

Those are the distribution options using `UIStackView`. Fill and Fill Equally are optionated about controlling size of children. Others respect intrinsic size and try to space in different ways.


### Links that help

* [Apple docs distribution](https://developer.apple.com/documentation/uikit/uistackview/distribution)
* [Apple docs alignment](https://developer.apple.com/documentation/uikit/uistackview/alignment)
* [Visual example where images came from](https://spin.atomicobject.com/2016/06/22/uistackview-distribution/)
