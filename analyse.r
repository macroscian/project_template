lapply(c("tidyverse", "devtools"),
       require, character=TRUE, quietly=TRUE)
if (grepl("thecrick", Sys.info()['nodename']) && Sys.getenv("my_r_package")!="") {
  load_all(Sys.getenv("my_r_package"))
} else {
  install_github("macroscian/R-Package")
}

params <- params_init(title="",
                      script="analyse.r",
                      alpha=0.05,
                      seed=1,
                      author="gavin.kelly")


set.seed(seed=params("seed"))
dirs <- derivedDirs()


################################################################
#### Do Analysis
################################################################

    


################################################################
#### Output Results
################################################################

dframe <- t(as.data.frame(params()))
fname <- sprintf("%s/results_%s.xls", dirs$results,  params()$fVersion)
write.xlsx(dframe, file=fname, sheetName="Parameters", col.names=FALSE)
