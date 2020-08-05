library(dplyr)
library(ggplot2)
#작업디렉토리 변경
setwd("")

#PART10.워드클라우드
#KoNLP패키지 설치 
install.packages("multilinguer")
library(multilinguer)
install_jdk()

install.packages(c("stringr", "hash", "tau", "Sejong", "RSQLite", "devtools"), type = "binary")

install.packages("remotes")
remotes::install_github("haven-jeon/KoNLP", 
                        upgrade = "never",
                        INSTALL_opts=c("--no-multiarch"))
install.packages("wordcloud")
install.packages("RColorBrewer")
install.packages("stringr")

library(multilinguer)
library(KoNLP)
library(dplyr)
library(wordcloud)
library(RColorBrewer)
library(ggplot2)
library(stringr)

useNIADic()
1
txt<- readLines("hiphop.txt")
head(txt)
#특수문제 제거 
txt<-str_replace_all(txt, "\\W", " ")
#명사추출하기
extractNoun("대한민국의 영토는 한반도와 그 부속도서로 한다")
#가사에서 명사추출
nouns <-extractNoun(txt)
nouns
#추출한 명사 list를 문자열 벡터로 변환, 단어별 빈도표 생성
wordcount <-table(unlist(nouns))
#데이터 프레임으로 변환
df_word <- as.data.frame(wordcount, stringsAsFactors = F)
#변수명 수정
df_word<- rename(df_word, word=Var1, freq=Freq)
#두 글자 이상 단어 추출
df_word <-filter(df_word, nchar(word)>=2)
top_20<-df_word %>% 
  arrange(desc(freq)) %>% 
  head(20)
top_20

#워드클라우드 만들기
#단어색상목록만들기
pal<-brewer.pal(8,"Dark2")
pal
#워드클라우드 생성
set.seed(1234)
wordcloud(words = df_word$word, 
          freq=df_word$freq, 
          min.freq = 2,
          max.words = 200,
          random.order = F,
          rot.per = .1,
          scale = c(4, 0.3),
          colors=pal)
wordcloud(words = df_word$word, 
          freq=df_word$freq, 
          min.freq = 2,
          max.words = 200,
          random.order = F,
          rot.per = .1,
          scale = c(6, 0.3),
          colors = pal)
#단어색상바꾸기
pal <- brewer.pal(9,"Blues")[5:9] 
set.seed(1234) 
wordcloud(words = df_word$word, 
          freq=df_word$freq, 
          min.freq = 2,
          max.words = 200,
          random.order = F,
          rot.per = .1,
          scale = c(4, 0.3),
          colors = pal)
#10-2_국정원텍스트마이닝
#데이터로드
twitter<- read.csv("twitter.csv", header=T, stringsAsFactors = F, fileEncoding = "UTF-8")
#변수명수정
twitter <-rename(twitter, no=번호, id=계정이름, date=작성일, tw=내용)
#특수문자 제거
twitter$tw <-str_replace_all(twitter$tw, "\\W", " ")
head(twitter$tw)
#트윗에서 명사추출
nouns<-extractNoun(twitter$tw)
#추출한 명사 list를 문자열 벡터로 변환, 단어별 빈도표 생성
wordcount <-table(unlist(nouns))
#데이터 프레임 변환
df_word <-as.data.frame(wordcount, stringsAsFactors = F)
#변수명 수정
df_word <-rename(df_word, word=Var1, freq=Freq)
#두 글자 이상 단어만 추출
df_word <-filter(df_word, nchar(word)>=2)
#상위 20개 추출
top20 <-df_word %>% arrange(desc(freq)) %>% head(20)
top20
#단어 빈도 막대 그래프 만들기
library(ggplot2)
order<-arrange(top20, freq)$word
ggplot(data=top20, aes(x=word, y=freq))+
  ylim(0,2500)+
  geom_col()+
  coord_flip()+
  scale_x_discrete(limit=order)+
  geom_text(aes(label=freq), hjust=-0.3)
#워드클라우드 만들기
pal<-brewer.pal(8,"Dark2")
set.seed(1234)
wordcloud(words = df_word$word,
          freq = df_word$freq,
          min.freq = 10,
          max.words = 200, 
          random.order = F,
          rot.per = .1,
          scale = c(6, 0.2),
          colors = pal)
#색깔바꾸기
pal <- brewer.pal(9,"Blues")[5:9]
set.seed(1234) 
wordcloud(words = df_word$word, 
          freq = df_word$freq, 
          min.freq = 10, 
          max.words = 200, 
          random.order = F, 
          rot.per = .1, 
          scale = c(6, 0.2), 
          colors = pal)
