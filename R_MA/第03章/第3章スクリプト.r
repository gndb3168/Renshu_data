#�f�[�^�̓ǂݍ���
csdat <- read.csv("�ڋq�����x�f�[�^.csv")
head(csdat,3)


#�֐�lm�ɂ��d��A���͂̎��s
res1<-lm(�ڋq��~���n�����x+�ݔ������x+�X�ܖʐϖ����x+�g���[�i�[�����x,data=csdat)
summary(res1)�@

#�����ϐ��Ԃ̑��֌W��
cor(csdat$�g���[�i�[�����x,csdat$�g���[�i�[��)

#�����ϐ��Ԃ̑��ւ������ꍇ�̏d��A���͂̏o��
resm1 <- lm(�ڋq��~�g���[�i�[�����x,data=csdat)
summary(resm1)

resm2 <- lm(�ڋq��~�g���[�i�[�����x+�g���[�i�[��,data=csdat)
summary(resm2)

#VIF�̎Z�o��
library(car) #�p�b�P�[�Wcar�̓ǂݍ���
vif(resm2) #�֐�vif�ɂ��VIF�̎Z�o


#�ڋq�����x��4�ϐ��Ɋւ���VIF�̎Z�o
vif(res1)

#�ؕЂƕΉ�A�W���̐M����Ԃ̎Z�o
confint(res1,level=0.95)

#�W���Ή�A�W���̎Z�o
scsdat <- as.data.frame(scale(csdat))#�f�[�^�̕W�����ƃf�[�^�t���[����
res2 <- lm(�ڋq��~���n�����x+�g���[�i�[��,data=scsdat)#�W���Ή�A�W���̐���

#�֐�lm�̏o�͂̈ꕔ
summary(res2)

#���I�ϐ����܂߂��d��A����
res3 <- lm(�ڋq��~���n�����x+�ݔ������x+�X�ܖʐϖ����x+�g���[�i�[�����x+�ڋq���C+������T,data=csdat)
summary(res3)�@

#AIC�̎Z�o
extractAIC(res1) #�����ϐ����ʓI�ϐ��݂̂̉�A���f��
extractAIC(res3) #�����ϐ��Ɏ��I�ϐ����܂߂���A���f��

#BIC�̎Z�o
extractAIC(res1,k=log(30))#�����ϐ����ʓI�ϐ��݂̂̉�A���f��
extractAIC(res3,k=log(30))#�����ϐ��Ɏ��I�ϐ����܂߂���A���f��

#t���z
pt(-0.6949209,25)*2  #�ؕЂ�p�l
(1- pt(3.075611,25))*2  #�ݔ������x�̕Ή�A�W����p�l


#qt�̎Z�o
qt(0.025,25) #�����m��0.025��^����qt�̎Z�o
qt(0.975,25) #�㑤�m��0.025��^����qt�̎Z�o


#�M����Ԃ̎Z�o
21.640-2.059539*7.036 #�M����Ԃ̉���
21.640+2.059539*7.036 #�M����Ԃ̏��

#���K�Ɖ�
#��1��
kamokudat <- read.csv("�Ȗړ���������.csv")
dim(kamokudat)
colnames(kamokudat)

#��2��
restest <- lm(final~t1+t2+t3+t4+t5,data=kamokudat)

#��3��
library(car)
vif(restest)

#��4��

#t4���폜����ꍇ
restest2 <- lm(final~t1+t2+t3+t5,data=kamokudat)
#t2���폜����ꍇ
restest2 <- lm(final~t1+t3+t4+t5,data=kamokudat)
summary(restest2)

#��5��
confint(restest2)


#��6��
restest3 <- lm(final~t1+t2,data=kamokudat)
extractAIC(restest2)
extractAIC(restest3)

#��7��
round(cor(kamokudat),2)
