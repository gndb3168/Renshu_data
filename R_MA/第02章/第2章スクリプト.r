#�f�[�^�t���[���̍\���̕\��
jhk <- read.csv("�l���]������.csv")#�f�[�^�̓ǂݍ���
str(jhk)#�֐�str�ɂ��f�[�^�\���̏o��

#�f�[�^�t���[���ɕϐ���ǉ�����
jhk$�������� <- apply(jhk[,10:11],1,mean)#�u�������ρv���f�[�^�t���[���ɒǉ�
str(jhk)

#�x�����z�\
score <-c(1,5,2,10,8,2,1,4,3,3)
table(score)


#factor�^�ւ̕ϊ��Ɠx�����z�\
fscore <- factor(score,levels=seq(0,10,1))#�֐�factor�ɂ���ĕϊ�
str(fscore)#�\���̊m�F
table(fscore)#�x�����z�\


#=, ���ɂ��������o
mdat <- subset(jhk,����=="M")#�j���̃f�[�^�̂ݒ��o����
head(mdat)
mdat2 <- subset(jhk,����!="F")#��������j���̃f�[�^�̂ݒ��o����
head(mdat2)


#<, ��, >,���ɂ��������o
cope1 <- subset(jhk, ������<50)#��������50�_����(<)�̍s�𒊏o����
head(cope1)
cope2 <- subset(jhk, ������<=50)#50�_�ȉ�(��)�̍s�𒊏o����
head(cope2)
cope3 <- subset(jhk, ������>50)#50�_���傫��(>)�s�𒊏o����
head(cope3)
cope4 <- subset(jhk, ������>=50)#50�_�ȏ�(��)�̍s�𒊏o����
head(cope4)

#�_���ςƘ_���a�ɂ��������o
m1 <- subset(jhk,(����=="M")|(�N��=="�n��"))#�j���܂��͏n��(�_���a)
head(m1)
m2 <- subset(jhk,(����=="M")&(�N��=="�n��")&(�Z�\>=50))#�j�����n�����Z�\��50�_�ȏ�(�_���ς̂�)
head(m2)
m3 <- subset(jhk,(����=="M")&((�N��=="����")|(�N��=="�n��")))#�j���������܂��͏n��(�_���a�Ƙ_����)
head(m3)

#subset�𗘗p���Ȃ��s�̏������o
cond <- (jhk$����=="M")&((jhk$�N��=="����")|(jhk$�N��=="�n��"))#�����ɍ��v����s�ɂ��Ă�TRUE���C���v���Ȃ��s�ɂ�FALSE��^����
head(cond)#��ɒ�`�����x�N�g��cond�̍ŏ���6�v�f��\��
m4 <- jhk[cond,]
head(m4)

#�����f�[�^�̓ǂݍ���
kesson <- read.csv("�����f�[�^.csv")#�����ӏ����󔒂̏ꍇ
kesson

#�����f�[�^�̓ǂݍ���2
kesson2 <- read.csv("�����f�[�^2.csv")#�����ӏ������l�̏ꍇ
kesson2

#����na.strings�ɂ�錇���l�̎w��
kesson3 <- read.csv("�����f�[�^2.csv",na.strings=c(999,9999))#na.strings�Ō����l���w��
kesson3

#na.omit�ɂ�銮�S�f�[�^�s��̐���
kanzen <- na.omit(kesson3)
kanzen

#complete.cases�ɂ��s�̒��o
cind <- complete.cases(kesson3)#NA�̂Ȃ��s�ԍ����擾����
cind

#complete.cases�̌��ʂ𗘗p���Ċ��S�f�[�^�𐶐�����
kanzen2 <- kesson3[cind,]#��q��kanzen�Ɠ��e�͈�v����
kanzen2

#�֐�sort�ɂ��1�ϐ��̃\�[�g
score <-c(1,5,2,10,8,2,1,4,3,3)
sort(score,decreasing=FALSE)#decreasing�͏ȗ��DTRUE�ō~���Ƀ\�[�g


#�u�\�[�g�f�[�^.csv�v�̓��e
sdat <- read.csv("�\�[�g�f�[�^.csv")#�f�[�^�̓ǂݍ���
sdat

