#�f�[�^�̓ǂݍ���
dkk <- read.csv("���@�Â�.csv")

#�f�[�^�t���[���̊m�F
head(dkk)

#�ŗL�l�̎Z�o
cor.dkk <- cor(dkk) #���֍s��̎Z�o
eigen(cor.dkk) #�ŗL�l�̎Z�o

#�X�N���[�v���b�g�̏o��
library(psych) #�p�b�P�[�Wpsych�̓ǂݍ���
VSS.scree(dkk) #�X�N���[�v���b�g�̏o��

#���s����
fa.parallel(dkk, fm="ml", fa="pc", n.iter=100)

#�T���I���q���́i�������j
fa.dkk1 <- fa(dkk, nfactors=2, fm="ml", rotate="none") #�ꐔ�̐���
print(fa.dkk1, sort=TRUE, digits=3) #���ʂ̏o��

#�T���I���q���́i�������j�F���֍s����w�肵������
fa.dkk.cor <- fa(cor.dkk, nfactors=2, fm="ml", rotate="none", n.obs=500) #�ꐔ�̐���
print(fa.dkk.cor, sort=TRUE, digits=3) #���ʂ̏o��

#�T���I���q���́i�v���}�b�N�X��]�j
library(GPArotation) #�p�b�P�[�WGPArotation�̓ǂݍ���
fa.dkk2 <- fa(dkk, nfactors=2, fm="ml", rotate="promax") #�ꐔ�̐���
print(fa.dkk2, sort=TRUE, digits=3) #���ʂ̏o��

#���W���̎Z�o
dkk.nht <- dkk[, c("I1","I2","I3","I4")]
alpha(dkk.nht) #�����I���@�Â��ړx�̃��W��

dkk.ght <- dkk[, c("E1","E2","E3","E4")]
alpha(dkk.ght) #�O���I���@�Â��ړx�̃��W��

#�֌W���̎Z�o
omega(dkk.nht, nfactors=1) #�����I���@�Â��ړx�̃֌W��

omega(dkk.ght, nfactors=1) #�O���I���@�Â��ړx�̃֌W��


#�f�[�^�̓ǂݍ���
math <- read.csv("���w�e�X�g.csv")

#�f�[�^�t���[���̊m�F
head(math)

#���q���̌���
cor.math <- polychoric(math)$rho #�|���R���b�N���֍s��̎Z�o
eigen(cor.math) #�ŗL�l�̎Z�o
VSS.scree(cor.math) #�X�N���[�v���b�g�̏o��
fa.parallel(cor.math, fm="ml", fa="pc", n.iter=100, n.obs=300) #���s����

#�T���I���q���́i1���q���j
fa.math <- fa.poly(math, nfactors=1, fm="ml") #�ꐔ�̐���
print(fa.math, sort=TRUE, digits=3) #���ʂ̏o��

#�M�����W���̎Z�o
alpha(cor.math, n.obs=300) #�A���t�@�W���̎Z�o
omega(cor.math, nfactors=1, n.obs=300) #�I���K�W���̎Z�o



#���K�Ɖ�
#��1��
skk <- read.csv("���i.csv")
cor.skk <- cor(skk)
eigen(cor.skk)

#��2��
library(psych)
VSS.scree(skk)

#��3��
fa.parallel(skk, fm="ml", fa="pc", n.iter=100)

#��4��
library(GPArotation)
fa.skk <- fa(skk, nfactors=2, fm="ml", rotate="promax")
print(fa.skk, sort=TRUE, digits=3)

#��5��
skk2 <- skk[,c("�z�C", "�ϋɓI", "�O���I", "�Ќ�I")]
alpha(skk2)

skk3 <- skk[,c("���͓I", "���a", "�f��", "�e��")]
alpha(skk3)

#��6��
omega(skk2, nfactors=1)
omega(skk3, nfactors=1)

