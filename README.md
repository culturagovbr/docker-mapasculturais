# docker-mapasculturais



## Sobre

Neste repositório você encontrará as dependências necessárias para criar ter um ambiente funcional da aplicação Mapas Culturais.

Utilizamos o [docker](https://www.docker.com) como plataforma para criar e administrar ambientes isolados em um sistema operacional.

Utilizamos como base a imagem ```php``` na tag ```5.6.30-apache``` pois ela já contém um conjunto de ferramentas que otimizam o funcionamento da aplicação em conjunto com o servidor web ```apache```. Alguns dos itens utilizados dessa imagem são ```docker-php-ext-configure``` e ```docker-php-ext-install``` que servem respectivamente para configurar módulos e recompilar o PHP especificamente para a imagem que estamos utilizando.

Em nosso stack da aplicação temos basicamente 3 serviços que são iniciados em conjunto quando a stack é iniciada:
* Aplicação WEB
* Banco de dados
* Gerenciador de Dependências

## Pré-requisitos

Para utilizar esse repositório é necessário conhecimento nos itens abaixo:
* Plataforma Docker ( Mais informações clique [aqui](http://pt.slideshare.net/vinnyfs89/docker-essa-baleia-vai-te-conquistar?qid=aed7b752-f313-4515-badd-f3bf811c8a35&v=&b=&from_search=1) )
* PHP 5.*
* Apache 2.*
* Shell script

Você precisará ter os itens abaixo instalados:
* Docker
* docker-compose

## Como construir uma imagem e gerar containers?

 * Faça uma cópia do arquivo ```docker-compose.yml_exemplo``` para ```docker-compose.yml``` 
 * Acesse e edite o arquivo ```docker-compose.yml``` e ajuste as variáveis de acordo com sua necessidade.
 * Execute o comando abaixo caso queira subir o stack de serviços da aplicação :

```
 docker-compose up -d
```

 * Caso queira fazer o mesmo processo anterior e monitorar os serviços basta retirar o ```-d``` do final:

```
 docker-compose up
```

Caso não queira construir uma nova imagem, versionamos a imagem atual no hub.docker e pode ser utilizada sem gerar novo build. É possível acessá-la clicando [aqui](https://hub.docker.com/r/culturagovbr/mapasculturais/).

## Extra

Se você gostaria de verificar algo ou fazer algum teste dentro de algum dos containers criados que estão em execução, você pode executar o comando abaixo:

```
docker exec -it mapasculturais_web bash
```