#�֐�order�ɂ��\�[�g���ꂽ�s�ԍ��̎擾
posi <- order(sdat$������)#�֐�order�ŋ������������Ƀ\�[�g�����Ƃ��̈ʒu�ԍ����擾����
posi
posi2 <- order(sdat$������,decreasing=TRUE)#decreasing=TRUE�ō~���̍s�ԍ����擾

#1�ϐ��ɂ��f�[�^�s��̃\�[�g
sdat[posi,]#�����̏ꍇ
sdat[posi2,]#�~���̏ꍇ

#�����ϐ��ɂ��f�[�^�t���[���̃\�[�g
posi3 <- order(sdat$������,sdat$����)
sdat[posi3,]


#�}�[�W����f�[�^
datA <-read.csv("�}�[�W�f�[�^A.csv")#�s��8
datB <-read.csv("�}�[�W�f�[�^B.csv")#�s��4
datA

#�}�[�W
merge(datA,datB,by="ID")#by�ɂ͗��f�[�^�ɋ��ʂ��Ċ܂܂�Ă���ϐ������w��

#�����l�̂���s���c���}�[�W
merge(datA, datB, by="ID", all=TRUE)

#�u�����s���f�[�^
vec <- c(2,3,4,5,1,2,3,1,2)#�e�X�g�f�[�^�̍쐬
tmat <- matrix(vec,ncol=3)
tmat


#�֐�which�ɂ��u���Ώۗv�f�̍��W�̎擾
loc2 <- which(tmat==2,arr.ind=TRUE)
loc4 <- which(tmat==4,arr.ind=TRUE)
loc2


#���l�̒u��
tmatc <- tmat #�ϊ��O�̃f�[�^�s��̃R�s�[���쐬����
tmatc[loc4] <- 2 #tmat��4�̍��W��I�����C2����
tmatc[loc2] <- 4 #tmat��2�̍��W��I�����C4����
tmatc

#�Œ蒷�f�[�^�̓ǂݍ���
itemresp <- readLines("���ڔ����Œ蒷.txt")
itemresp

#���l�̈ʒu�����쐬
spoint <- c(1,seq(7,11,1)) #�n�_�̐���
epoint <- c(6,seq(7,11,1)) #�I�_�̐���
spoint
epoint

#�ϐ����쐬
raw0 <- sapply(itemresp,substring,spoint,epoint)
raw0

#�s��̐��`
dimnames(raw0) [[2]]  <- 1:5 #��ɍs�����ώG�ɂȂ�̂Ő����l��t�^
raw1 <- t(raw0) #�s�Ɨ������
colnames(raw1) <- c("ID",paste("��",1:5,sep="")) #�ϐ�����t�^
raw1

#����f�[�^�ւ̕ϊ�
key <- read.csv("key.txt") #�����L�[�̓ǂݍ���
key[,1]
binmat <- sweep(raw1[,-1],2,key[,1],FUN="==")*1#������1�C�듚��0�ɕϊ�
binmat

#��ƃf�B���N�g�����uPOS�t�H���_�v�֕ύX
#�t�H���_���̃t�@�C���̕\��
fname <- dir()
fname


#ID-POS�f�[�^�̈��
pos0 <- read.csv("201301.csv")#�f�[�^�̓ǂݍ���
head(pos0,3)
str(pos0)#�ϐ��̌^

#�����̃f�[�^����x�ɓǂݍ���
tmp <- lapply(fname,read.csv,stringsAsFactors=FALSE)

#�����̃f�[�^�t���[�����c�ɂȂ���
posall <- do.call(rbind,tmp)#�֐�do.call��rbind�𕹗p���ĕ����̃f�[�^�t���[�����c�Ɍq����

#Factor�^�ւ̕ϊ�
locv <- c("�ڋqID","�X��","���i�J�e�S��")
posall[,locv] <- lapply(posall[,locv],as.factor)

#�u�ڋqID�v�ɂ��\�[�g
tmploc <- order(posall$�ڋqID,posall$�w����,posall$�w������)
pos <- posall[tmploc,]
head(pos)

