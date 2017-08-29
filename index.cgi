#!C:\Perl\bin\perl.exe

use strict;
use warnings;

use CGI qw(:cgi-lib :escapeHTML :unescapeHTML);
use CGI::Carp qw(fatalsToBrowser); # позволит выводить ошибки в браузер



$|=1; # отключаем буферизацию ввода данных;
ReadParse(); # получает данные из HTML формы в  хэш %in

# вариант хедера, используется перед выводом в браузер
print "Content-type: text/html; charset=utf-8\n\n";

require 'application/bootstrap.pl';