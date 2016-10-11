Detections
==========

About
-----

Lë o arquivo de entrada e sumariza os gëneros musicais.

Usage
-----

> ruby {arquivoDeEntrada} {limiarDeSemelhança}

Onde limiar de semelhança é um valor entre 0.0 e 1.0 que representa o grau de semelhança mínimo entre dois gëneros distintos para que eles sejam agrupados em um só.

Tests
-----

> bundle exec rspec
