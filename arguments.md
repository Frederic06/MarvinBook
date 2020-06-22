
Voici la justifications des choix techniques pour l'application demo "MARVIN BOOK" réalisée en iOS

---Architecture globale---

Les fonctionnalités demandées comprennent beaucoup de logiques, le MVVM permet une meilleure distinction des responsabilité et les tests sur la logique sont plus simple à réaliser. 

L'application a été réalisée en MVVM-C avec le pattern delegate.

=> L'AppCoordinator est responsable de la transition des vues et des données et est le delegate de chacun des ViewModel.

=> Le ViewController responsable de l'affichage des vues.

=> Le ViewModel est responsable de la logique et de la commande de l'actualisation des vues.

=> Une classe "DataSource" est delegate et dataSource de chaque list (UITableView ou UICollectionView)

=> Le repository récupère les données (requetes réseaux ou persistance). Un "RepositoryType" est créé en amont afin de permettre de tester sans appel réseau.

=> Le repository recupère les URLs auprès de la classe "Route"


Présentation des pages et de l'arborescence

---LOGIN---

Le login est fake, j'ai utilisé un booléen renseigné dans NSUSERDEFAULT afin de stocker le statut login ou logout de manière persistante.
Si l'utilisateur est déja loggué, la page "Home" s'affiche directement, sinon on demande à l'utilisateur de se logguer.

J'utilise un Timer afin de décaller l'affiche de la page Home, et de simuler une identification avec un Activity Indicator

---HOME---

La page home comprend 
- un bouton (UIButton)logout (rouge)
- un titre, UIlabel (MarvinBook)
- une UIView comprenant 
    une collection view ou s'affichent les livres horizontalement
      l'appui sur un élément de cette collection mène vers la vue détail du livre
    une table view ou s'affichent les livres, leurs titres etc. verticalement
      l'appui sur un élément de cette table mène vers la vue détail du livre
- une tableView dans laquelle s'affichent les livres sauvegardés dans la persistance (CoreData)
- un bouton du bas (UIView comprenant deux UIImageView) ressemblant à un "UISegmentedControl" permet de cacher/afficher les deux derniers éléments

---DETAIL

La page detail comprend
- un UIButton (X) qui dismiss la page
- une UIImageView présentant l'image du livre
- un UILabel, le titre du livre
- un UILabel, le nom de l'auteur
- un bouton (UIView comprenant une UIImageView) permettant d'ajouter/d'enlever le livre aux favoris
- une liste (UITableView) présentant l'ensemble des livres (image seulement)



