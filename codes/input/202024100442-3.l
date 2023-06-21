%{
    #include <string.h>
    //����
    int lineNum = 1;
    int wordsCnt = 0;
    //��ʶ����
    //�����Ǳ������汾��ԭ�����ﲻ��д��id[][20]�������ַ������Ƶ�ʱ������
    char id[20][20]= {""};
    int idNum = 0;
    int isIdExist(char *);
%}
emptyWords [\t\n" "]
annotation (\/\*.*\*\/)|(\/\/.*\n)
digit [0-9]
letter [a-zA-Z_]
keyWords "main"|"if"|"then"|"else"|"while"|"do"|"repeat"|"until"|"for"|"from"|"to"|"step"|"switch"|"of"|"case"|"default"|"return"|"integer"|"real"|"char"|"bool"|"and"|"not"|"mod"|"red"|"write"
id {letter}({letter}|{digit})*
integer ({digit})+
float {digit}+\.({digit}+)
operas "<="|">="|"!="|"="|"+"|"-"|"*"|"/"|"<"|">"
delimiters ","|";"|":"|"{"|"}"|"["|"]"|"("|")"

%%
{emptyWords} {//���Կհ׷�
    if(strcmp(yytext,"\n") == 0){
        //ͳ������
        lineNum++; 
    }
}
{annotation} {//����ע��
    printf("��%d�д���ע��\n",lineNum);
}
{keyWords} {//ͳ�ƹؼ��֣��ؼ��ֲ���һ�������ֱ���룬ͨ������ֵ����
    printf("<1,keyWords,'%s',->\n",yytext);wordsCnt++;
}
{id} {//ͳ�Ʊ�ʶ��
    printf("<4,id,'%s','%d'>\n",yytext,isIdExist(yytext));wordsCnt++;
}
{operas} {//ͳ�������
    printf("<2,operators,'%s',->\n",yytext);wordsCnt++;
}
{delimiters} {//ͳ�Ʒָ���
    printf("<3,delimiters,'%s',->\n",yytext);wordsCnt++;
}
{integer} {//ͳ����������
    printf("<5,num,int,'%d'>\n",atoi(yytext));wordsCnt++;
}
{float} {
    printf("<5,num,float,'%.2lf'>\n",strtod(yytext,NULL));wordsCnt++;
}
. {
    wordsCnt++;
}
%%
void main(){
    printf("========================\n");
    printf("=     LEX �ʷ�������   =\n");
    printf("========================\n");
    printf("���ʷ��������ʽ:<�����ֱ�(����),���ʷ��ŵ�����>\n");
    printf("�����ֱ�\n");
    printf("========================\n");
    printf("=      1.keyWords      =\n");
    printf("=      2.operators     =\n");
    printf("=      3.delimiters    =\n");
    printf("=      4.id            =\n");
    printf("=      5.num           =\n");
    printf("========================\n");
    printf("�������ļ���:");
    char fileName[30];
    scanf("%s",fileName);
    //strcpy(fileName,"Quick_Sort.txt");
    yyin = fopen(fileName,"r");
    if(yyin == NULL){
        printf("�ļ�%s��ʧ�ܣ�\n",fileName);return;
    }
    yylex();
    fclose(yyin);
    printf("=========================\n");
    printf("�����ļ���Ϣͳ��:\n");
    printf("�����ļ���:%s\n",fileName);
    printf("�ļ�������%d\n",lineNum);
    printf("�ļ��������������հ׷���:%d\n",wordsCnt);
    printf("=========================\n");
    system("pause");
}
int yywrap() 
{ 
  return 1; 
}
int isIdExist(char *token){
    for(int i = 0; i < idNum; i++){
        if(strcmp(id[i],token) == 0){
            return i;
        }
    }
    //�Լ�д���ַ�������
    // for(int i = 0; token[i] != 0; i++){
    //     id[idNum][i] = token[i];
    //     id[idNum][i+1] = '\0';
    // }
    strcpy(id[idNum],token);
    idNum++;
    return idNum-1;
}