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
dirs <- derivedDirs(publish=params()$release, subResults=params()$fVersion)
dir.create(dirs$output, recursive=TRUE, mode="0755")
dir.create(dirs$results, recursive=TRUE, mode="0755")

################################################################
#### Do Analysis
################################################################

    


################################################################
#### Output Results
################################################################

dframe <- t(as.data.frame(params()))
fname <- file.path(dirs$results, sprintf("results_%s.xls",  params()$fVersion))
fname <- file.path(dirs$output, sprintf("results_%s.xls", params()$fVersion))
write.xlsx(dframe, file=fname, sheetName="Parameters", col.names=FALSE)

saveRDS(sessionInfo(), file="sessionInfo.rds")
saveRDS(.libPaths(), file="libPaths.rds")
tmp <- session_info()
write.xlsx2(as.data.frame(tmp$packages), file=fname, sheetName="R Packages", row.names=FALSE, append=TRUE)
tmp <- tmp$platform
write.xlsx2(data.frame(setting = names(tmp), value = unlist(tmp), stringsAsFactors = FALSE), file=fname, sheetName="R Settings", row.names=FALSE, append=TRUE)
