# ТАФЯ бонус
7 задание [8 баллов]\
2 ДКА заданы в виде таблицы переходов.
Напишите программу, которая считает эти таблицы из файла и определит,
являются ли эти автоматы эквивалентными. Алгоритм решения этой задачи можно где-нибудь найти.\
a.txt - входной автомат\
b.txt - входной автомат\
Структура файла:
<pre>
      a     b     c
->(A)   AB    -     Z
  (AB)  ABZ   -     Z
  (Z)   -     Z     B
  (ABZ) ABZ   Z     BZ
  B     AZ    -     -
  (BZ)  AZ    Z     B
  (AZ)  AB    Z     BZ
</pre>
В первой строке задается алфавит, в остальных сначала
указывается состояние, а затем переходы.\
"->" означает начальное состояние (можно не ставить, тогда начальным состоянием будет первое состояние).\
"(..)" означает финальное состояние.\
" " - разделитель.\
"-" означает, что нет перехода.\
Автоматы эквивалентны при совпадении алфавитов и выполнении [условия проверки через BFS](https://neerc.ifmo.ru/wiki/index.php?title=%D0%AD%D0%BA%D0%B2%D0%B8%D0%B2%D0%B0%D0%BB%D0%B5%D0%BD%D1%82%D0%BD%D0%BE%D1%81%D1%82%D1%8C_%D1%81%D0%BE%D1%81%D1%82%D0%BE%D1%8F%D0%BD%D0%B8%D0%B9_%D0%94%D0%9A%D0%90)