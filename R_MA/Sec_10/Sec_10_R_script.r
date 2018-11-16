#�j���ʂ̃N���X�W�v�\�̍쐬
bdat <- read.csv("���]�ԃf�[�^.csv")#�f�[�^�̓ǂݍ���

#�N��ƃ��[�J�[�̃N���X�W�v�\
bdat$�N�� <- as.character(bdat$�N��)
tmpm <- table(bdat$�N��,bdat$���[�J�[)

mm <- matrix(bdat$�x��[1:9],ncol=3,nrow=3) #�j���ɂ�����N���X�W�v�\�̍쐬
colnames(mm) <- colnames(tmpm)
rownames(mm) <- rownames(tmpm)
mm

fm <- matrix(bdat$�x��[10:18],ncol=3,nrow=3) #�����ɂ�����N���X�W�v�\�̍쐬 
colnames(fm) <- colnames(tmpm)
rownames(fm) <- rownames(tmpm)
fm


#�֐�glm�ɂ��O�a���f���̕���
fullmodel <- glm(�x��~�N��*����*���[�J�[,data=bdat,family="poisson")

#�O�a���f���̏o��
summary(fullmodel)

#�֐�glm�ɂ��Ɨ����f���̕���
idmodel <- glm(�x��~�N��+����+���[�J�[,data=bdat,family="poisson")

#�Ɨ����f���̏o��
summary(idmodel)

#�Ɨ����f���̕��U���͕\
anova(idmodel,fullmodel,test="Chisq")

#�O�a���f���ƓƗ����f����AIC��BIC
extractAIC(fullmodel) #�O�a���f��AIC
extractAIC(idmodel) #�Ɨ����f��AIC
extractAIC(fullmodel,k=log(sum(bdat$�x��))) #�O�a���f��BIC
extractAIC(idmodel,k=log(sum(bdat$�x��))) #�Ɨ����f��BIC

#�֐�glm�ɂ���ă��f���̕���
bestmodel <- glm(�x��~�N��+����+���[�J�[+(�N��:����)+(�N��:���[�J�[),data=bdat,family="poisson")

#�֐�glm�ɂ���ă��f���̏o��
summary(bestmodel)

#�O�a���f���ƒ�ă��f���̖ޓx�䌟��
anova(bestmodel,fullmodel,test="Chisq")


#�ŗǃ��f���̊��ғx���s��
xtabs(bestmodel$fitted.values~bdat$�N��+bdat$���[�J�[+bdat$����)



#�O�a���f���̂��Ƃł̊��ғx���s��
xtabs(fullmodel$fitted.values~bdat$�N��+bdat$���[�J�[+bdat$����)


#��Z���̐ݒ�
bdat$�N�� <-factor(bdat$�N��,levels=c("30��","20��","40��"))
bdat$���� <-factor(bdat$����,levels=c("M","F"))
bdat$���[�J�[ <-factor(bdat$���[�J�[,levels=c("�s������","�R���i�S","�f�����U"))



#���K�Ɖ�

#��1��
bdat2 <- read.csv("���]�ԃf�[�^���K1.csv") 
bdat2$�N��<- factor(bdat2$�N��,levels=c("30��","20��","40��"))
bdat2$����<-factor(bdat2$����,levels=c("M","F"))
bdat2$���[�J�[<-factor(bdat2$���[�J�[,levels=c("�`�l�b��","�J���b��","�N�H�[�N"))


#��2��
fullmodel2 <- glm(�x��~�N��*����*���[�J�[,data=bdat2,family="poisson")
indmodel2 <- glm(�x��~�N��+����+���[�J�[,data=bdat2,family="poisson")

#��3��
anova(indmodel2,fullmodel2,test="Chisq")

#��4��
summary(fullmodel2)

#��5��
xtabs(fullmodel2$fitted.values~�N��+���[�J�[+����,data=bdat2)

#��6��
(frate <- ((837/1266)/(649/442)))#�����̔䗦
(mrate <- ((744/888)/(626/432)))#�j���̔䗦
log(frate/mrate)
