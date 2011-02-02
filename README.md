radiant-views-extension
=====================

Installation
------------

git clone git://github.com/lunaweb/radiant-views-extension.git

Utilisation
-----------

### Base

Dans n'importe quel page/layout/snippet l'utilisation du tag `<r:render>` permet de faire le rendu d'un template présent dans "RAILS_ROOT/app/views/".

`<r:render name="foo" />` fera donc un rendu du template présent à l'adresse `RAILS_ROOT/app/views/foo.phtml`

Dans le template il est possible d' :

* utiliser Ruby
* utiliser des variables
* exécuter d'autres tags Radiant (`<r:snippet>`, `<r:content>`, ... et tous les autres)
* exécuter d'autres `<r:render>`

### Tag rattaché au template

Il est possible d'exécuter un tag avant de faire le rendu d'un template. Cela permet d'initialiser des variables qui seront utilisables dans le template.

Le nom du tag exécuté correspond au nom du template.

Pour que le tag soit exécuté, il faut qu'il soit namespacé, c'est à dire qu'il doit utilisé les deux points ":".
Cela permet d'éviter tout effet indésirable (exemple : l'exécution du tag `<r:children>` avant le rendu d'un template "children.rhtml").

Ainsi le rendu d'un template "ns:foo" correspondra au template "RAILS_ROOT/app/views/ns/foo.rhtml" et au tag "ns:foo".

	<r:render name="ns:foo" />

L'utilisation du tag n'est pas obligatoire : il est possible de ne pas le déclarer.

### Variables

Toutes les variables locales sont transmises au template, c'est à dire que c'est le hash "tag.locals" qui est transmit en tant que source de données.

Ainsi pour déclarer des variables il faut faire :

déclaration du tag

	desc %{
		Description
	}
	tag "ns:foo" do |tag|
		tag.locals.my_var = "utilisation d'une variable"
	end
	
template .rhtml

	<%= my_var %>

template .haml

	= my_var