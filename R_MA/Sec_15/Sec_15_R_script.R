#�O���[�v���E�O���[�v�̉e���̌���
#�f�[�^�̓ǂݍ��݁C�f�[�^�t���[���̊m�F
tmp <- read.csv("�X�ܒ���.csv", row.names = 1) #�f�[�^�̓ǂݍ���
head(tmp)

#�K�w�I�N���X�^�[���͂̎��s
tmp_clt <- tmp[, c("���邳", "�L��", "���R��", "������")]
D0 <- dist(tmp_clt, method = "euclidean")
D<-(1 / 2) * D0 ^ 2
tmp.out <- hclust(d = D, method = "ward.D")
plot(as.dendrogram(tmp.out), ylab = "��ގ��x", nodePar = list(lab.cex = 0.5, pch = NA), ylim = c(0, 500))

#�N���X�^�[���̈Ⴂ�̐}��
cluster3 <- as.factor(cutree(tmp.out, k = 3))
cluster4 <- as.factor(cutree(tmp.out, k = 4))
tmp_clt_resW <- data.frame(tmp_clt, "�N���X�^�[��3" = cluster3, "�N���X�^�[��4" = cluster4, "�X��" = row.names(tmp_clt))
library(tidyr)
tmp_clt_resL1 <- gather(tmp_clt_resW, key = �ϓ_, value = �]���l, -�N���X�^�[��3, -�N���X�^�[��4, -�X��)
tmp_clt_resL2 <- gather(tmp_clt_resL1, key = �N���X�^�[��, value = �N���X�^�[, -�ϓ_, -�]���l, -�X��)
library(ggplot2)
P0 <- ggplot(data = tmp_clt_resL2, aes(x = �ϓ_))
P1 <- P0 + geom_line(aes(y = �]���l, color = �N���X�^�[, linetype = �N���X�^�[, group = �X��), stat = "identity")
(P2 <- P1 + facet_wrap( ~ �N���X�^�[��))

#�N���X�^�[���̑Ó����̊m�F
CNvalidity <- function(dat, clusters){
	CNvalidity0 <- function(dat, clusters, index = NULL){ #CH, H, KL�̒l���ʂɕԋp����֐�CNvalidity0
	# index�̎w��G���[����
	if(!is.element(index, c("CH", "H", "KL"))){
		stop("index�̎w�肪����������܂���")
	}
	N <- ncol(clusters) - 2 #���l���o���N���X�^�[�̐��i�ŏ��ƍŌ�̗�͑ΏۊO�j
	d <- ncol(dat) #�ϐ��̐�
	value <- data.frame(cluster.n = names(clusters)[2:(ncol(clusters)-1)], numeric(N)) #�w�W�̒l�����߂邽�߂̃I�u�W�F�N�g
	colnames(value)[2] <- index #�w�W��(CH, H, KL�̂ǂꂩ)���x�N�g���̗񖼂ɗ^����
	W <- function(X){ #�����a�Ϙa�s���ԋp����֐�W
		X <- as.matrix(X)
		V <- X-(rep(1, nrow(X)) %*% t(colMeans(X))) #���ϕ΍����f�[�^
		W <- t(V) %*% V
		return(W)
	}
	from <- as.numeric(names(clusters)[2]) #�w�W�̒l���Z�o����ŏ��̃N���X�^�[��
	to <- as.numeric(names(clusters)[(ncol(clusters) - 1)]) #�w�W�̒l���Z�o����Ō�̃N���X�^�[��
	for(i in from:to){�@#i�͎w�W���Z�o����N���X�^�[��
		# dat0-dat�ɃN���X�^�[��i�̂Ƃ��̃N���X�^�[,�N���X�^�[��i+1�̂Ƃ��̃N���X�^�[,�N���X�^�[��i-1�̂Ƃ��̃N���X�^�[���Ƃ��ĉ������f�[�^�t���[��
		dat0 <- data.frame(dat, cluster1 = factor(clusters[, names(clusters) == as.character(i)]), 
			cluster2 = factor(clusters[, names(clusters) == as.character(i + 1)]), 
			cluster3 = factor(clusters[, names(clusters) == as.character(i - 1)]))
		Ws1 <- by(data = dat0[, 1:d], INDICES = dat0$cluster1, FUN = W) #�N���X�^�[��i�̂Ƃ��̊e�N���X�^�[�̕����a�Ϙa�s��̃��X�g
		Ww1 <- Reduce(f = "+", Ws1) #�N���X�^�[��i�̂Ƃ��̌Q�������a�Ϙa�s��(�e�N���X�^�[�̕����a�Ϙa�s��̘a)
		if(index == "CH"){
			indexname <- "Calinski & Harabasz index"
			Z  <- Reduce(f = rbind, by(data = dat0[, 1:d],INDICES = dat0$cluster1, FUN = colMeans)) #�N���X�^�[��i�̂Ƃ��̊e�N���X�^�[���ς��e�s�Ɏ��s��(i�~d)
			ZZ <- Z - rep(1, i) %*% t(colMeans(dat0[, 1:d])) #Z����S�̕��ς��������s��(i�~d)
			Nc <- diag(table(dat0$cluster1))#�N���X�^�[��i�̂Ƃ��̊e�N���X�^�[�̑Ώې���Ίp�v�f�Ƃ���Ίp�s��
			Wb <- t(ZZ) %*% Nc %*% ZZ #�N���X�^�[��i�̂Ƃ��̌Q�ԕ����a�Ϙa�s��
			indexvalue <- (sum(diag((Wb))) / (i - 1))/(sum(diag((Ww1))) / (nrow(dat0) - i)) #CH�̒l
		}else if(index == "H"){
			indexname <- "Hartigan index"
			Ws2 <- by(data = dat0[, 1:d], INDICES = dat0$cluster2, FUN = W) #�N���X�^�[��i+1�̂Ƃ��̊e�N���X�^�[�̕����a�Ϙa�s��̃��X�g
			Ww2 <- Reduce(f = "+", Ws2) #�N���X�^�[��i+1�̂Ƃ��̌Q�������a�Ϙa�s��(�e�N���X�^�[�̕����a�Ϙa�s��̘a)
			indexvalue <- (sum(diag((Ww1))) / sum(diag((Ww2))) - 1) * (nrow(dat0) - i - 1) #H�̒l
			if(i == from){ #diffH���Z�o���邽�߂̏����i�ŏ��̃N���X�^�[��-1�̂Ƃ���H�̒l�j
				Ws3 <- by(data = dat0[, 1:d], INDICES = dat0$cluster3, FUN = W)#�N���X�^�[��i-1�̂Ƃ��̊e�N���X�^�[�̕����a�Ϙa�s��̃��X�g
				Ww3 <- Reduce(f = "+", Ws3) #�N���X�^�[��i-1�̂Ƃ��̌Q�������a�Ϙa�s��(�e�N���X�^�[�̕����a�Ϙa�s��̘a)		
				indexvalue_sub <- (sum(diag((Ww3))) / sum(diag((Ww1))) - 1 ) * (nrow(dat0) - (i - 1) - 1) #diffH�̒l
			}
		}else if(index == "KL"){
			indexname <- "Krzanowski & Lai index"
			Ws2 <- by(data = dat0[, 1:d], INDICES = dat0$cluster2, FUN = W)�@#�N���X�^�[��i+1�̂Ƃ��̊e�N���X�^�[�̕����a�Ϙa�s��̃��X�g
			Ww2 <- Reduce(f = "+", Ws2) #�N���X�^�[��i+1�̂Ƃ��̌Q�������a�Ϙa�s��(�e�N���X�^�[�̕����a�Ϙa�s��̘a)
			Ws3 <- by(data = dat0[, 1:d], INDICES = dat0$cluster3, FUN = W)�@#�N���X�^�[��i-1�̂Ƃ��̊e�N���X�^�[�̕����a�Ϙa�s��̃��X�g
			Ww3 <- Reduce(f = "+", Ws3) #�N���X�^�[��i-1�̂Ƃ��̌Q�������a�Ϙa�s��(�e�N���X�^�[�̕����a�Ϙa�s��̘a)
			DIFF1 <- sum(diag((Ww3))) * (i - 1) ^ (2 / d) - sum(diag((Ww1))) * (i) ^ (2 / d) #KL�̕��q
			DIFF2 <- sum(diag((Ww1))) * (i) ^ (2 / d) - sum(diag((Ww2))) * (i + 1) ^ (2 / d) #KL�̕���
			indexvalue <- abs(DIFF1 / DIFF2) #KL�̒l
		}		
		value[value[, "cluster.n"] == as.character(i), 2] <- indexvalue #�w�W�̒l�̑��
	}

	if(index == "H"){
		#value-H�̒l��diffH�̒l���e��Ƃ���I�u�W�F�N�g
		value <- data.frame(value, diffH = c(-1 * diff(c(indexvalue_sub, value[, index]))))
	}
	return(value)
	}
	#�֐�CNvalidity0��p�����e�w�W�̒l�̎Z�o�Ɠ���
	CHindex <- CNvalidity0(dat = dat, clusters = clusters, index = "CH") 
	 Hindex <- CNvalidity0(dat = dat, clusters = clusters, index = "H") 
	KLindex <- CNvalidity0(dat = dat, clusters = clusters, index = "KL")
	indices <- merge(merge(CHindex, Hindex, by = "cluster.n", sort = FALSE), KLindex, by = "cluster.n", sort = FALSE)
	return(indices)
}
from <- 1; to <- 11
clabel <- function(x){factor(cutree(tmp.out, k = x))}
clusters <- data.frame(lapply(from:to, clabel))
names(clusters) <- from:to
CNvalidity(dat = tmp_clt, clusters = clusters)

#��v���̕��U���́i�S�́j
tmp_aov <- data.frame(tmp, "�N���X�^�[" = cluster4)
tapply(tmp_aov[, "�؍ݎ���"], INDEX = tmp_aov[, "�N���X�^�["], FUN = mean)
tmp_aov.out <- aov(formula = �؍ݎ��� ~ �N���X�^�[, data = tmp_aov)
summary(tmp_aov.out)

#��v���̕��U���́i���d��r�j
TukeyHSD(tmp_aov.out)

#�ړx���_���E�ړx���_�ɂ�����
#�f�[�^�̓ǂݍ��݁C�f�[�^�t���[���̊m�F
kbs  <-  read.csv("���n����.csv") #�f�[�^�̓ǂݍ���
head(kbs)

#�f�[�^�̐��`�ƈ��q���̌���
kbs_fa  <-  kbs[, 1:20]
library(psych)
VSS.scree(kbs_fa)
eigen(cor(kbs_fa))$values
fa.parallel(kbs_fa, fm = "ml", fa = "pc", n.iter = 100)

#�T���I���q���͂̌���
library(GPArotation)
kbs_fa.out  <-  fa(kbs_fa, nfactors = 2, fm = "ml", rotate = "promax")
print(kbs_fa.out, sort = TRUE, digits = 3)

#���W���̎Z�o
kbs_S1 <- kbs_fa[, 1:10]
alpha(kbs_S1)
kbs_S2 <- kbs_fa[, -1 * c(1:10, 18, 19)] #1����10, 18, 19��ȊO�����o��
alpha(kbs_S2)

#�ړx���_�̎Z�o
S1 <- rowSums(kbs_S1)
S2 <- rowSums(kbs_S2)

#�K�w�I�d��A���͗p�̃f�[�^�t���[���쐬
kbs_hmr  <-  data.frame(kbs[, c("�T�U�G", "���x", "����", "�N��")], S1, S2)
head(kbs_hmr)

#�K�w�I�d��A���͂̎��s�i���U�������̑����̌���j
M1 <- lm(�T�U�G ~ ���� + �N�� + ���x, data = kbs_hmr)
(M1_R2 <- summary(M1)$r.squared)
M2 <- lm(�T�U�G ~ ���� + �N�� + ���x + S1 + S2, data = kbs_hmr)
(M2_R2 <- summary(M2)$r.squared)
M2_R2 - M1_R2 #���U�������̑���
anova(M1, M2)

#�K�w�I�d��A���͂̎��s�iAIC�̎Z�o�j
extractAIC(M1)
extractAIC(M2)

#������̏d��A���͂̌���
summary(M2)
confint(M2,level = 0.95)



#����󋵂̊m�F�E���ϐ��Ԃ̊֌W�̌���
#�f�[�^�̓ǂݍ��݁C�f�[�^�t���[���̊m�F
dsk <- read.csv("�j�q�Z����.csv") #�f�[�^�̓ǂݍ���
head(dsk)

#�m�F�I���q���̓��f���̐���
dsk_model_cfa <- "
� =~ �1 + �2 + �3 + �4 + �5
�\�� =~ �\��1 + �\��2 + �\��3 + �\��4 + �\��5
"
library(lavaan)
dsk.out_cfa <- cfa(model = dsk_model_cfa, data = dsk)
summary(dsk.out_cfa, fit.measures = TRUE, standardized = TRUE, ci = TRUE)

#�������f���̃��f���L�q
dsk_model_path <- "
�w�� =~ 1 * �w��1 + �w��2 + �w��3 + �w��4 + �w��5
�F�l =~ 1 * �F�l1 + �F�l2 + �F�l3 + �F�l4 + �F�l5
� =~ 1 * �1 + �2 + �3 + �4 + �5
�\�� =~ 1 * �\��1 + �\��2 + �\��3 + �\��4 + �\��5
� ~ �w�� + �F�l + BMI
�\�� ~ �w�� + �F�l + BMI
�w�� ~~ �F�l + BMI
�F�l ~~ BMI
� ~~ �\��
"

#�������f���̐��茋��
dsk.out_path <- lavaan(model = dsk_model_path, data = dsk, auto.var = TRUE)
summary(dsk.out_path, fit.measures = TRUE, standardized = TRUE, ci = TRUE)