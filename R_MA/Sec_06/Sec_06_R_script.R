#�f�[�^�̓ǂݍ���
shp <- read.csv("���s.csv")

#�f�[�^�t���[���̊m�F
head(shp)

#���f���̋L�q
shp.model <- '
 ���s�s��~����
 �w�K�ӗ~~��܂�
 �w�Ɛ���~���s�s��+�w�K�ӗ~
'

#�ꐔ�̐���
library(lavaan) # �p�b�P�[�Wlavaan�̓ǂݍ���
shp.fit <- sem(shp.model, data=shp) #�ꐔ�̐���

#���ʂ̏o�́i�W��������l�C����W���j
summary(shp.fit, standardized=TRUE, rsquare=TRUE)

#���ʂ̏o�́i�W��������l�C����W���C�M����ԁj
summary(shp.fit, standardized=TRUE, rsquare=TRUE, ci=TRUE)

#���ʂ̏o�́i�W��������l�C����W���C�M����ԁC�K���x�w�W�j
summary(shp.fit, standardized=TRUE, rsquare=TRUE, ci=TRUE, fit.measures=TRUE)

#���ׂĂ̓K���x�w�W�̏o��
fitmeasures(shp.fit)

# �C���w�W�̏o��
modindices(shp.fit)

#�덷�ϐ��̊Ԃɑ��ւ����肵�����f���ŕ���
shp.model2 <- ' #���f���̋L�q
 ���s�s��~����
 �w�K�ӗ~~��܂�
 �w�Ɛ���~���s�s��+�w�K�ӗ~
 ���s�s��~~�w�K�ӗ~
'
shp.fit2 <- sem(shp.model2, data=shp) #�ꐔ�̐���
summary(shp.fit2, standardized=TRUE, rsquare=TRUE, ci=TRUE, fit.measures=TRUE) #���ʂ̏o��

# �W�{�����U�s������Ƃɂ�������
shp.cov <- cov(shp) #�W�{�����U�s��̎Z�o
shp.cov.fit <- sem(shp.model2, sample.cov=shp.cov, sample.nobs=500) #�ꐔ�̐���
summary(shp.cov.fit, standardized=TRUE, rsquare=TRUE, ci=TRUE, fit.measures=TRUE) #���ʂ̏o��


#���K�Ɖ�
#��1��
hyk <- read.csv("���ƕ]��.csv")
hyk.model <- '
 ����~����x+�L�p��
 �w�K�s��~����
 ����~�w�K�s��
'

#��2��
hyk.fit <- sem(hyk.model, data=hyk)

#��3��
summary(hyk.fit, standardized=TRUE, rsquare=TRUE, fit.measures=TRUE)

#��4��
modindices(hyk.fit)

#��5��
hyk.model2 <- '
 ����~����x+�L�p��
 �w�K�s��~����+����x
 ����~�w�K�s��
'
hyk.fit2 <- sem(hyk.model2, data=hyk)
summary(hyk.fit2, standardized=TRUE, rsquare=TRUE, fit.measures=TRUE)

#��6��
summary(hyk.fit2, standardized=TRUE, rsquare=TRUE, fit.measures=TRUE, ci=TRUE)


