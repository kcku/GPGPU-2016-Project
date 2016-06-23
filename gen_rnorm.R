gen_rnorm <- function(rbt) {
	if (!is.loaded("gen_rnorm")) {
		dyn.load("gen_rnorm.so")
	}
	.C("gen_rnorm", as.double(rbt), rnm = double(length = 35000000))[["rnm"]]
}