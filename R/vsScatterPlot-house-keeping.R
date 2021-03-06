#-----------------------------------------------------#
# Title:  ggviseq - House Keeping - scatter plots     #
# Author: Brandon Monier (brandon.monier@sdstate.edu) #
# Date:   04.04.17                                    #
#-----------------------------------------------------#

.getEdgeScatter <- function(x, y, data) {
    dat.cpm <- cpm(data$counts)
    tmp.x <- row.names(data$samples[which(data$samples$group == x), ])
    tmp.y <- row.names(data$samples[which(data$samples$group == y), ])
    x <- rowMeans(dat.cpm[, tmp.x])
    y <- rowMeans(dat.cpm[, tmp.y])

    if (is.null(data$genes)) {
        pad <- paste0("%0", nchar(nrow(data$counts)), "d")
        id <- paste0("ID_", sprintf(pad, seq(nrow(data$counts))))
    } else {
        id <- data$genes
    }

    dat.plt <- data.frame(id, x, y, stringsAsFactors = FALSE)
    return(dat.plt)
}



.getCuffScatter <- function(x, y, data) {
    sample_1 <- sample_2 <- NULL
    deg <- data
    deg <- subset(deg, (sample_1 == x & sample_2 == y) | 
                                    (sample_1 == y & sample_2 == x))
    dat <- data.frame(id = deg$test_id, stringsAsFactors = FALSE)
    
    if (x %in% deg$sample_1 && y %in% deg$sample_2) {
        dat$x <- deg$value_1
        dat$y <- deg$value_2
    } else if (y %in% deg$sample_1 && x %in% deg$sample_2) {
        dat$x <- deg$value_2
        dat$y <- deg$value_1
    }
    return(dat)
}



.getDeseqScatter <- function(x, y, data, d.factor) {
    if(is.null(factor)) {
        stop(
            'This appears to be a DESeq object. 
            Please state factor variable.'
        )
    }
    dat1 <- as.data.frame(colData(data))
    dat2 <- fpm(data)
    nam_x <- row.names(dat1[which(dat1[d.factor] == x),])
    nam_y <- row.names(dat1[which(dat1[d.factor] == y),])
    x <- rowMeans(dat2[, nam_x])
    y <- rowMeans(dat2[, nam_y])
    id <- rownames(dat2)
    dat3 <- data.frame(id, x, y, stringsAsFactors = FALSE)
    return(dat3)
}
