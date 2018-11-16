#�f�[�^�̓ǂݍ��݁C�f�[�^�t���[���̊m�F
ks <- read.csv("9�s�s�̋C��.csv", colClasses = c(rep("factor", 6), rep("numeric", 3))) #�f�[�^�̓ǂݍ���
head(ks)

#�J�e�S���J���ϐ��̐����̊m�F
str(ks)

#�J�e�S���J���ϐ��̐����̐ݒ�
ks$�s�s <- factor(ks$�s�s, levels = c("�D�y", "���", "����", "�V��", "���É�", "���", "�L��", "����", "�ߔe"))
ks$�N <- factor(ks$�N, levels = as.character(2012:2016))
ks$�� <- factor(ks$��, levels = as.character(1:12))
ks$�� <- factor(ks$��, levels = as.character(1:31))
ks$�G�� <- factor(ks$�G��, levels = c("�t", "��", "�H", "�~"))
ks$�V�C <- factor(ks$�V�C, levels = c("����", "��", "����", "��", "����", "��", "���J", "�J", "�݂���", "��", "�����", "��"))

#�_�O���t�̕`��
library(ggplot2)
P1_0 <- ggplot(data = ks, mapping = aes(x = �V�C))
(P1_1 <- P1_0 + geom_bar())

#�_�ɑΉ�����l�𓾂�
ggplot_build(P1_1)$data[[1]]

#�_�O���t�̕`��i�s�s�őw���j
(P1_2 <- P1_1 + facet_wrap( ~ �s�s, ncol = 3))

#�_�O���t�̕`��i�s�s�ƋG�߂őw���j
(P1_3 <- P1_1 + facet_grid(�s�s ~ �G��))

#�q�X�g�O�����̕`��
P2_0 <- ggplot(data = ks,mapping = aes(x = ����))
(P2_1 <- P2_0 + geom_histogram(breaks = seq(0, 25, 0.5)))

#�q�X�g�O�����̕`��i�s�s�őw���j
(P2_2 <- P2_1 + facet_wrap( ~ �s�s, ncol = 3))

#���z�̕��ςƕs�Ε��U�Ɋ�Â��W���΍��i�s�s�őw���j
library(dplyr)
wind_MeanSD_city <- summarise(group_by(ks, �s�s), Mean = mean(����), SD = sd(����))
print(wind_MeanSD_city)

#�q�X�g�O�����̕`�您��ѕ��z�̕��ςƕs�Ε��U�Ɋ�Â��W���΍��i�s�s�ƋG�߂őw���j
(P2_3 <- P2_1 + facet_grid(�s�s ~ �G��))
wind_MeanSD_cityseason <- summarise(group_by(ks, �s�s, �G��), Mean = mean(����), SD = sd(����))
print(wind_MeanSD_cityseason, n = 50)

#�J�����̃f�[�^�t���[���̍쐬
ks_rain <- filter(ks, �V�C == "�J")

#1������12���ɂ����ẲJ�̓����̐܂���O���t�̕`��
P3_0 <- ggplot(data = ks_rain, mapping = aes(x = ��))
P3_1 <- P3_0 + geom_line(aes(group = 1), stat = "count")
(P3_2 <- P3_1 + geom_point(aes(group = 1), stat = "count"))

#1������12���ɂ����ẲJ�̓����̐܂���O���t�̕`��i�s�s�őw���j
(P3_3 <- P3_2 + facet_grid(. ~ �s�s))

#1������12���ɂ����Ă̕��ύ~���ʂ̐܂���O���t�̕`��
P3_3 <- ggplot(data = ks, mapping = aes(x = ��, y = �~����))
P3_4 <- P3_3 + stat_summary(aes(group = 1), fun.y = mean, geom = "line")
(P3_5 <- P3_4 + stat_summary(aes(group = 1), fun.y = mean, geom = "point"))

#1������12���ɂ����Ă̕��ύ~���ʂ̐܂���O���t�̕`��i�s�s�őw���j
(P3_6 <- P3_5 + facet_grid(. ~ �s�s))

