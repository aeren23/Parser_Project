%union Nedir?
Bison’da yylval’in tutabileceği veri tiplerini tanımlamak için union kullanılır.

C’de union:

Aynı bellek alanını paylaşan ama farklı türde veri tutabilen yapı

Biz de burada diyoruz ki:
“Benim parser’ımda yylval bazen int, bazen char* olabilir.”


%union {
  int ival;         ival → sayılar ve boolean’lar için
  char* sval;       sval → identifier ve stringler için
}
//parser.y de kullandık

yylval	Flex’ten yakalanan değeri parser’a taşır
%union	yylval’in hangi tipte veri tutabileceğini Bison’a söyler
%token <tip>	Hangi token’ın hangi union üyesini kullanacağını belirtir


