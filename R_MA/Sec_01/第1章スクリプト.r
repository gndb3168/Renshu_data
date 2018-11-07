#�f�[�^�̓ǂݍ���
jhk <- read.csv("�l���]������.csv") #�f�[�^�̓ǂݍ���

#�f�[�^�̊m�F
dim(jhk) #�菇1. dim�ɂ�鑽�ϗʃf�[�^�̍s���񐔂̊m�F
colnames(jhk) #�菇2. colnames�ɂ��ϐ����̊m�F
head(jhk,3) #�菇3. head�ɂ��ŏ���3�s�̕\��

#�q�X�g�O�����̕`��
library(lattice)#�p�b�P�[�Wlattice�̓ǂݍ���
histogram(~�X�g���X,data=jhk,breaks=20,type="count")

#��\�l�̎Z�o
mean(jhk$�X�g���X) #�X�g���X�̕��ϒl
median(jhk$�X�g���X) #�X�g���X�̒����l�@
sort(table(jhk$�N��)) #�N��̍ŕp�l

#�U�z�x�̎Z�o
sd(jhk$�X�g���X) #�X�g���X��SD
var(jhk$�X�g���X) #�X�g���X�̕��U

#�����l����̕��ϕ΍��̎Z�o
mean(abs(jhk$�X�g���X-median(jhk$�X�g���X)))

#�Q�ʂɃq�X�g�O������`��
histogram(~������|�N��+����,data=jhk,breaks=15)

#�Q�Ԃł̕��z��r
tapply(jhk$������,jhk$����,mean) #���ʖ��Ɂu�������v�̕��ϒl�����߂�
tapply(jhk$������,jhk$����,sd) #���ʖ��Ɂu�������v��SD�����߂�


#���q�Q�}�̕`��
boxplot(jhk$�Z�\,horizontal=TRUE) #�u�Z�\�v�̔��q�Q�}�����u���ɍ쐬����(horizontal=FALSE�ŏc�u��)
boxplot(������~����,data=jhk,horizontal=TRUE) #���ʖ��Ɂu�������v�̔��q�Q�}��`�悷��


#�l���ʐ����܂߂��v�񓝌v�ʂ̎Z�o
summary(jhk$�Z�\)


#�����U��F����
var.test(������~����,data=jhk)

#�Ɨ���2�Q��t����i�����U������j
t.test(������~����,data=jhk,var.equal=TRUE)

#Welch�@�ɂ��t����
t.test(������~����,data=jhk)

#�Ή��̂���t����
score <- c(jhk$����,jhk$��N����)
year <- c(rep("���N",800),rep("��N",800))
t.test(score~year,paired=TRUE)

#�Q���ƂɐM����Ԃ�`��
library(gplots)#�p�b�P�[�Wgplots�̓ǂݍ���
plotmeans(������~����,data=jhk,p=0.95,ylim=c(49,54))


#�M����Ԃ̎Z�o
t.test(jhk$������[jhk$����=="F"])
t.test(jhk$������[jhk$����=="M"])