#2�N���̋C���f�[�^�ɐ��`
library(tidyr)
fixname <- function(x){ #�ϐ���������̃G���R�[�f�B���O�����ɖ߂��֐�
	names(x)<-enc2native(names(x)) #�f�[�^�I�u�W�F�N�g�̕ϐ����̃G���R�[�h������
	return(x)
}
ks_temp <- 
	ks %>% 
	filter(�N == "2014" | �N == "2015") %>% #�����ɍ��v����Ώۂ̔����o��
	select(�s�s, ��, ��, �N, �G��, �C��) %>% #����̕ϐ��̎��o��
	spread(key = �N, value = �C��, sep = "") %>% #���C�h�t�H�[�}�b�g�ւ̕ύX
	rename(�C��2014 = �N2014, �C��2015 = �N2015) %>% #�ϐ����̕t������
	fixname() #�f�[�^�I�u�W�F�N�g�ɑ΂��Ċ֐�group_by��K�p����Ƃ��̃G���[�ɑΏ����邽�߂ɕK�v�iWindows OS�j

#�U�z�}�̕`��
P4_0 <- ggplot(data = ks_temp, mapping = aes(x = �C��2014, y = �C��2015))
(P4_1 <- P4_0 + geom_point())

#�U�z�}�̕`��i�s�s�őw���j
(P4_2 <- P4_1 + facet_wrap( ~ �s�s))

#�U�z�}�̕`��i�s�s�ƋG�߂őw���j
(P4_3 <- P4_1 + facet_grid(�s�s ~ �G��))

#���֌W���i�s�s�ƋG�߂őw���j
ks_temp1415 <- summarize(group_by(ks_temp, �s�s, �G��), Cor = cor(�C��2014, �C��2015))
print(ks_temp1415, n = 50)

#�h��Ԃ��ւ̕ϐ��̃}�b�s���O
P5_0 <- ggplot(data = ks, mapping = aes(x = �V�C))
(P5_1 <- P5_0 + geom_bar(aes(fill = �G��), position = "stack"))
# (P5_1 <- P5_0 + geom_bar(aes(fill = �G��), position = position_stack(reverse = TRUE))) #�t��
# (P5_1 <- P5_0 + geom_bar(aes(fill = �G��, group = factor(�G��, levels = c("�H", "�~", "�t", "��"))))) #�C�ӂ̏���
(P5_2 <- P5_0 + geom_bar(aes(fill = �G��), position = "fill"))
(P5_3 <- P5_0 + geom_bar(aes(fill = �G��), position = "dodge"))
(P5_4 <- P5_0 + geom_bar(aes(fill = �G��), position = "identity"))

#�_�̓h��Ԃ��F�̕ύX�i�}�b�s���O�ł͂Ȃ��j
 P5_0 <- ggplot(data = ks, mapping = aes(x = �V�C))
(P5_1 <- P5_0 + geom_bar(fill = "red"))

#���F�Ɛ���̃}�b�s���O
P6_0 <- ggplot(data = ks_rain, mapping = aes(x = ��))
(P6_1 <- P6_0 + geom_line(aes(group = �s�s, color = �s�s), stat="count") + geom_point(aes(group = �s�s, color = �s�s), stat = "count"))	
(P6_2 <- P6_0 + geom_line(aes(group = �s�s, color = �s�s, linetype = �s�s), stat = "count") + geom_point(aes(group = �s�s, color = �s�s), stat = "count"))	

#�_�F�Ɠ_��̃}�b�s���O
P7_0 <- ggplot(data = ks_temp,mapping = aes(x = �C��2014, y = �C��2015))
(P7_1 <- P7_0 + geom_point(aes(color = �G��, shape = �G��)))

#���Ɋւ���ݒ�
P8_0 <- ggplot(data = ks, mapping = aes(x = �V�C)) + geom_bar(aes(fill = �G��))
P8_1 <- P8_0 + scale_y_continuous(limits = c(0,6000), breaks = seq(0, 6000, 1000))
P8_2 <- P8_1 + labs(x = "�V�C�̎��", y = "�x��")
(P8_3 <- P8_2 + theme(axis.text.x = element_text(size = 15), axis.title.y = element_text(size = 20)))

#�}��Ɋւ���ݒ�
keys <- c("�t", "��", "�H", "�~")
mycolor <- c("plum", "tomato", "wheat", "lemonchiffon"); names(mycolor) <- keys
P8_4 <- P8_3 + scale_fill_manual(values = mycolor)
# P8_4<-P8_3 + scale_fill_manual(values = mycolor,limits = rev(keys)) #�}�ፀ�ڋt��
P8_5 <- P8_4 + theme(legend.position = "bottom")
P8_6 <- P8_5 + labs(fill = "�l�G")
(P8_7 <- P8_6 + guides(fill = guide_legend(nrow = 1, byrow = TRUE)))
	
