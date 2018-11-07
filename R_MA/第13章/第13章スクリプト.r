#�u���[�J�[�v�u�u�����h�́v�u�Z�p�́v��3�d�N���X�W�v�\
b3dat <- read.csv("���]�ԃf�[�^3.csv",row.names=1)#�f�[�^�̓ǂݍ���
head(b3dat)

xtabs(~���[�J�[+�u�����h��+�Z�p��,data=b3dat)

#�u���]�ԃf�[�^2.csv�v�̓ǂݍ���
b2dat  <- read.csv("���]�ԃf�[�^2.csv",row.names=1)#�f�[�^�̓ǂݍ���
b2dat

#��R���X�|���f���X���͂̎��s
library(FactoMineR) #�p�b�P�[�W�̓ǂݍ���
resb2dat <- CA(b2dat) #�R���X�|���f���X���͂̎��s

#�ŗL�l�̏o��
resb2dat$eig

#�s�X�R�A�Ɨ�X�R�A�̏o��
resb2dat$row$coord #�s�X�R�A�̕\��
resb2dat$col$coord #��X�R�A�̕\��
              
#�֐�summary�̏o��(�ꕔ����)
summary(resb2dat)

#�u���[�J�[�v�̃N���X�^����
z <- scale(b2dat) # �������z���_��

#�������[�N���b�h����
D0 <- dist(z, method = "euclidean")
D <- (1/2)*D0^2

#�K�w�I�N���X�^�[����
resclust <- hclust(D,method="ward.D")
plot(resclust) #�f���h���O�����̕`��

#�N���X�^�̉���
clus <- factor(cutree(resclust,k=2))�@#�N���X�^�[�ԍ��̎擾
clus
b2dat$cluster <- clus
by(b2dat[,-6],b2dat$cluster,apply,2,mean) #�N���X�^�ʂ̕��ϒl�̎Z�o


#�֐�dummie.data.frame�ɂ��f�[�^�s��̕ϊ�
library(dummies) #�p�b�P�[�W�̓ǂݍ���
db3dat <- dummy.data.frame(b3dat,sep=":")�@#�֐�dummie.data.frame�̎��s
head(db3dat) #�ŏ���6�s�̈ꕔ��\��

#�֐�CA�ɂ��(���d)�R���X�|���f���X���͂̎��s
resdb3dat <- CA(db3dat)
resdb3dat$eig #�ŗL�l�̏o�͂̈ꕔ

#��J�e�S���݂̂��v���b�g
plot(resdb3dat, invisible="row")
#plot(resdb3dat, invisible="col") #�s�J�e�S��(�]����)�݂̂��v���b�g

#�֐�MCA�ɂ�鑽�d�R���X�|���f���X���͂̎��s1
resb3dat <- MCA(b3dat)

#���d�N���X�W�v�\�̕ϊ�
crosb3dat <- xtabs(~���[�J�[+�u�����h��+�R�X�p+�Z�p��+���[�X����+�f�U�C��,data=b3dat)#���d�N���X�W�v�\�̍쐬
crosdf<- as.data.frame(crosb3dat)#�f�[�^�t���[���ւ̕ϊ�
head(crosdf) 
nrow(crosdf) #�s���̊m�F

#�x����0�̃Z�������O
crosdf2 <- crosdf[(which(crosdf[,7]>=1)),]�@#�x����1�ȏ�̍s�����I��
nrow(crosdf2)

head(crosdf2)

#�֐�MCA�ɂ�鑽�d�R���X�|���f���X���͂̎��s2
rescrosdf2<-MCA(crosdf2,quanti.sup=7,row.w=crosdf2$Freq)

#�\13.1�ɑ΂���R���X�|���f���X���͂̏o��
b2dat2 <- b2dat[,1:3]
resb2dat2 <- CA(b2dat2) #�R���X�|���f���X���͂̎��s
summary(resb2dat2) 
round(dist(rbind(resb2dat2$row$coord,�d�S=c(0,0))),3) #���[�J�[�Ԃ̋���

#���K�Ɖ�
#��1��
exdat <- read.csv("���]�ԃf�[�^���K2.csv") 

#��2��
library(dummies)
dexdat <- dummy.data.frame(exdat,sep=":")

#��3��
library(FactoMineR)
rdexdat <- CA(dexdat)
summary(rdexdat)

#��4��
rexdat <- MCA(exdat)
summary(rexdat)

#��5��
dfexdat <- as.data.frame(xtabs(~.,data=exdat))
dfexdat2 <- dfexdat[which(dfexdat$Freq>=1),]

#��6��
rdfexdat2 <- MCA(dfexdat2,quanti.sup=7,row.w=dfexdat2$Freq)
summary(rdfexdat2)