#��(�ϐ��ɑ΂����b�W�v)
varname <- c("������","���Ȏ咣","�Z�\","�m��")
jhk2 <- jhk[,varname] #�f�[�^�t���[������4�ϐ��𒊏o����
apply(jhk2,2,mean) #�ϐ��ʂɕ��ϒl�����߂�
apply(jhk2,2,sd) #�ϐ��ʂ�SD�����߂�

#�s(�ϑ��Ώۂɑ΂����b�W�v)
apply(jhk2,1,sum) #�Ј�����4�ϐ��̍��v�_�����߂�
apply(jhk2,1,sd) #�Ј�����4�ϐ���SD�����߂�
#���ϐ��̕��z���Q�ԂŔ�r
by(jhk2,jhk$����,apply,2,mean) #4�ϐ��̕��ς̎Z�o
by(jhk2,jhk$����,apply,2,sd) #4�ϐ���SD�̎Z�o

#�W�����̎葱��
zscore <- scale(jhk2) #z���_�̎Z�o
head(zscore,2)
tscore <- zscore*10 + 50 #�΍��l�̎Z�o
head(tscore,2)

#�U�z�}�̕`��
gino <- jhk$�Z�\
chisiki <- jhk$�m��
plot(gino,chisiki,xlab="�Z�\",ylab="�m��")

#�U�z�}�s��̕`��
kjs <- c("������","���Ȏ咣","�X�g���X")
plot(jhk[,kjs])

#�w�ʎU�z�}�̕`��
library(lattice)�@#�p�b�P�[�Wlattice�̓ǂݍ���
xyplot(�m��~�Z�\|�N��+����,data=jhk)


#���֌W���̎Z�o
cor(jhk$������,jhk$�X�g���X) #2�ϐ��Ԃ̑��֌W�������߂�

#���֍s��̎Z�o
cor(jhk[,kjs])�@#cor�ɑ��ϐ��𓊓������֍s������߂�

#�����U�s��̎Z�o
cov(jhk[,kjs])

#���֌W���̌���
library(psych)�@#�p�b�P�[�Wpsych�̃C���X�g�[��
corkekka <- corr.test(jhk[,kjs])�@
corkekka$t #t�l�̎Z�o
corkekka$p #p�l�̎Z�o


#�N���X�W�v�\�̍쐬
(cross <- table(jhk$����,jhk$�N��))


#�N���X�W�v�\�������\�L
prop.table(cross)�@#�S�x������ɂ��������\�L
prop.table(cross,1)�@#�s�����̊����\�L
prop.table(cross,2)�@#������̊����\�L


#�w�ʃN���X�W�v�\�̍쐬
xtabs(~����+�N��+����,data=jhk)


#�A�֌W���̎Z�o
library(vcd)�@#�p�b�P�[�Wvcd�̓ǂݍ���
assocstats(cross)�@#�����ƔN��̘A�֌W���̎Z�o

#�N���X�W�v�\�ƘA�֌W���̊֌W
(m1 <- matrix(c(50,0,0,50),ncol=2))�@#���S�A�ւ̃P�[�X
assocstats(m1)�@#���S�A�ւ̃N���X�W�v�\�ɂ�����A�֌W��
(m2 <- matrix(c(10,20,100,200),ncol=2))�@#�Ɨ��̃P�[�X
assocstats(m2)�@#�Ɨ������N���X�W�v�\�ɂ�����A�֌W��


#�N���X�W�v�\�ɑ΂���J�C��挟��
(reschisq <- chisq.test(cross))

#�c������
reschisq$stdres


#�Α��֌W���̎Z�o
sixname <- c("������","���Ȏ咣","�Z�\","�m��","����","��N����")
jhk3 <- jhk[,sixname]
cor(jhk3[,5],jhk3[,6]) #�����C��N�����̑��֌W�������߂�
partial.r(jhk3,c(5,6),c(1,2,3,4)) #�������C���Ȏ咣�C�Z�\�C�m���𓝐������Α��֌W�������߂�


#�����J�e�S���J���ϐ����܂߂��f�[�^�t���[���̍쐬
(sogoc <- c(-Inf,mean(jhk$����),Inf))�@#2�l�J�e�S���J���ϐ������邽�߂̊K�������쐬����
(scat <- cut(jhk$����,breaks=sogoc,right=FALSE,labels=c(0,1))) #�K�����𗘗p���ăf�[�^��0��1�ɕϊ�����
(ginoc <- c(-Inf,summary(jhk$�Z�\)[c(2,5)],Inf))�@#���l�J�e�S���J���ϐ������邽�߂̊K�������쐬����
(gcat <- cut(jhk$�Z�\,breaks=ginoc,right=FALSE,labels=c(0,1,2)))�@#�K�����𗘗p���ăf�[�^��0��1��2�ɕϊ�����

#�����J�e�S���J���ϐ����܂߂����֍s��̎Z�o
library(polycor)�@#�p�b�P�[�Wpolycor�̓ǂݍ���
jhk4 <- data.frame(�����J�e=scat,�Z�\�J�e=gcat,�m��=jhk$�m��)�@#�ʓI�ϐ��u��N�����v���܂߂ăf�[�^�t���[�����쐬����
hetcor(jhk4,ML=TRUE) #�Ŗޖ@�ő��֍s��̎Z�o


#�֐�effectd1�̓ǂݍ���
effectd1 <- function(x1,x2,clevel=0.95)
{
    library(MBESS)
    #�e�Q�̕W�{�T�C�Y�̎Z�o
    n1 <- length(x1);n2 <- length(x2)
    #�e�Q�̕��ς̎Z�o
    m1 <- mean(x1);m2 <- mean(x2)
    #�e�Q�̕W�{�W���΍��̎Z�o
    s1 <- sqrt(mean((x1-m1)^2))
    s2 <- sqrt(mean((x2-m2)^2))
    #��W���΍��̐���l�̎Z�o
    sast <- sqrt(((n1*s1^2)+(n2*s2^2))/(n1+n2-2))
    #���ʗʂ̎Z�o
    d <- (m1-m2)/sast
    #�Ɨ�����2�Q�̂�����̎��s(�����U����)�Ǝ��R�x�̎Z�o
    rest <- t.test(x1,x2,paired=FALSE,var.equal=TRUE)
    #���ʗʂ̐M����Ԃ̎Z�o
    resconf <- conf.limits.nct(t.value=rest$statistic,
    df=rest$parameter,conf.level=clevel)
    ll <- resconf$Lower.Limit*sqrt((n1+n2)/(n1*n2))
    ul <- resconf$Upper.Limit*sqrt((n1+n2)/(n1*n2))
    u3 <- pnorm(d,0,1)
    return(list=c(���ʗ�=d,�M������=clevel,��ԉ���=ll,
    ��ԏ��=ul,U3=u3))
}

#�Ɨ��ȂQ�Q��t����ɑΉ��������ʗʂ̎Z�o
#���O�Ɋ֐�effectd1��R�ɓǂݍ���ł���
fdat <- jhk$������[jhk$����=="F"]
mdat <- jhk$������[jhk$����=="M"]
effectd1(fdat, mdat, clevel=0.95)

#�֐�effectd2�̓ǂ݂���
#�{�֐��͌����l�ɂ͑Ή����Ă��܂���B
effectd2 <- function(x1,x2,clevel=0.95)
{
	library(MBESS)
	#�W�{�T�C�Y�̎Z�o
	n <- length(x1-x2)
    #���ق̕���v.bar�̎Z�o
    v.bar <- mean(x1-x2)
    #���ق̕s�Ε��U�̕�����sv�̎Z�o
    sv.p <- sd(x1-x2)
    #���ʗʂ̎Z�o
    d.p <- v.bar/sv.p
    #�Ή��̂��邔����̎��s�Ǝ��R�x�̎Z�o
    rest <- t.test(x1,x2,paired=TRUE)
    #���ʗʂ̐M����Ԃ̎Z�o
    resconf <- conf.limits.nct(t.value=rest$statistic,
    df=rest$parameter,conf.level=clevel)
    ll <- resconf$Lower.Limit/sqrt(n)
    ul <- resconf$Upper.Limit/sqrt(n)
    u3 <- pnorm(d.p,0,1)
    return(list=c(���ʗ�=d.p,�M������=clevel,��ԉ���=ll,
    ��ԏ��=ul,U3=u3))
}

#�Ή��̂���t����ɂ�������ʗʂ̎Z�o
effectd2(jhk$����,jhk$��N����,clevel=0.95)


#���֌W���̐M����Ԃ̎Z�o
corkekka2 <- corr.test(jhk[,kjs],alpha=0.05) 
print(corkekka2,short=FALSE)


effectv <- function(x,y,clevel=0.95)
{
    library(vcd)
    library(MBESS)
    #�N���X�W�v�\�̎Z�o
    tmpcross <- table(x,y)
    #�W�{�T�C�Y�̎Z�o
    n <- sum(tmpcross)
    #�W�v�\�̍s���Ɨ񐔂��Z�o
    size <- dim(tmpcross)
    #���R�x���Z�o
    dof <- prod(size-1)	
    #�J�C���l�ƃN�����[��V�̎Z�o
    resas <- assocstats(tmpcross)
    chi <- resas$chisq_tests["Pearson","X^2"]	
    v <- resas$cramer
    #�J�C���l�����^�Ƃ����Ƃ��̔�S�x�̏���l�C�����l���Z�o
    resconf <- conf.limits.nc.chisq(Chi.Square=chi,
    df=dof,conf.level=clevel)
    
    if(resconf$Lower.Limit>0)#�����l��L���𒴂���̈�ɓ������ꍇ
    {
        #�M����Ԃ̉����E����̎Z�o  
        ll <- sqrt((dof+resconf$Lower.Limit)/((min(size)-1)*n))
        ul <- sqrt((dof+resconf$Upper.Limit)/((min(size)-1)*n))
        return(list=c(���ʗ�V=v,�J�C���l=chi,�M������=clevel,
        ��ԉ���=ll,��ԏ��=ul))
    }else if(resconf$Lower.Limit==0) #�����l��l�����l�ɂȂ����ꍇ
    {
        #�M����Ԃ̉�����0�ɐ��񂵂���ŏ�����Z�o       
        resconf <- conf.limits.nc.chisq(Chi.Square=chi,
        df=dof,conf.level=NULL,alpha.lower=0,alpha.upper=(1-clevel)/2)
        ul <- sqrt((dof+resconf$Upper.Limit)/((min(size)-1)*n))
        return(list=list(
        "�����l��L�����l�ɂȂ����̂ŐM����Ԃ̉����l��0�ɂ��܂����B",
        c(���ʗ�V=v,�J�C���l=chi,�M������=clevel,��ԉ���=0,
        ��ԏ��=ul)))
    }
}

#�N�����[��V�ɑ΂���M����Ԃ̎Z�o
effectv(jhk$�N��,jhk$����,clevel=.95)


#���K�Ɖ�
#��1��
mat <- read.csv("�w�͒�������.csv")
library(lattice)
histogram(~�v�����_|����,data=mat)
boxplot(�v�����_~����,data=mat,horizontal=TRUE)

#��2��
tapply(mat$�v�����_,mat$����,mean)
tapply(mat$�v�����_,mat$����,median)
tapply(mat$�v�����_,mat$����,sd)

#��3��
m <- mat$���w[mat$����=="M"]
f <- mat$���w[mat$����=="F"]
t.test(m,f,var.equal=TRUE)
effectd1(m,f,clevel=0.95)

#��4��
goukei <- apply(mat[,c("�v�����_","�|�X�g���_")],1,sum)

#��5��
spre1 <- scale(mat$�v�����_)
plot(mat$�v�����_,spre1)
cor(mat$�v�����_,spre1)

#��6��
library(psych)
matc <- mat[,c("�v�����_","�|�X�g���_","����","�Љ�","�p��")]
partial.r(matc,c(3:5),c(1:2))

#��7��
library(polycor)
kcat <- cut(mat$����,breaks=c(-Inf,mean(mat$����),Inf),right=FALSE,labels=c(0,1))
scat <- cut(mat$�Љ�,breaks=c(-Inf,mean(mat$�Љ�),Inf),right=FALSE,labels=c(0,1))
ecat <- cut(mat$�p��,breaks=c(-Inf,mean(mat$�p��),Inf),right=FALSE,labels=c(0,1))
mat2 <- data.frame(kcat,scat,ecat)
hetcor(mat2,ML=TRUE)

#��8��
effectv(mat$����,mat$����,clevel=0.95)
