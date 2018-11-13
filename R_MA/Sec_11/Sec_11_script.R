#�f�[�^�̓ǂݍ��݁A�J�e�S���J���ϐ��̕ϊ��A�f�[�^�t���[���̊m�F
aks <- read.csv("�󂫑�����.csv") #�f�[�^�̓ǂݍ���
aks$�󂫑�01 <- ifelse(aks$�󂫑� == "����",1,0)
aks$�Z�L�����e�B01 <- ifelse(aks$�Z�L�����e�B == "����",1,0)
aks$������01 <- ifelse(aks$������ == "����",1,0)
head(aks)

#���W�X�e�B�b�N��A���͂̎��s
aks.out <- glm(�󂫑�01 ~ �s�ݎ��� + ��b + �z�N�� + �Z�L�����e�B01 + ������01, family = "binomial", data = aks)

#���W�X�e�B�b�N��A���͂̏o�͕\��
summary(aks.out)

#�W���E�ؕЂ̎w���ϊ��l�̎Z�o�Ɖ���
exp(aks.out$coefficients)

#�W���E�ؕЂɊւ���M����Ԃ̎Z�o
confint(aks.out, level = 0.95)
exp(confint(aks.out, level = 0.95))

#�W�����W���̎Z�o
LRAstdcoef <- function(glm.out, vname){ #glm.out-�֐�glm�ɂ��o�̓I�u�W�F�N�g, vname-�W��������ʓI�Ȑ����ϐ���
	#vname�Ɏw�肳�ꂽ�ϐ��݂̂���Ȃ�f�[�^�t���[��
	subdat <- (glm.out[["data"]])[ , vname]
	#subdat�̊e�ϐ��̕W���΍�
	SDs <- apply(subdat, 2, sd)
	#�W�����O�̐���l
	rawcoef <- (glm.out[["coefficients"]])[vname]
	#�W������̐���l
	stdcoef <- rawcoef * SDs
	return(stdcoef)
}
LRAstdcoef(aks.out,c("�s�ݎ���", "��b", "�z�N��"))

#Hosmer-Lemeshow�̓K���x����
library(ResourceSelection) 
hoslem.test(x = aks.out$y, y = fitted(aks.out)) #x-�ړI�ϐ��̊ϑ��l, y-�ړI�ϐ��̗\���l�i�m���j

#AIC��BIC�̎Z�o
extractAIC(aks.out) #AIC
extractAIC(aks.out, k = log(nrow(aks.out$data))) #BIC

#�Ɨ��ϐ��Q�̗L�����̊m�F
aks.out_null <- glm(�󂫑�01~1, family = "binomial", data = aks)
anova(aks.out_null, aks.out, test="Chisq") 

#�ϐ��I���̎��s
step(aks.out_null, direction = "both", scope = ( ~ �s�ݎ��� + ��b + �z�N�� + �Z�L�����e�B01 + ������01))

#���d�������̊m�F
library(car)
vif(aks.out)


#���K�Ɖ�
#��1��
sks <- read.csv("���i����.csv")
sks$��������01 <- ifelse(sks$�������� == "���i", 1, 0)
sks$�F��01 <- ifelse(sks$�F�� == "����", 1, 0)

#��2��
sks.out <- glm(��������01 ~ �׋����� + �F��01 + �N��, family = "binomial", data = sks)
summary(sks.out)

#��3��
exp(sks.out$coefficients)

#��4��
LRAstdcoef(sks.out, c("�׋�����", "�N��")) #�O�q��LRAstdcoef�̓Ǎ��݂��K�v
exp(LRAstdcoef(sks.out, c("�׋�����", "�N��")))

#��5��
library(ResourceSelection) 
hoslem.test(x = sks.out$y, y = fitted(sks.out)) 

#��6��
library(car)
vif(sks.out)