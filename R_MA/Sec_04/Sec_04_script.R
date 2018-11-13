#�f�[�^�̓ǂݍ���
sts <- read.csv("�X�g���X.csv")

#�f�[�^�t���[���̊m�F
head(sts)

#�֐�lm�ɂ��d��A���͂̎��s�i�X�e�b�v1�j
res1 <- lm(�o�[���A�E�g2~�o�[���A�E�g1, data=sts)
summary(res1)

#�֐�lm�ɂ��d��A���͂̎��s�i�X�e�b�v2�j
res2 <- lm(�o�[���A�E�g2~�o�[���A�E�g1+�X�g���X+�T�|�[�g, data=sts)
summary(res2)

#F�l�̎Z�o
((0.4168-0.4039)/(3-1))/((1-0.4168)/(300-3-1))

#p�l�̎Z�o
1-pf(3.273663, 2, 296)

#����W���̑����̌���
anova(res1, res2)

#AIC�̎Z�o
extractAIC(res1) #�X�e�b�v1�̉�A���f����AIC
extractAIC(res2) #�X�e�b�v2�̉�A���f����AIC

#BIC�̎Z�o
extractAIC(res1, k=log(300)) #�X�e�b�v1�̉�A���f����BIC
extractAIC(res2, k=log(300)) #�X�e�b�v2�̉�A���f����BIC

#���S��
sts$�X�g���X.c <- sts$�X�g���X-mean(sts$�X�g���X) #�u�X�g���X�v�̒��S��
sts$�T�|�[�g.c <- sts$�T�|�[�g-mean(sts$�T�|�[�g) #�u�T�|�[�g�v�̒��S��

#���ݍ�p���̍쐬
sts$���ݍ�p <- sts$�X�g���X*sts$�T�|�[�g #���S��������O�̌��ݍ�p��
sts$���ݍ�p.c <- sts$�X�g���X.c*sts$�T�|�[�g.c #���S����������̌��ݍ�p��

#���֌W���̊m�F
cor(sts[,c("�X�g���X", "�T�|�[�g", "���ݍ�p")]) #���S���O�̑��֍s��
cor(sts[,c("�X�g���X.c", "�T�|�[�g.c", "���ݍ�p.c")]) #���S����̑��֍s��

#�u�o�[���A�E�g1�v�̒��S��
sts$�o�[���A�E�g1.c <- sts$�o�[���A�E�g1-mean(sts$�o�[���A�E�g1)

#�֐�lm�ɂ��d��A���͂̎��s�i���ݍ�p���ʂ̌����j
res3 <- lm(�o�[���A�E�g2~�o�[���A�E�g1.c+�X�g���X.c+�T�|�[�g.c+�X�g���X.c*�T�|�[�g.c, data=sts)
summary(res3)

#����W���̑����̌���
anova(res2, res3)

#�W���Ή�A�W���̎Z�o
z.sts <- as.data.frame(scale(sts)) #�f�[�^�̕W�����ƃf�[�^�t���[����
res3.z <- lm(�o�[���A�E�g2~�o�[���A�E�g1+�X�g���X+�T�|�[�g+�X�g���X*�T�|�[�g, data=z.sts) #�W���Ή�A�W���̐���
summary(res3.z) #���ʂ̏o��

#�P���X�Ε��́i�\�[�V�����E�T�|�[�g�������ꍇ�̃o�[���A�E�g�ɑ΂���X�g���X�o���̌��ʁj
sts$�T�|�[�g.h <- sts$�T�|�[�g.c-sd(sts$�T�|�[�g.c)
res3.h <- lm(�o�[���A�E�g2~�o�[���A�E�g1.c+�X�g���X.c+�T�|�[�g.h+�X�g���X.c*�T�|�[�g.h, data=sts)
summary(res3.h)

#�P���X�Ε��́i�\�[�V�����E�T�|�[�g�����Ȃ��ꍇ�̃o�[���A�E�g�ɑ΂���X�g���X�o���̌��ʁj
sts$�T�|�[�g.l <- sts$�T�|�[�g.c+sd(sts$�T�|�[�g.c)
res3.l <- lm(�o�[���A�E�g2~�o�[���A�E�g1.c+�X�g���X.c+�T�|�[�g.l+�X�g���X.c*�T�|�[�g.l, data=sts)
summary(res3.l)

#�M����Ԃ̎Z�o
confint(res3)

#�ϐ��I��
bsb <- read.csv("�싅.csv") #�f�[�^�̓ǂݍ���
head(bsb) #�f�[�^�t���[���̊m�F
library(MASS) #�p�b�P�[�WMASS�̓ǂݍ���
base <- lm(�N��~1, data=bsb) #�ؕЂ݂̂̃��f��
step.res <- stepAIC(base, direction="both", scope=list(upper=~�Ő�+����+�œ_+�{�ۑ�+�l��+����+�O�U+�ŗ�)) #�X�e�b�v���C�Y�@�ɂ��ϐ��I��
summary(step.res) #�ŏI�I�ȕϐ��I���̌���


#���K�Ɖ�
#��1��
ssk <- read.csv("����.csv")
res1 <- lm(�e�X�g����~����+�ʏm�L��+�L�\��, data=ssk)
summary(res1)
res2 <- lm(�e�X�g����~����+�ʏm�L��+�L�\��+�A�X�s���[�V����, data=ssk)
summary(res2)

#��2��
anova(res1, res2)

#��3��
extractAIC(res1)
extractAIC(res2)

#��4��
ssk$�A�X�s���[�V����.c <- ssk$�A�X�s���[�V����-mean(ssk$�A�X�s���[�V����)
res3 <- lm(�e�X�g����~����+�ʏm�L��+�L�\��+�A�X�s���[�V����.c+�ʏm�L��*�A�X�s���[�V����.c, data=ssk)
summary(res3)

#��5��
ssk$�A�X�s���[�V����.h <- ssk$�A�X�s���[�V����.c-sd(ssk$�A�X�s���[�V����.c)
res3.h <- lm(�e�X�g����~����+�ʏm�L��+�L�\��+�A�X�s���[�V����.h+�ʏm�L��*�A�X�s���[�V����.h, data=ssk)
summary(res3.h)

ssk$�A�X�s���[�V����.l <- ssk$�A�X�s���[�V����.c+sd(ssk$�A�X�s���[�V����.c)
res3.l <- lm(�e�X�g����~����+�ʏm�L��+�L�\��+�A�X�s���[�V����.l+�ʏm�L��*�A�X�s���[�V����.l, data=ssk)
summary(res3.l)


#��6��
library(MASS)
base <- lm(�e�X�g����~1, data=ssk)
step.res <- stepAIC(base, direction="both", scope=list(upper=~����+�ʏm�L��+�L�\��+�A�X�s���[�V����+�����׋�����+�x���׋�����+�j���[�X����+�Ǐ�+�O�V��))
summary(step.res)