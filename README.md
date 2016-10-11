Detections
==========

About
-----

Dado um arquivo de entrada com músicas e rádios onde estas músicas foram tocadas, tenta induzir o gënero de cada música com um algoritmo de clusterização dos dados.

Usage
-----

> ruby {arquivoDeEntrada} {limiarDeSemelhança}

Onde limiar de semelhança é um valor entre 0.0 e 1.0 que representa o grau de semelhança mínimo entre dois gëneros distintos para que eles sejam agrupados em um só.

Tests
-----

> bundle exec rspec

References
----------

O código foi baseado nestes dois textos:
> http://www.cs.utah.edu/~piyush/teaching/4-10-print.pdf
> http://home.deib.polimi.it/matteucc/Clustering/tutorial_html/hierarchical.html
