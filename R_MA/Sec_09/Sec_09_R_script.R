#�f�[�^�̓ǂݍ��݁C�f�[�^�t���[���̊m�F
sws <- read.csv("�K������.csv") #�f�[�^�̓ǂݍ���
head(sws)

#���f���̋L�q�i�W���̌Œ�j
sws.model1 <- "
f1 =~ 1 * E1 + E2 + E3
f2 =~ 1 * R1 + R2 + R3
f3 =~ 1 * M1 + M2 + M3
f4 =~ 1 * H1 + H2 + H3
f3 ~ f1 + f2
f4 ~ f1 + f2 +f3
f1 ~~ f2
"
#���f���̋L�q�i���U�̌Œ�j
sws.model2 <- "
f1 =~ E1 + E2 + E3
f2 =~ R1 + R2 + R3
f3 =~ 1 * M1 + M2 + M3
f4 =~ 1 * H1 + H2 + H3
f3 ~ f1 + f2
f4 ~ f1 + f2 + f3
f1 ~~ 1 * f1 + f2
f2 ~~ 1 * f2
"

#���f���̐���
library(lavaan)
sws.fit <- lavaan(model = sws.model1, data = sws, auto.var = TRUE) #auto.var-�O���ϐ��̕��U�𐄒�ΏۂƂ���iTRUE�j,���Ȃ��iFALSE�j
# sws.fit<-lavaan(model = sws.model1, sample.cov = cov(sws), sample.nobs = nrow(sws), auto.var = TRUE) #�W�{�����U�s��ƃT���v���T�C�Y���w�肵�Đ���

#���ʂ̏o��
summary(sws.fit, fit.measures = TRUE, standardized = TRUE, ci = TRUE) #fit.measures-�K���x, standardizes-�W��������l, ci-95%�M����Ԃ��o�͂���iTRUE�j

#���ׂĂ̓K���x�w�W���o��
fitmeasures(sws.fit)

#���f���K���Ɋւ��镔���I�]���̎w�W�i�c���s��j
residuals(sws.fit, type = "cor")

#���f���K���Ɋւ��镔���I�]���̎w�W�i�C���w�W�j
modindices(sws.fit)

#���U�������̏o��
lavInspect(sws.fit, "rsquare")

#����l�t�p�X�}�̕`��
library(semPlot)
semPaths(sws.fit, whatLabels = "std", layout = "tree2", curve = 1.2, #whatLabels-�p�X�ɕt�^���鐔�l�̎��, layout-�p�X�}�̌`��, curve-���������̋Ȃ���̒��x
	optimizeLatRes = TRUE, edge.color = "black", nCharNodes = 0, #optimizeLatRes-���ݕϐ��Ɏh����덷�̊p�x�𒲐�����, edge.color-���̐F, nCharNodes-�}�`���ɕ\�����镶����
	edge.label.position = c(rep(0.4, 17), rep(0.5, 18)), edge.label.cex = 0.8)#edge.label.position-����̐��l�\���ʒu�i�ꐔ�̐��̕������w�肷��B�����U�͓���J�E���g�����j

#���f���̋L�q�i�ꐔ�̊֐��̒�`���܂ށj
sws.model3<-"
f1 =~ 1 * E1 + E2 + E3
f2 =~ 1 * R1 + R2 + R3
f3 =~ 1 * M1 + M2 + M3
f4 =~ 1 * H1 + H2 + H3
f3 ~ f1 + a * f2
f4 ~ f1 + b * f2 +c * f3
f1 ~~ f2
DRE  := b
IDRE := a * c
TTE  := b + a * c
"
sws.fit <- lavaan(model = sws.model3, data = sws, auto.var = TRUE)
summary(sws.fit, fit.measures = TRUE, standardized = TRUE, ci = TRUE)


#���K�Ɖ�

#��3�𓚁i��j
sws <- read.csv("�K������.csv")
sws.model<-"
f1 =~ E1 + E2 + 1 * E3
f2 =~ R1 + R2 + 1 * R3
f3 =~ M1 + M2 + 1 * M3
f4 =~ H1 + H2 + 1 * H3
f1 ~ f3
f4 ~ f2 + f3
"
sws.fit <- lavaan(model = sws.model, data = sws, auto.var = TRUE)

#��4�C��5
summary(sws.fit, fit.measures = TRUE, standardized = TRUE, ci = TRUE)