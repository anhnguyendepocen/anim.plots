
# script to build package and update github website

# build github.io docs ====================================
# first, create vignette with animation files
rmarkdown::render('docs/anim.plots.Rmd', clean = FALSE)
# create presentation on website
rmarkdown::render('docs/anim-plots-presentation.Rmd')

# run build. Builds only stub vignette; copies real vignette to inst/doc =======
devtools::build_vignettes()
file.copy('docs/anim.plots.Rmd', 'inst/doc')
devtools::build()

# create example for README.md ============================
setwd('docs')
x <- rep(rnorm(400), 10)
y <- rep(rnorm(400), 10)
xlims <- 4 * 2^-(1:10/10)
ylims <- xlims <- rbind(xlims, -xlims)
readme_example <- anim.plot(x, y, times = 10, speed = 2, xlim = xlims, ylim = ylims, col = rgb(0,1,0,.3), pch = 19,
      show = FALSE)
anim.save(readme_example, filename = 'readme-example.gif')
setwd('..')