#�W�v�f�[�^����̖_�O���t
ks_bar <- ks %>% 
	group_by(�G��, �V�C) %>% 
	summarise(�x�� = n()) %>% 
	complete(�G��, �V�C, fill = list(�x�� = 0)) %>% 
	as.data.frame() #���ʂ����₷���悤�Ƀf�[�^�t���[����
(P9_0 <- ggplot(ks_bar, aes(x = �V�C, y = �x��)) + geom_bar(aes(fill = �G��), stat = "identity"))

#�W�v�f�[�^����̐܂���O���t
ks_line <- ks %>% 
	group_by(��, �s�s) %>% 
	summarise(���ύ~���� = mean(�~����)) %>% 
	as.data.frame()
P9_1 <- ggplot(ks_line, aes(x = ��, y = ���ύ~����))
P9_2 <- P9_1 + geom_line(aes(group = �s�s, color = �s�s, linetype = �s�s), stat = "identity")
(P9_3 <- P9_2 + geom_point(aes(group = �s�s, color = �s�s), stat = "identity"))
	
#��������t������igeom_text�j
P10_1 <- ggplot(data = ks,mapping = aes(x = �V�C)) + geom_bar()
(P10_2 <- P10_1 + geom_text(aes(label = ..count..), stat = "count", vjust = -0.5))

#���z�̊T�`�𒲂ׂ�igeom_density�Cgeom_vline�j
ks_mean_temp <- ks %>% 
	group_by(�G��,�s�s) %>% 
	summarise(���ϋC�� = mean(�C��)) %>% 
	as.data.frame()
P10_3 <- ggplot(data = ks, mapping = aes(x = �C��)) + geom_density(aes(linetype = �G��, color = �G��))
P10_4 <- P10_3 + geom_vline(data = ks_mean_temp, aes(xintercept = ���ϋC��, color = �G��), linetype = "twodash") #linetype�̑��̎�ނ�"solid","longdash","dotted","dotdash","dashed","blank"
(P10_5 <- P10_4 + facet_wrap( ~ �s�s))

#�f�[�^�̂΂�����ڍׂɒ��ׂ�igeom_jitter�j
P10_6 <- ggplot(data = ks,mapping = aes(x = �s�s, y = ����)) + geom_jitter(aes(color = �G��, group = �G��), position = position_jitterdodge(dodge.width = 0.6), alpha = 1 / 5) #position_jitterdodge(dodge.width = 0.6)�őœ_�̂΂�������w��
(P10_7 <- P10_6 + stat_summary(aes(x = �s�s, y = ����, group = �G��), color = "white", fun.y = median, geom = "point", shape = 4, position = position_dodge(width = 0.6))) #position_dodge(width = 0.6)��dodge�̕����w��


#���K�Ɖ�
#��1��
rtks <- read.csv("6�s�s�̋C��.csv", colClasses = c(rep("factor", 6), rep("numeric", 3)))
rtks$�s�s <- factor(rtks$�s�s, levels = c("������", "����", "����", "����", "���l", "�X"))
rtks$��  <- factor(rtks$��, levels = as.character(1:12))
rtks$��  <- factor(rtks$��, levels = as.character(1:31))
rtks$�G�� <- factor(rtks$�G��, levels = c("�t", "��", "�H", "�~"))
rtks$�ߑO�V�C <- factor(rtks$�ߑO�V�C, levels = c("����", "��", "����", "��", "����", "��", "���J", "�J", "�݂���", "��", "�����", "��"))
rtks$�ߌ�V�C <- factor(rtks$�ߌ�V�C, levels = c("����", "��", "����", "��", "����", "��", "���J", "�J", "�݂���", "��", "�����", "��"))

#��2��
library(ggplot2)
ggplot(data = rtks, aes(x = �ߌ�V�C)) + geom_bar()

#��3��
ggplot(data = rtks, aes(x = �G��, group = 1)) + stat_summary(aes(y = �C��), fun.y = mean, geom = "line") + stat_summary(aes(y = �C��), fun.y = mean, geom = "point")

#��4��
library(dplyr)
rtks2 <- rtks %>% 
	group_by(�G��) %>% 
	summarise(���ϋC�� = mean(�C��)) %>% 
	as.data.frame()

#��5��
ggplot(data = rtks2, aes(x = �G��, y = ���ϋC��, group = 1)) + geom_line(stat = "identity") + geom_point(stat = "identity")

#��6��
ggplot(data = rtks, aes(x = �ߌ�V�C)) + geom_bar(aes(fill = �G��)) + facet_grid( ~ �s�s)