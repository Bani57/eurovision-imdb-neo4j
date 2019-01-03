normalize<-function(x)
{
  return ((x-min(x))/(max(x)-min(x)))
}
find_outliers<-function(x)
{
  q1=quantile(x,0.25)
  q3=quantile(x,0.75)
  iqr=q3-q1
  return(c(which(x<q1-1.5*iqr),which(x>q3+1.5*iqr)))
}
z.test.ednakvost<-function(X,Y,isti=T,tip="dvostran",alfa)
{
  n=length(X)
  m=length(Y)
  if(n>=30&m>=30)
  {
    Sx=sd(X)
    Sy=sd(Y)
    Sp=sqrt(((n-1)*Sx^2+(m-1)*Sy^2)/(n+m-2))
    if(isti==F) Z=(mean(X)-mean(Y))/sqrt((Sx^2)/n+(Sy^2)/m)
    else Z=(mean(X)-mean(Y))/(Sp*sqrt(1/n+1/m))
    print(paste('Тест статистиката: ',Z))
    if(tip=="dvostran")
    {
      zalfa=qnorm(1-alfa/2)
      C=c(-zalfa,zalfa)
      print(paste('Критичниот домен: (',-Inf,',',C[1],')U(',C[2],',',Inf,')'))
      if(Z<C[1]|Z>C[2]) print(paste('Тест статистиката припаѓа во критичниот домен, се отфрла нултата хипотеза! Очекувањата не се еднакви!'))
      else print(paste('Тест статистиката не припаѓа во критичниот домен, се прифаќа нултата хипотеза! Очекувањата се еднакви!'))
    }
    else if(tip=="ednostran.pomalo")
    {
      zalfa=qnorm(1-alfa)
      C=-zalfa
      print(paste('Критичниот домен: (',-Inf,',',C,')'))
      if(Z<C) print(paste('Тест статистиката припаѓа во критичниот домен, се отфрла нултата хипотеза! Математичкото очекување на првата променлива е помало од очекувањето на втората променлива!'))
      else print(paste('Тест статистиката не припаѓа во критичниот домен, се прифаќа нултата хипотеза! Очекувањата се еднакви!'))
    }
    else if(tip=="ednostran.pogolemo")
    {
      zalfa=qnorm(1-alfa)
      C=zalfa
      print(paste('Критичниот домен: (',C,',',Inf,')'))
      if(Z>C) print(paste('Тест статистиката припаѓа во критичниот домен, се отфрла нултата хипотеза! Математичкото очекување на првата променлива е поголемо од очекувањето на втората променлива!'))
      else print(paste('Тест статистиката не припаѓа во критичниот домен, се прифаќа нултата хипотеза! Очекувањата се еднакви!'))
    }
    else print('Невалиден тип на тест!')
  }
  else print('Дисперзиите не се познати и примероците се многу мали, не може да се користи z-тест!')
}
t.test.ednakvost<-function(X,Y,isti=TRUE,tip="dvostran",alfa)
{
  n=length(X)
  m=length(Y)
  if(n>=30&m>=30) print('Дисперзиите не се познати но примероците се доволно големи, не мора да се користи t-тест.')
  Sx=sd(X)
  Sy=sd(Y)
  Sp=sqrt(((n-1)*Sx^2+(m-1)*Sy^2)/(n+m-2))
  if(isti==FALSE) T=(mean(X)-mean(Y))/sqrt((Sx^2)/n+(Sy^2)/m)
  else T=(mean(X)-mean(Y))/(Sp*sqrt(1/n+1/m))
  print(paste('Тест статистиката: ',T))
  if(tip=="dvostran")
  {
    talfa=qt(1-alfa/2,n+m-2)
    C=c(-talfa,talfa)
    print(paste('Критичниот домен: (',-Inf,',',C[1],')U(',C[2],',',Inf,')'))
    if(T<C[1]|T>C[2]) print(paste('Тест статистиката припаѓа во критичниот домен, се отфрла нултата хипотеза! Очекувањата не се еднакви!'))
    else print(paste('Тест статистиката не припаѓа во критичниот домен, се прифаќа нултата хипотеза! Очекувањата се еднакви!'))
  }
  else if(tip=="ednostran.pomalo")
  {
    talfa=qt(1-alfa,n+m-2)
    C=-talfa
    print(paste('Критичниот домен: (',-Inf,',',C,')'))
    if(T<C) print(paste('Тест статистиката припаѓа во критичниот домен, се отфрла нултата хипотеза! Математичкото очекување на првата променлива е помало од очекувањето на втората променлива!'))
    else print(paste('Тест статистиката не припаѓа во критичниот домен, се прифаќа нултата хипотеза! Очекувањата се еднакви!'))
  }
  else if(tip=="ednostran.pogolemo")
  {
    talfa=qt(1-alfa,n+m-2)
    C=talfa
    print(paste('Критичниот домен: (',C,',',Inf,')'))
    if(T>C) print(paste('Тест статистиката припаѓа во критичниот домен, се отфрла нултата хипотеза! Математичкото очекување на првата променлива е поголемо од очекувањето на втората променлива!'))
    else print(paste('Тест статистиката не припаѓа во критичниот домен, се прифаќа нултата хипотеза! Очекувањата се еднакви!'))
  }
  else print('Невалиден тип на тест!')
}