#RFM����
R <- tapply(posall$�w����,posall$�ڋqID,max)#�ڋqID���ɍŐV�w���������߂�
F <- tapply(posall$�ڋqID,posall$�ڋqID,length)#�ڋqID���ɑ��w���񐔂����߂�
M <- tapply(posall$�w�����z,posall$�ڋqID,sum)#�ڋqID���ɑ��w�����z�����߂�
rfm <- data.frame(R=R,F=F,M=M)#R,F,M���f�[�^�t���[���Ƃ��ē���
tmploc2 <- order(rfm$M,rfm$F,rfm$R,decreasing=TRUE)#�D�揇�ʂ�M > F > R�Ƃ��ă\�[�g
rfm2 <- rfm[tmploc2,]#�\�[�g�����f�[�^��ۑ�
rfm2[1:7,]#���20�p�[�Z���g�ȓ�(36��*0.2=7.2��)�̌ڋq�̕\��


#���܂��܂ȃN���X�W�v�\�̎Z�o
t1 <- table(posall$�ڋqID,posall$���i�J�e�S��)#�S��
t2 <- xtabs(~�ڋqID+���i�J�e�S��+�X��,data=posall)#�X�ܕ�(3�X��)
t3 <- xtabs(~�ڋqID+���i�J�e�S��+�w����,data=posall)#�w������(336��)

#Factor�^�ϐ��ɂ��N���X�W�v�\
dim(table(posall[,c("�ڋqID","���i�J�e�S��")]))#�f�[�^�S�̂̃N���X�W�v�\�̍s���Ɨ񐔂����߂�
storeA <- subset(posall,�X��=="A")#�X��A�ɂ�����N���X�W�v�\�̍s���Ɨ񐔂����߂�
dim(table(storeA[,c("�ڋqID","���i�J�e�S��")]))

#�ڋqID�ʂɌ����Ƃ̑��w�����z�����߂�
cid <- posall$�ڋqID #�ڋqID�̃x�N�g��
buym <- substr(posall$�w����,1,6)#�w�����̃x�N�g��
resmat <- tapply(posall$�w�����z,list(cid,buym),sum) #�֐�tapply�̌Q�̈��������X�g�`���ŗ^����B�����ł͌ڋqID�ƍw�������w�肵�Ă���

resmat[is.na(resmat)] <- 0 #�Y���f�[�^�����݂����CNA�l���A�T�C������Ă��镔����0��������
head(resmat,3) 

#�֐�getitemname�̓ǂ݂���
#�x�N�g��x�ɑ΂��āC���̗v�f��1�ȏ�̏ꍇ�ɁC���̗v�f����Ԃ�����֐�getitemname���`
getitemname <- function(x)
{
	return(names(which(x>=1)))	
}

res2 <- apply(t1,1,getitemname)#����֐����ڋqID�Ə��i�J�e�S���̃N���X�W�v�\�ɓK�p����
head(res2,2)#�ŏ���2�v�f�𒊏o


#���X����date�`���ɕϊ�
tmpdate <- paste(substr(posall$�w����,1,4),"-",substr(posall$�w����,5,6),"-",
substr(posall$�w����,7,8),sep="")#�֐�as.Date�̈����Ƃ��Ďg����悤�ɗ��X���𕶎���ɕϊ�
tmpdate[1:5]
ndate <- as.Date(tmpdate)#�������date�`���ɕϊ�����
restime <- tapply(ndate,posall$�ڋqID,diff)#�ڋq�ʂɗ��X�Ԋu�����߂�
head(restime,2)#2�����̗��X�Ԋu��\��

#�ڋqID�ʂɗ��X�Ԋu�̕��z��`�悷��
restime2 <- lapply(restime,as.numeric) #���X�g�̗v�f�𐔒l�����Ă���
par(mfrow=c(2,3)) 
lapply(restime2[1:6],hist,breaks=10,xlab="diff",main="",col="grey")#�ŏ���1�`6�̌ڋq�̃q�X�g�O������`��

#�ڋqID�ʂɗ��X�Ԋu�̕��z��v�񂷂�
library(psych) #�p�b�P�[�Wpsych�̓ǂݍ���
resd <- lapply(restime2,describe) #�p�b�P�[�Wpsych��describe�֐��ŗv��
resd[1:2]


#���K�Ɖ�
#��1��(��ƃf�B���N�g�����uPOS�t�H���_2�v�֕ύX)
fname <- dir()
fname2 <- paste(fname,"/2013",sprintf("%02d",1:12),".csv",sep="")
tmpall <- lapply(fname2,read.csv,stringsAsFactors=FALSE)
posall2 <- do.call(rbind,tmpall)
locv <- c("�ڋqID","�X��","���i�J�e�S��")
posall2[,locv] <- lapply(posall2[,locv],as.factor)

#��2��
loc2 <- (substr(posall2$�w����,1,6)=="201302")
loc5 <- (substr(posall2$�w����,1,6)=="201305")
pos02 <- posall2[loc2,]
pos05 <- posall2[loc5,]

#��3��
store02 <- tapply(pos02$�w�����z,list(pos02$�ڋqID,pos02$�X��),sum)
store05 <- tapply(pos05$�w�����z,list(pos05$�ڋqID,pos05$�X��),sum)
store02[is.na(store02)] <-0
store05[is.na(store05)] <-0

#��4��
dat02 <- data.frame(rownames(store02),store02)#�ڋqID��ϐ��Ƃ��Ċ܂ރf�[�^�t���[�����쐬
dat05 <- data.frame(rownames(store05),store05)
colnames(dat02) <- c("�ڋqID", "2���X��A", "2���X��B","2���X��C")#�ϐ�����ύX
colnames(dat05) <- c("�ڋqID", "5���X��A", "5���X��B","5���X��C")
mdat <- merge(dat02,dat05,by="�ڋqID")#�ڋqID�ɂ���ē�̃f�[�^�Z�b�g���}�[�W

#��5��
get200 <- function(x)#200�~�ȏ゠�������ƓX�܂̏��𒊏o����֐��̒�`
{		
	loc <- which(x>=200)
	return(names(x[loc]))
}

apply(mdat[,2:7],1,get200)#��`��������֐��𗘗p���āC�ڋqID�ʂɏ��𒊏o


#��6��
ptime <- factor(round(posall2$�w������),level=seq(9,21,1))
table(posall2$���i�J�e�S��,ptime)

#��7��
tmpdate2 <- paste(substr(posall2$�w����,1,4),"-",substr(posall2$�w����,5,6),"-",
substr(posall2$�w����,7,8),sep="") #�N�����̏���yyyy-mm-dd�`���ɕϊ�
ndate2 <- as.Date(tmpdate2) #�������date�`���Ƀt�H�[�}�b�g����
restime3 <- tapply(ndate2,posall2$�ڋqID,diff) #�ڋq�ʂɗ��X�Ԋu�̍������Ƃ߂�
restime4 <- lapply(restime3,as.numeric) #���X�g�̗v�f�𐔒l�����Ă���
x50 <- function(x)#�x�N�g���̗v�f��50�ȏ�̏ꍇTRUE���C��������FALSE��Ԃ��֐�x50���`
{
	res <- sum(x>=50)
	return(ifelse(res>=1,TRUE,FALSE))
}
sid <- sapply(restime4,x50)
sid[sid==TRUE]

#��8��(��ƃf�B���N�g�����u��2�͂֕ύX�v)
fmat <- readLines("���ڔ����Œ蒷2.txt") #�f�[�^�̓ǂݍ���
sp <- c(1,7:106) #�n�_�̌�
ep <- c(6,7:106) #�I�_�̌�
fmat2 <- sapply(fmat,substring,sp,ep)
dimnames(fmat2)[[2]] <- paste("ID",sprintf("%04d",1:1000),sep="") #�s����ϊ�
fmat3 <- t(fmat2) #�s���]�u
key2 <- read.csv("key2.txt")#�����L�[�̓ǂݍ���
sweep(fmat3[,-1],2,key2[,1],FUN="==")*1 #���딽���f�[�^�̐���