f.test<-function(X,Y,tip="dvostran",alfa)
{
  n=length(X)
  m=length(Y)
  Sx=sd(X)
  Sy=sd(Y)
  F=(Sx^2)/(Sy^2)
  print(paste('Тест статистиката: ',F))
  if(tip=="dvostran")
  {
    falfa1=qf(1-alfa/2,n-1,m-1)
    falfa2=qf(alfa/2,n-1,m-1)
    C=c(falfa2,falfa1)
    print(paste('Критичниот домен: (',-Inf,',',C[1],')U(',C[2],',',Inf,')'))
    if(F<C[1]|F>C[2]) print(paste('Тест статистиката припаѓа во критичниот домен, се отфрла нултата хипотеза! Дисперзиите не се еднакви!'))
    else print(paste('Тест статистиката не припаѓа во критичниот домен, се прифаќа нултата хипотеза! Дисперзиите се еднакви!'))
  }
  else if(tip=="ednostran.pomalo")
  {
    falfa=qf(alfa,n-1,m-1)
    C=falfa
    print(paste('Критичниот домен: (',-Inf,',',C,')'))
    if(F<C) print(paste('Тест статистиката припаѓа во критичниот домен, се отфрла нултата хипотеза! Дисперзијата на првата променлива е помала од дисперзијата на втората променлива!'))
    else print(paste('Тест статистиката не припаѓа во критичниот домен, се прифаќа нултата хипотеза! Дисперзиите се еднакви!'))
  }
  else if(tip=="ednostran.pogolemo")
  {
    falfa=qf(1-alfa,n-1,m-1)
    C=falfa
    print(paste('Критичниот домен: (',C,',',Inf,')'))
    if(F>C) print(paste('Тест статистиката припаѓа во критичниот домен, се отфрла нултата хипотеза! Дисперзијата на првата променлива е поголема од дисперзијата на втората променлива!'))
    else print(paste('Тест статистиката не припаѓа во критичниот домен, се прифаќа нултата хипотеза! Дисперзиите се еднакви!'))
  }
  else print('Невалиден тип на тест!')
}
compare<-function(X,Y,name,group1,group2)
{
  print(paste("Споредба на ",name," кај ",group1," и ",group2))
  n1=length(X)
  n2=length(Y)
  m1=mean(X)
  m2=mean(Y)
  S1=sd(X)
  S2=sd(Y)
  boxplot(X,Y,main=paste('Boxplot за ',name),names=c(group1,group2),varwidth=TRUE,col=5)
  print(paste('Стандардни девијации на примероците: ',S1,', ',S2))
  if(S1<S2){
    f.test(X,Y,tip="ednostran.pomalo",alfa=0.01)
    p=var.test(X,Y,alternative="less",conf.level=0.99)$p.value
  } else {
    f.test(X,Y,tip="ednostran.pogolemo",alfa=0.01)
    p=var.test(X,Y,alternative="greater",conf.level=0.99)$p.value }
  print(paste('p - вредноста: ', p))
  dali_isti=p>0.01
  print(paste('Просеци на примероците: ',m1,', ',m2))
  if(m1<m2){
    if(n1>=30&n2>=30){
      z.test.ednakvost(X,Y,tip="ednostran.pomalo",alfa=0.01,isti=dali_isti)
    } else t.test.ednakvost(X,Y,tip="ednostran.pomalo",alfa=0.01,isti=dali_isti)
    print(paste('p - вредноста: ',t.test(X,Y,alternative="less",conf.level=0.99,var.equal=dali_isti)$p.value))
  } else {
    if(n1>=30&n2>=30){
      z.test.ednakvost(X,Y,tip="ednostran.pogolemo",alfa=0.01,isti=dali_isti)
    } else t.test.ednakvost(X,Y,tip="ednostran.pogolemo",alfa=0.01,isti=dali_isti)
    print(paste('p - вредноста: ',t.test(X,Y,alternative="greater",conf.level=0.99,var.equal=dali_isti)$p.value)) }
}

library(readxl)
measurements <- read_excel("Measurements.xlsx", sheet = "Total by everyone", range = "C4:L7", col_names = FALSE)
measurements=as.data.frame(t(measurements),row.names = FALSE)
colnames(measurements)=c("Neo4j-IMDB","Neo4j-Eurovision","MySQL-IMDB","MySQL-Eurovision")

neo4j_imdb=measurements$`Neo4j-IMDB`[-find_outliers(measurements$`Neo4j-IMDB`)]
neo4j_eurovision=measurements$`Neo4j-Eurovision`[-find_outliers(measurements$`Neo4j-Eurovision`)]
mysql_imdb=measurements$`MySQL-IMDB`
mysql_eurovision=measurements$`MySQL-Eurovision`[-find_outliers(measurements$`MySQL-Eurovision`)]

compare(neo4j_imdb,mysql_imdb,"време на извршување на прашалниците од IMDB","Neo4j","MySQL")
compare(neo4j_eurovision,mysql_eurovision,"време на извршување на прашалниците од Eurovision","Neo4j","MySQL")