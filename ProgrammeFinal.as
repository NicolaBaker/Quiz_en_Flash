/* Nom du fichier : ProgrammeFinal
   Programmeur : Nicola Baker
   Date : 09 javier 2023
   Description : Un bon quiz de Math.
*/
package	{ 

	// Import
	import flash.display.*;
	import flash.events.*;
	import flash.net.*;

	
	public class ProgrammeFinal extends MovieClip {
		
		// var fichier XML
		var chargeur:URLLoader;
		var listeClasse:XMLList = new XMLList;
		var listeMath:XMLList = new XMLList;
		
		// Tableau avec les réponses.
		var questionS:Array = [];
		
		// Tableau avec les questions.
		var questionReponse:Array = [[0,0]];
		
		// var reponse.
		var reponse:int;
		
		// var chiffre.
		var nombreBase:int;
		var nombreApresLaValeur:int;
		var nombreApresLaValeur2:int;
		var nombreApresLaValeur3:int;
		var nombreApresLaValeur4:int;
		var nombreApresLaValeur2Moin:String;
		var nombreApresLaValeur4Moin:String;
		
		// var question.
		var question:String;
		
		// var le nombre de question que tu as sauté.
		var nombreQ:int;
		
		// var le nombre de bonnes questions.
		var bonneQ:int;
		
		// var de nombre de parti.
		var parti:int;
		
		// Constructeur
		public function ProgrammeFinal() {
			
			// fichier XML
			var adresseFichier:URLRequest = new URLRequest("infoMath.xml");
			chargeur = new URLLoader();
			chargeur.load(adresseFichier);
			chargeur.addEventListener(Event.COMPLETE, finChargement);
			
			// Le bouton qui enregistre les opérations mathématiques à clic sur btnPuiss.
			btnEnreg.addEventListener(MouseEvent.CLICK, calcule);
			
			// Le bouton qui détermine si c'est la bonne réponse à clic sur btnReponse.
			btnReponse.addEventListener(MouseEvent.CLICK, reponse1);
			
			// Le bouton qui tu peux faire que tu sautes la question à clic sur btnSkip.
			btnSkip.addEventListener(MouseEvent.CLICK, skipB);
			
			// Le bouton qui permet de reprendre la question que tu as sauté à clic sur btnRejouer.
			btnRejouer.addEventListener(MouseEvent.CLICK, rejouer);
			
			// Tableau de question.
			include "ProgrammeFinalQ.as"
			
			// Limite le contenu des boites de textes. 
			txtReponse.restrict = "0-9\\-";
			txtnumeroQuestion.restrict = "0-9";
			
		}// Fin du constructeur.
		
		// ComboBox de les valeurs.
		private function finChargement (event :Event) :void
		{
			// Fichier XML
			var groupeClasse:XML = new XML;
			groupeClasse = XML(chargeur.data);
			listeClasse = groupeClasse.math;
			
			// Constructeur de comboBox de les catégories.
			for (var i:int = 0 ; i < listeClasse.length(); i++)
     	 	{
				// ComboBox de les catégories.
				nomEleves_cb.addItem({label: listeClasse[i].nomEleve});
		
			}
			
			// Le bouton de catégorie que tu as choisi.
			nomEleves_cb.addEventListener(Event.CHANGE, afficheEleve);
			
			// 1 ComboBox de les opérations mathématiques.
			cbValeur.addItem({label:"la division"});
			cbValeur.addItem({label:"la multiplication"});
			cbValeur.addItem({label:"l'addition"});
			cbValeur.addItem({label:"la soustraction"});
			
			// 2 ComboBox de les opérations mathématiques.
			cbUneValeur.addItem({label:"la multiplication"});
			cbUneValeur.addItem({label:"l'addition"});
			cbUneValeur.addItem({label:"la soustraction"});
			
			// 3 ComboBox de les opérations mathématiques.
			cb2Valeur.addItem({label:"la multiplication"});
			cb2Valeur.addItem({label:"l'addition"});
			cb2Valeur.addItem({label:"la soustraction"});
			
			// 4 ComboBox de les opérations mathématiques.
			cb3Valeur.addItem({label:"la multiplication"});
			cb3Valeur.addItem({label:"l'addition"});
			cb3Valeur.addItem({label:"la soustraction"});
			cb3Valeur.addItem({label:"hasard"});
			
		}// Fin du comboBox de les valeurs.
		
		// La catégorie choisi.
		private function afficheEleve (event :Event) :void
		{
			// Le texte importé du fichier XML.
			defi_txt.text = listeClasse.(nomEleve==nomEleves_cb.selectedItem.label).nomEleve;
			code_txt.text = listeClasse.(nomEleve==nomEleves_cb.selectedItem.label).codeMath;
			
			if (nomEleves_cb.selectedItem.label == "Explication"){
				
				// Le texte importé du fichier XML pour expliquer.
				txtExplique.text = listeClasse.(nomEleve==nomEleves_cb.selectedItem.label).exMath;
				txtExplique2.text = listeClasse.(nomEleve==nomEleves_cb.selectedItem.label).ex2Math;
			}
			else{
				
				// texte affiche le résultat.
				txtExplique.text = "";
				txtExplique2.text = "";
			}
			
			// Affiche le résultat.
			txtQuestionMath.text = "";
			txtQuestionMathResulat.text = "";
			
		}// Fin de la catégorie choisi.
		
		// Les questions.
		function calcule (event :MouseEvent) :void
		{
			// Affiche un message.
			txtQuestionMath.text = "Tu dois prendre une catégorie.";
			
			// Affiche les points.
			txtBonne.text = ""+bonneQ;
			
			// La catégorie explication.
			if (nomEleves_cb.selectedItem.label == "Explication"){
			
				// Message pour expliquer un problème.
				question = "Tu dois prendre un autre catégorie.";
			}
			
			// La catégorie facile.
			else if (nomEleves_cb.selectedItem.label == "Facile"){
				
				// Les 3 chiffres dans la question au hasard.
				nombreBase = Math.floor(Math.random()* (1+ 10)) ;
				nombreApresLaValeur = Math.floor(Math.random()* (1+ 10)) ;
				nombreApresLaValeur2 = Math.floor(Math.random()* (1+ 10)) ;
				
				// L'opération mathématique de la division et de la multiplication.
				if (cbValeur.selectedItem.label == "la division" && cbUneValeur.selectedItem.label == "la multiplication")
				{
					// nombreBase devient une belle division.
					nombreBase = nombreApresLaValeur * nombreApresLaValeur;
					
					// Formulation de la question.
					question = nombreBase + " / " + nombreApresLaValeur + " x " + nombreApresLaValeur2 + " = ";
					
					// Calcule la réponse.
					reponse = nombreBase / nombreApresLaValeur * nombreApresLaValeur2;
					
				}
				
				// L'opération mathématique de la division et de l'addition.
				else if (cbValeur.selectedItem.label == "la division" && cbUneValeur.selectedItem.label == "l'addition")
				{
					// nombreBase devient une belle division.
					nombreBase = nombreApresLaValeur * nombreApresLaValeur;
					
					// Formulation de la question.
					question = nombreBase + " / " + nombreApresLaValeur + " + " + nombreApresLaValeur2 + " = ";
					
					// Calcule la réponse.
					reponse = nombreBase / nombreApresLaValeur + nombreApresLaValeur2;
			
				}
				
				// L'opération mathématique de la division et de la soustraction.
				else if (cbValeur.selectedItem.label == "la division" && cbUneValeur.selectedItem.label == "la soustraction")
				{
					// nombreBase devient une belle division.
					nombreBase = nombreApresLaValeur * nombreApresLaValeur;
					
					// Formulation de la question.
					question = nombreBase + " / " + nombreApresLaValeur + " - " + nombreApresLaValeur2 + " = ";
					
					// Calcule la réponse.
					reponse = nombreBase / nombreApresLaValeur - nombreApresLaValeur2;
			
				}
				
				// L'opération mathématique de la multiplication et de la multiplication.
				else if (cbValeur.selectedItem.label == "la multiplication" && cbUneValeur.selectedItem.label == "la multiplication")
				{
					// Formulation de la question.
					question = nombreBase + " x " + nombreApresLaValeur + " x " + nombreApresLaValeur2 + " = ";
					
					// Calcule la réponse.
					reponse = nombreBase * nombreApresLaValeur * nombreApresLaValeur2;
			
				}
				
				// L'opération mathématique de la multiplication et de l'addition.
				else if (cbValeur.selectedItem.label == "la multiplication" && cbUneValeur.selectedItem.label == "l'addition")
				{
					// Formulation de la question.
					question = nombreBase + " x " + nombreApresLaValeur + " + " + nombreApresLaValeur2 + " = ";
					
					// Calcule la réponse.
					reponse = nombreBase * nombreApresLaValeur + nombreApresLaValeur2;
			
				}
				
				// L'opération mathématique de la multiplication et de la soustraction.
				else if (cbValeur.selectedItem.label == "la multiplication" && cbUneValeur.selectedItem.label == "la soustraction")
				{
					// Formulation de la question.
					question = nombreBase + " x " + nombreApresLaValeur + " - " + nombreApresLaValeur2 + " = ";
					
					// Calcule la réponse.
					reponse = nombreBase * nombreApresLaValeur - nombreApresLaValeur2;
			
				}
				
				// L'opération mathématique de l'addition et de la multiplication.
				else if (cbValeur.selectedItem.label == "l'addition" && cbUneValeur.selectedItem.label == "la multiplication")
				{
					// Formulation de la question.
					question = nombreBase + " + " + nombreApresLaValeur + " x " + nombreApresLaValeur2 + " = ";
					
					// Calcule la réponse.
					reponse = nombreBase + nombreApresLaValeur * nombreApresLaValeur2;
			
				}
				
				// L'opération mathématique de l'addition et de l'addition.
				else if (cbValeur.selectedItem.label == "l'addition" && cbUneValeur.selectedItem.label == "l'addition")
				{
					// Formulation de la question.
					question = nombreBase + " + " + nombreApresLaValeur + " + " + nombreApresLaValeur2 + " = ";
					
					// Calcule la réponse.
					reponse = nombreBase + nombreApresLaValeur + nombreApresLaValeur2;
			
				}
				
				// L'opération mathématique de l'addition et de la soustraction.
				else if (cbValeur.selectedItem.label == "l'addition" && cbUneValeur.selectedItem.label == "la soustraction")
				{
					// Formulation de la question.
					question = nombreBase + " + " + nombreApresLaValeur + " - " + nombreApresLaValeur2 + " = ";
					
					// Calcule la réponse.
					reponse = nombreBase + nombreApresLaValeur - nombreApresLaValeur2;
			
				}
				
				// L'opération mathématique de la soustraction et de la multiplication.
				else if (cbValeur.selectedItem.label == "la soustraction" && cbUneValeur.selectedItem.label == "la multiplication")
				{
					// Formulation de la question.
					question = nombreBase + " - " + nombreApresLaValeur + " x " + nombreApresLaValeur2 + " = ";
					
					// Calcule la réponse.
					reponse = nombreBase - nombreApresLaValeur * nombreApresLaValeur2;
			
				}
				
				// L'opération mathématique de la soustraction et de l'addition.
				else if (cbValeur.selectedItem.label == "la soustraction" && cbUneValeur.selectedItem.label == "l'addition")
				{
					// Formulation de la question.
					question = nombreBase + " - " + nombreApresLaValeur + " + " + nombreApresLaValeur2 + " = ";
					
					// Calcule la réponse.
					reponse = nombreBase - nombreApresLaValeur + nombreApresLaValeur2;
			
				}
				
				// L'opération mathématique de la soustraction et de la soustraction.
				else if (cbValeur.selectedItem.label == "la soustraction" && cbUneValeur.selectedItem.label == "la soustraction")
				{
					// Formulation de la question.
					question = nombreBase + " - " + nombreApresLaValeur + " - " + nombreApresLaValeur2 + " = ";
					
					// Calcule la réponse.
					reponse = nombreBase - nombreApresLaValeur - nombreApresLaValeur2;
			
				}
				
			} // Fin de la catégorie facile.
			
			// La catégorie moyen.
			else if (nomEleves_cb.selectedItem.label == "Moyen"){
				
				// Les 4 chiffres dans la question au hasard.
				nombreBase = Math.floor(Math.random()* (1+ 100)) ;
				nombreApresLaValeur = Math.floor(Math.random()* (1+ 10)) ;
				nombreApresLaValeur2 = Math.floor(Math.random()* (1+ 50)) -20;
				nombreApresLaValeur3 = Math.floor(Math.random()* (1+ 20)) ;
				
				// Chiffre en tant que négatif.
				if (nombreApresLaValeur2 <0){
					
					// Change le chiffre.
					nombreApresLaValeur2Moin = "("+nombreApresLaValeur2+")";
				}
				else {
					
					// Ne change pas le chiffre.
					nombreApresLaValeur2Moin = nombreApresLaValeur2+"";
				}
				
				// L'opération mathématique de la division et de la multiplication et de la multiplication. 
				if (cbValeur.selectedItem.label == "la division" && cbUneValeur.selectedItem.label == "la multiplication" && cb2Valeur.selectedItem.label == "la multiplication")
				{
					// nombreBase devient une belle division.
					nombreBase = nombreApresLaValeur * nombreApresLaValeur;
					
					// Formulation de la question.
					question = nombreBase + " / " + nombreApresLaValeur + " x " + nombreApresLaValeur2Moin + " x " + nombreApresLaValeur3 + " = ";
					
					// Calcule la réponse.
					reponse = nombreBase / nombreApresLaValeur * nombreApresLaValeur2 * nombreApresLaValeur3;
					
				}
				
				// L'opération mathématique de la division et de la multiplication et de l'addition. 
				else if (cbValeur.selectedItem.label == "la division" && cbUneValeur.selectedItem.label == "la multiplication" && cb2Valeur.selectedItem.label == "l'addition")
				{
					// nombreBase devient une belle division.
					nombreBase = nombreApresLaValeur * nombreApresLaValeur;
					
					// Formulation de la question.
					question = nombreBase + " / " + nombreApresLaValeur + " x " + nombreApresLaValeur2Moin + " + " + nombreApresLaValeur3 + " = ";
					
					// Calcule la réponse.
					reponse = nombreBase / nombreApresLaValeur * nombreApresLaValeur2 + nombreApresLaValeur3;
					
				}
				
				// L'opération mathématique de la division et de la multiplication et de la soustraction. 
				else if (cbValeur.selectedItem.label == "la division" && cbUneValeur.selectedItem.label == "la multiplication" && cb2Valeur.selectedItem.label == "la soustraction")
				{
					// nombreBase devient une belle division.
					nombreBase = nombreApresLaValeur * nombreApresLaValeur;
					
					// Formulation de la question.
					question = nombreBase + " / " + nombreApresLaValeur + " x " + nombreApresLaValeur2Moin + " - " + nombreApresLaValeur3 + " = ";
					
					// Calcule la réponse.
					reponse = nombreBase / nombreApresLaValeur * nombreApresLaValeur2 - nombreApresLaValeur3;
					
				}
				
				// L'opération mathématique de la division et de l'addition et de l'addition. 
				else if (cbValeur.selectedItem.label == "la division" && cbUneValeur.selectedItem.label == "l'addition" && cb2Valeur.selectedItem.label == "l'addition")
				{
					// nombreBase devient une belle division.
					nombreBase = nombreApresLaValeur * nombreApresLaValeur;
					
					// Formulation de la question.
					question = nombreBase + " / " + nombreApresLaValeur + " + " + nombreApresLaValeur2Moin + " + " + nombreApresLaValeur3 + " = ";
					
					// Calcule la réponse.
					reponse = nombreBase / nombreApresLaValeur + nombreApresLaValeur2 + nombreApresLaValeur3;
			
				}
				
				// L'opération mathématique de la division et de l'addition et de la multiplication. 
				else if (cbValeur.selectedItem.label == "la division" && cbUneValeur.selectedItem.label == "l'addition" && cb2Valeur.selectedItem.label == "la multiplication")
				{
					// nombreBase devient une belle division.
					nombreBase = nombreApresLaValeur * nombreApresLaValeur;
					
					// Formulation de la question.
					question = nombreBase + " / " + nombreApresLaValeur + " + " + nombreApresLaValeur2Moin + " x " + nombreApresLaValeur3 + " = ";
					
					// Calcule la réponse.
					reponse = nombreBase / nombreApresLaValeur + nombreApresLaValeur2 * nombreApresLaValeur3;
			
				}
				
				// L'opération mathématique de la division et de l'addition et de la soustraction. 
				else if (cbValeur.selectedItem.label == "la division" && cbUneValeur.selectedItem.label == "l'addition" && cb2Valeur.selectedItem.label == "la soustraction")
				{
					// nombreBase devient une belle division.
					nombreBase = nombreApresLaValeur * nombreApresLaValeur;
					
					// Formulation de la question.
					question = nombreBase + " / " + nombreApresLaValeur + " + " + nombreApresLaValeur2Moin + " - " + nombreApresLaValeur3 + " = ";
					
					// Calcule la réponse.
					reponse = nombreBase / nombreApresLaValeur + nombreApresLaValeur2 - nombreApresLaValeur3;
			
				}
				
				// L'opération mathématique de la division et de la soustraction et de la soustraction. 
				else if (cbValeur.selectedItem.label == "la division" && cbUneValeur.selectedItem.label == "la soustraction" && cb2Valeur.selectedItem.label == "la soustraction")
				{
					// nombreBase devient une belle division.
					nombreBase = nombreApresLaValeur * nombreApresLaValeur;
					
					// Formulation de la question.
					question = nombreBase + " / " + nombreApresLaValeur + " - " + nombreApresLaValeur2Moin + " - " + nombreApresLaValeur3 + " = ";
					
					// Calcule la réponse.
					reponse = nombreBase / nombreApresLaValeur - nombreApresLaValeur2 - nombreApresLaValeur3;
			
				}
				
				// L'opération mathématique de la division et de la soustraction et de la multiplication. 
				else if (cbValeur.selectedItem.label == "la division" && cbUneValeur.selectedItem.label == "la soustraction" && cb2Valeur.selectedItem.label == "la multiplication")
				{
					// nombreBase devient une belle division.
					nombreBase = nombreApresLaValeur * nombreApresLaValeur;
					
					// Formulation de la question.
					question = nombreBase + " / " + nombreApresLaValeur + " - " + nombreApresLaValeur2Moin + " x " + nombreApresLaValeur3 + " = ";
					
					// Calcule la réponse.
					reponse = nombreBase / nombreApresLaValeur - nombreApresLaValeur2 * nombreApresLaValeur3;
			
				}
				
				// L'opération mathématique de la division et de la soustraction et de l'addition. 
				else if (cbValeur.selectedItem.label == "la division" && cbUneValeur.selectedItem.label == "la soustraction" && cb2Valeur.selectedItem.label == "l'addition")
				{
					// nombreBase devient une belle division.
					nombreBase = nombreApresLaValeur * nombreApresLaValeur;
					
					// Formulation de la question.
					question = nombreBase + " / " + nombreApresLaValeur + " - " + nombreApresLaValeur2Moin + " + " + nombreApresLaValeur3 + " = ";
					
					// Calcule la réponse.
					reponse = nombreBase / nombreApresLaValeur - nombreApresLaValeur2 + nombreApresLaValeur3;
			
				}
				
				// L'opération mathématique de la multiplication et de la multiplication et de la multiplication. 
				if (cbValeur.selectedItem.label == "la multiplication" && cbUneValeur.selectedItem.label == "la multiplication" && cb2Valeur.selectedItem.label == "la multiplication")
				{
					// Formulation de la question.
					question = nombreBase + " x " + nombreApresLaValeur + " x " + nombreApresLaValeur2Moin + " x " + nombreApresLaValeur3 + " = ";
					
					// Calcule la réponse.
					reponse = nombreBase * nombreApresLaValeur * nombreApresLaValeur2 * nombreApresLaValeur3;
					
				}
				
				// L'opération mathématique de la multiplication et de la multiplication et de l'addition. 
				else if (cbValeur.selectedItem.label == "la multiplication" && cbUneValeur.selectedItem.label == "la multiplication" && cb2Valeur.selectedItem.label == "l'addition")
				{
					// Formulation de la question.
					question = nombreBase + " x " + nombreApresLaValeur + " x " + nombreApresLaValeur2Moin + " + " + nombreApresLaValeur3 + " = ";
					
					// Calcule la réponse.
					reponse = nombreBase * nombreApresLaValeur * nombreApresLaValeur2 + nombreApresLaValeur3;
					
				}
				
				// L'opération mathématique de la multiplication et de la multiplication et de la soustraction. 
				else if (cbValeur.selectedItem.label == "la multiplication" && cbUneValeur.selectedItem.label == "la multiplication" && cb2Valeur.selectedItem.label == "la soustraction")
				{
					// Formulation de la question.
					question = nombreBase + " x " + nombreApresLaValeur + " x " + nombreApresLaValeur2Moin + " - " + nombreApresLaValeur3 + " = ";
					
					// Calcule la réponse.
					reponse = nombreBase * nombreApresLaValeur * nombreApresLaValeur2 - nombreApresLaValeur3;
					
				}
				
				// L'opération mathématique de la multiplication et de l'addition et de l'addition. 
				else if (cbValeur.selectedItem.label == "la multiplication" && cbUneValeur.selectedItem.label == "l'addition" && cb2Valeur.selectedItem.label == "l'addition")
				{
					// Formulation de la question.
					question = nombreBase + " x " + nombreApresLaValeur + " + " + nombreApresLaValeur2Moin + " + " + nombreApresLaValeur3 + " = ";
					
					// Calcule la réponse.
					reponse = nombreBase * nombreApresLaValeur + nombreApresLaValeur2 + nombreApresLaValeur3;
			
				}
				
				// L'opération mathématique de la multiplication et de l'addition et de la multiplication. 
				else if (cbValeur.selectedItem.label == "la multiplication" && cbUneValeur.selectedItem.label == "l'addition" && cb2Valeur.selectedItem.label == "la multiplication")
				{
					// Formulation de la question.
					question = nombreBase + " x " + nombreApresLaValeur + " + " + nombreApresLaValeur2Moin + " x " + nombreApresLaValeur3 + " = ";
					
					// Calcule la réponse.
					reponse = nombreBase * nombreApresLaValeur + nombreApresLaValeur2 * nombreApresLaValeur3;
			
				}
				
				// L'opération mathématique de la multiplication et de l'addition et de la soustraction. 
				else if (cbValeur.selectedItem.label == "la multiplication" && cbUneValeur.selectedItem.label == "l'addition" && cb2Valeur.selectedItem.label == "la soustraction")
				{
					// Formulation de la question.
					question = nombreBase + " x " + nombreApresLaValeur + " + " + nombreApresLaValeur2Moin + " - " + nombreApresLaValeur3 + " = ";
					
					// Calcule la réponse.
					reponse = nombreBase * nombreApresLaValeur + nombreApresLaValeur2 - nombreApresLaValeur3;
			
				}
				
				// L'opération mathématique de la multiplication et de la soustraction et de la soustraction. 
				else if (cbValeur.selectedItem.label == "la multiplication" && cbUneValeur.selectedItem.label == "la soustraction" && cb2Valeur.selectedItem.label == "la soustraction")
				{
					// Formulation de la question.
					question = nombreBase + " x " + nombreApresLaValeur + " - " + nombreApresLaValeur2Moin + " - " + nombreApresLaValeur3 + " = ";
					
					// Calcule la réponse.
					reponse = nombreBase * nombreApresLaValeur - nombreApresLaValeur2 - nombreApresLaValeur3;
			
				}
				
				// L'opération mathématique de la multiplication et de la soustraction et de la multiplication. 
				else if (cbValeur.selectedItem.label == "la multiplication" && cbUneValeur.selectedItem.label == "la soustraction" && cb2Valeur.selectedItem.label == "la multiplication")
				{
					// Formulation de la question.
					question = nombreBase + " x " + nombreApresLaValeur + " - " + nombreApresLaValeur2Moin + " x " + nombreApresLaValeur3 + " = ";
					
					// Calcule la réponse.
					reponse = nombreBase * nombreApresLaValeur - nombreApresLaValeur2 * nombreApresLaValeur3;
			
				}
				
				// L'opération mathématique de la multiplication et de la soustraction et de l'addition. 
				else if (cbValeur.selectedItem.label == "la multiplication" && cbUneValeur.selectedItem.label == "la soustraction" && cb2Valeur.selectedItem.label == "l'addition")
				{
					// Formulation de la question.
					question = nombreBase + " x " + nombreApresLaValeur + " - " + nombreApresLaValeur2Moin + " + " + nombreApresLaValeur3 + " = ";
					
					// Calcule la réponse.
					reponse = nombreBase * nombreApresLaValeur - nombreApresLaValeur2 + nombreApresLaValeur3;
			
				}
				
				// L'opération mathématique de l'addition et de la multiplication et de la multiplication. 
				if (cbValeur.selectedItem.label == "l'addition" && cbUneValeur.selectedItem.label == "la multiplication" && cb2Valeur.selectedItem.label == "la multiplication")
				{
					// Formulation de la question.
					question = nombreBase + " + " + nombreApresLaValeur + " x " + nombreApresLaValeur2Moin + " x " + nombreApresLaValeur3 + " = ";
					
					// Calcule la réponse.
					reponse = nombreBase + nombreApresLaValeur * nombreApresLaValeur2 * nombreApresLaValeur3;
					
				}
				
				// L'opération mathématique de l'addition et de la multiplication et de l'addition. 
				else if (cbValeur.selectedItem.label == "l'addition" && cbUneValeur.selectedItem.label == "la multiplication" && cb2Valeur.selectedItem.label == "l'addition")
				{
					// Formulation de la question.
					question = nombreBase + " + " + nombreApresLaValeur + " x " + nombreApresLaValeur2Moin + " + " + nombreApresLaValeur3 + " = ";
					
					// Calcule la réponse.
					reponse = nombreBase + nombreApresLaValeur * nombreApresLaValeur2 + nombreApresLaValeur3;
					
				}
				
				// L'opération mathématique de l'addition et de la multiplication et de la soustraction.
				else if (cbValeur.selectedItem.label == "l'addition" && cbUneValeur.selectedItem.label == "la multiplication" && cb2Valeur.selectedItem.label == "la soustraction")
				{
					// Formulation de la question.
					question = nombreBase + " + " + nombreApresLaValeur + " x " + nombreApresLaValeur2Moin + " - " + nombreApresLaValeur3 + " = ";
					
					// Calcule la réponse.
					reponse = nombreBase + nombreApresLaValeur * nombreApresLaValeur2 - nombreApresLaValeur3;
					
				}
				
				// L'opération mathématique de l'addition et de l'addition et de l'addition.
				else if (cbValeur.selectedItem.label == "l'addition" && cbUneValeur.selectedItem.label == "l'addition" && cb2Valeur.selectedItem.label == "l'addition")
				{
					// Formulation de la question.
					question = nombreBase + " + " + nombreApresLaValeur + " + " + nombreApresLaValeur2Moin + " + " + nombreApresLaValeur3 + " = ";
					
					// Calcule la réponse.
					reponse = nombreBase + nombreApresLaValeur + nombreApresLaValeur2 + nombreApresLaValeur3;
			
				}
				
				// L'opération mathématique de l'addition et de l'addition et de la multiplication.
				else if (cbValeur.selectedItem.label == "l'addition" && cbUneValeur.selectedItem.label == "l'addition" && cb2Valeur.selectedItem.label == "la multiplication")
				{
					// Formulation de la question.
					question = nombreBase + " + " + nombreApresLaValeur + " + " + nombreApresLaValeur2Moin + " x " + nombreApresLaValeur3 + " = ";
					
					// Calcule la réponse.
					reponse = nombreBase + nombreApresLaValeur + nombreApresLaValeur2 * nombreApresLaValeur3;
			
				}
				
				// L'opération mathématique de l'addition et de l'addition et de la soustraction.
				else if (cbValeur.selectedItem.label == "l'addition" && cbUneValeur.selectedItem.label == "l'addition" && cb2Valeur.selectedItem.label == "la soustraction")
				{
					// Formulation de la question.
					question = nombreBase + " + " + nombreApresLaValeur + " + " + nombreApresLaValeur2Moin + " - " + nombreApresLaValeur3 + " = ";
					
					// Calcule la réponse.
					reponse = nombreBase * nombreApresLaValeur + nombreApresLaValeur2 - nombreApresLaValeur3;
			
				}
				
				// L'opération mathématique de l'addition et de la soustraction et de la soustraction.
				else if (cbValeur.selectedItem.label == "l'addition" && cbUneValeur.selectedItem.label == "la soustraction" && cb2Valeur.selectedItem.label == "la soustraction")
				{
					// Formulation de la question.
					question = nombreBase + " + " + nombreApresLaValeur + " - " + nombreApresLaValeur2Moin + " - " + nombreApresLaValeur3 + " = ";
					
					// Calcule la réponse.
					reponse = nombreBase * nombreApresLaValeur - nombreApresLaValeur2 - nombreApresLaValeur3;
			
				}
				
				// L'opération mathématique de l'addition et de la soustraction et de la multiplication.
				else if (cbValeur.selectedItem.label == "l'addition" && cbUneValeur.selectedItem.label == "la soustraction" && cb2Valeur.selectedItem.label == "la multiplication")
				{
					// Formulation de la question.
					question = nombreBase + " + " + nombreApresLaValeur + " - " + nombreApresLaValeur2Moin + " x " + nombreApresLaValeur3 + " = ";
					
					// Calcule la réponse.
					reponse = nombreBase + nombreApresLaValeur - nombreApresLaValeur2 * nombreApresLaValeur3;
			
				}
				
				// L'opération mathématique de l'addition et de la soustraction et de l'addition.
				else if (cbValeur.selectedItem.label == "l'addition" && cbUneValeur.selectedItem.label == "la soustraction" && cb2Valeur.selectedItem.label == "l'addition")
				{
					// Formulation de la question.
					question = nombreBase + " + " + nombreApresLaValeur + " - " + nombreApresLaValeur2Moin + " + " + nombreApresLaValeur3 + " = ";
					
					// Calcule la réponse.
					reponse = nombreBase + nombreApresLaValeur - nombreApresLaValeur2 + nombreApresLaValeur3;
			
				}
				
				// L'opération mathématique de la soustraction et de la multiplication et de la multiplication.
				if (cbValeur.selectedItem.label == "la soustraction" && cbUneValeur.selectedItem.label == "la multiplication" && cb2Valeur.selectedItem.label == "la multiplication")
				{
					// Formulation de la question.
					question = nombreBase + " - " + nombreApresLaValeur + " x " + nombreApresLaValeur2Moin + " x " + nombreApresLaValeur3 + " = ";
					
					// Calcule la réponse.
					reponse = nombreBase - nombreApresLaValeur * nombreApresLaValeur2 * nombreApresLaValeur3;
					
				}
				
				// L'opération mathématique de la soustraction et de la multiplication et de l'addition.
				else if (cbValeur.selectedItem.label == "la soustraction" && cbUneValeur.selectedItem.label == "la multiplication" && cb2Valeur.selectedItem.label == "l'addition")
				{
					// Formulation de la question.
					question = nombreBase + " - " + nombreApresLaValeur + " x " + nombreApresLaValeur2Moin + " + " + nombreApresLaValeur3 + " = ";
					
					// Calcule la réponse.
					reponse = nombreBase - nombreApresLaValeur * nombreApresLaValeur2 + nombreApresLaValeur3;
					
				}
				
				// L'opération mathématique de la soustraction et de la multiplication et de la soustraction.
				else if (cbValeur.selectedItem.label == "la soustraction" && cbUneValeur.selectedItem.label == "la multiplication" && cb2Valeur.selectedItem.label == "la soustraction")
				{
					// Formulation de la question.
					question = nombreBase + " - " + nombreApresLaValeur + " x " + nombreApresLaValeur2Moin + " - " + nombreApresLaValeur3 + " = ";
					
					// Calcule la réponse.
					reponse = nombreBase - nombreApresLaValeur * nombreApresLaValeur2 - nombreApresLaValeur3;
					
				}
				
				// L'opération mathématique de la soustraction et de l'addition et de l'addition.
				else if (cbValeur.selectedItem.label == "la soustraction" && cbUneValeur.selectedItem.label == "l'addition" && cb2Valeur.selectedItem.label == "l'addition")
				{
					// Formulation de la question.
					question = nombreBase + " - " + nombreApresLaValeur + " + " + nombreApresLaValeur2Moin + " + " + nombreApresLaValeur3 + " = ";
					
					// Calcule la réponse.
					reponse = nombreBase - nombreApresLaValeur + nombreApresLaValeur2 + nombreApresLaValeur3;
			
				}
				
				// L'opération mathématique de la soustraction et de l'addition et de la multiplication.
				else if (cbValeur.selectedItem.label == "la soustraction" && cbUneValeur.selectedItem.label == "l'addition" && cb2Valeur.selectedItem.label == "la multiplication")
				{
					// Formulation de la question.
					question = nombreBase + " - " + nombreApresLaValeur + " + " + nombreApresLaValeur2Moin + " x " + nombreApresLaValeur3 + " = ";
					
					// Calcule la réponse.
					reponse = nombreBase - nombreApresLaValeur + nombreApresLaValeur2 * nombreApresLaValeur3;
			
				}
				
				// L'opération mathématique de la soustraction et de l'addition et de la soustraction.
				else if (cbValeur.selectedItem.label == "la soustraction" && cbUneValeur.selectedItem.label == "l'addition" && cb2Valeur.selectedItem.label == "la soustraction")
				{
					// Formulation de la question.
					question = nombreBase + " - " + nombreApresLaValeur + " + " + nombreApresLaValeur2Moin + " - " + nombreApresLaValeur3 + " = ";
					
					// Calcule la réponse.
					reponse = nombreBase - nombreApresLaValeur + nombreApresLaValeur2 - nombreApresLaValeur3;
			
				}
				
				// L'opération mathématique de la soustraction et de la soustraction et de la soustraction.
				else if (cbValeur.selectedItem.label == "la soustraction" && cbUneValeur.selectedItem.label == "la soustraction" && cb2Valeur.selectedItem.label == "la soustraction")
				{
					// Formulation de la question.
					question = nombreBase + " - " + nombreApresLaValeur + " - " + nombreApresLaValeur2Moin + " - " + nombreApresLaValeur3 + " = ";
					
					// Calcule la réponse.
					reponse = nombreBase - nombreApresLaValeur - nombreApresLaValeur2 - nombreApresLaValeur3;
			
				}
				
				// L'opération mathématique de la soustraction et de la soustraction et de la multiplication.
				else if (cbValeur.selectedItem.label == "la soustraction" && cbUneValeur.selectedItem.label == "la soustraction" && cb2Valeur.selectedItem.label == "la multiplication")
				{
					// Formulation de la question.
					question = nombreBase + " - " + nombreApresLaValeur + " - " + nombreApresLaValeur2Moin + " x " + nombreApresLaValeur3 + " = ";
					
					// Calcule la réponse.
					reponse = nombreBase - nombreApresLaValeur - nombreApresLaValeur2 * nombreApresLaValeur3;
			
				}
				
				// L'opération mathématique de la soustraction et de la soustraction et de l'addition.
				else if (cbValeur.selectedItem.label == "la soustraction" && cbUneValeur.selectedItem.label == "la soustraction" && cb2Valeur.selectedItem.label == "l'addition")
				{
					// Formulation de la question.
					question = nombreBase + " - " + nombreApresLaValeur + " - " + nombreApresLaValeur2Moin + " + " + nombreApresLaValeur3 + " = ";
					
					// Calcule la réponse.
					reponse = nombreBase - nombreApresLaValeur - nombreApresLaValeur2 + nombreApresLaValeur3;
			
				}
				
			}// Fin de la catégorie moyen.
			
			// La catégorie difficile.
			else if (nomEleves_cb.selectedItem.label == "Difficile"){
				
				// Les 5 chiffres dans la question au hasard.
				nombreBase = Math.floor(Math.random()* (1+ 10)) ;
				nombreApresLaValeur = Math.floor(Math.random()* (1+ 50)) ;
				nombreApresLaValeur2 = Math.floor(Math.random()* (1+ 10)) - 10;
				nombreApresLaValeur3 = Math.floor(Math.random()* (1+ 100)) ;
				nombreApresLaValeur4 = Math.floor(Math.random()* (1+ 100)) - 100;
				
				// Chiffre en tant que négatif
				if (nombreApresLaValeur2 <0){
					
					// Change le chiffre.
					nombreApresLaValeur2Moin = "("+nombreApresLaValeur2+")";
				}
				else {
					
					// Ne change pas le chiffre.
					nombreApresLaValeur2Moin = nombreApresLaValeur2+"";
				}
				
				// 2 Chiffre en tant que négatif
				if (nombreApresLaValeur4 <0){
					
					// Change le chiffre.
					nombreApresLaValeur4Moin = "("+nombreApresLaValeur4+")";
				}
				else {
					
					// Ne change pas le chiffre.
					nombreApresLaValeur4Moin = nombreApresLaValeur4+"";
				}
				
				// L'opération mathématique de la division et de la multiplication et de la multiplication et la multiplication. 
				if (cbValeur.selectedItem.label == "la division" && cbUneValeur.selectedItem.label == "la multiplication" && cb2Valeur.selectedItem.label == "la multiplication" && cb3Valeur.selectedItem.label == "la multiplication")
				{
					// nombreBase devient une belle division.
					nombreBase = nombreApresLaValeur * nombreApresLaValeur;
					
					// Formulation de la question.
					question = nombreBase + " / " + nombreApresLaValeur + " x " + nombreApresLaValeur2Moin + " x " + nombreApresLaValeur3 + " x " + nombreApresLaValeur4Moin + " = ";
					
					// Calcule la réponse.
					reponse = nombreBase / nombreApresLaValeur * nombreApresLaValeur2 * nombreApresLaValeur3 * nombreApresLaValeur4;
					
				}
				
				// L'opération mathématique
				else if (cbValeur.selectedItem.label == "la division" && cbUneValeur.selectedItem.label == "la multiplication" && cb2Valeur.selectedItem.label == "l'addition" && cb3Valeur.selectedItem.label == "la multiplication")
				{
					// nombreBase devient une belle division.
					nombreBase = nombreApresLaValeur * nombreApresLaValeur;
					
					// Formulation de la question.
					question = nombreBase + " / " + nombreApresLaValeur + " x " + nombreApresLaValeur2Moin + " + " + nombreApresLaValeur3 + " x " + nombreApresLaValeur4Moin + " = ";
					
					// Calcule la réponse.
					reponse = nombreBase / nombreApresLaValeur * nombreApresLaValeur2 + nombreApresLaValeur3 * nombreApresLaValeur4;
					
				}
				
				// L'opération mathématique
				else if (cbValeur.selectedItem.label == "la division" && cbUneValeur.selectedItem.label == "la multiplication" && cb2Valeur.selectedItem.label == "la soustraction" && cb3Valeur.selectedItem.label == "la multiplication")
				{
					// nombreBase devient une belle division.
					nombreBase = nombreApresLaValeur * nombreApresLaValeur;
					
					// Formulation de la question.
					question = nombreBase + " / " + nombreApresLaValeur + " x " + nombreApresLaValeur2Moin + " - " + nombreApresLaValeur3 + " x " + nombreApresLaValeur4Moin + " = ";
					
					// Calcule la réponse.
					reponse = nombreBase / nombreApresLaValeur * nombreApresLaValeur2 - nombreApresLaValeur3 * nombreApresLaValeur4;
					
				}
				
				// L'opération mathématique
				else if (cbValeur.selectedItem.label == "la division" && cbUneValeur.selectedItem.label == "l'addition" && cb2Valeur.selectedItem.label == "l'addition" && cb3Valeur.selectedItem.label == "la multiplication")
				{
					// nombreBase devient une belle division.
					nombreBase = nombreApresLaValeur * nombreApresLaValeur;
					
					// Formulation de la question.
					question = nombreBase + " / " + nombreApresLaValeur + " + " + nombreApresLaValeur2Moin + " + " + nombreApresLaValeur3 + " x " + nombreApresLaValeur4Moin + " = ";
					
					// Calcule la réponse.
					reponse = nombreBase / nombreApresLaValeur + nombreApresLaValeur2 + nombreApresLaValeur3 * nombreApresLaValeur4;
			
				}
				
				// L'opération mathématique
				else if (cbValeur.selectedItem.label == "la division" && cbUneValeur.selectedItem.label == "l'addition" && cb2Valeur.selectedItem.label == "la multiplication" && cb3Valeur.selectedItem.label == "la multiplication")
				{
					// nombreBase devient une belle division.
					nombreBase = nombreApresLaValeur * nombreApresLaValeur;
					
					// Formulation de la question.
					question = nombreBase + " / " + nombreApresLaValeur + " + " + nombreApresLaValeur2Moin + " x " + nombreApresLaValeur3 + " x " + nombreApresLaValeur4Moin + " = ";
					
					// Calcule la réponse.
					reponse = nombreBase / nombreApresLaValeur + nombreApresLaValeur2 * nombreApresLaValeur3 * nombreApresLaValeur4;
			
				}
				
				// L'opération mathématique
				else if (cbValeur.selectedItem.label == "la division" && cbUneValeur.selectedItem.label == "l'addition" && cb2Valeur.selectedItem.label == "la soustraction" && cb3Valeur.selectedItem.label == "la multiplication")
				{
					// nombreBase devient une belle division.
					nombreBase = nombreApresLaValeur * nombreApresLaValeur;
					
					// Formulation de la question.
					question = nombreBase + " / " + nombreApresLaValeur + " + " + nombreApresLaValeur2Moin + " - " + nombreApresLaValeur3 + " x " + nombreApresLaValeur4Moin + " = ";
					
					// Calcule la réponse.
					reponse = nombreBase / nombreApresLaValeur + nombreApresLaValeur2 - nombreApresLaValeur3 * nombreApresLaValeur4;
			
				}
				
				// L'opération mathématique
				else if (cbValeur.selectedItem.label == "la division" && cbUneValeur.selectedItem.label == "la soustraction" && cb2Valeur.selectedItem.label == "la soustraction" && cb3Valeur.selectedItem.label == "la multiplication")
				{
					// nombreBase devient une belle division.
					nombreBase = nombreApresLaValeur * nombreApresLaValeur;
					
					// Formulation de la question.
					question = nombreBase + " / " + nombreApresLaValeur + " - " + nombreApresLaValeur2Moin + " - " + nombreApresLaValeur3 + " x " + nombreApresLaValeur4Moin + " = ";
					
					// Calcule la réponse.
					reponse = nombreBase / nombreApresLaValeur - nombreApresLaValeur2 - nombreApresLaValeur3 * nombreApresLaValeur4;
			
				}
				
				// L'opération mathématique
				else if (cbValeur.selectedItem.label == "la division" && cbUneValeur.selectedItem.label == "la soustraction" && cb2Valeur.selectedItem.label == "la multiplication" && cb3Valeur.selectedItem.label == "la multiplication")
				{
					// nombreBase devient une belle division.
					nombreBase = nombreApresLaValeur * nombreApresLaValeur;
					
					// Formulation de la question.
					question = nombreBase + " / " + nombreApresLaValeur + " - " + nombreApresLaValeur2Moin + " x " + nombreApresLaValeur3 + " x " + nombreApresLaValeur4Moin + " = ";
					
					// Calcule la réponse.
					reponse = nombreBase / nombreApresLaValeur - nombreApresLaValeur2 * nombreApresLaValeur3 * nombreApresLaValeur4;
			
				}
				
				// L'opération mathématique
				else if (cbValeur.selectedItem.label == "la division" && cbUneValeur.selectedItem.label == "la soustraction" && cb2Valeur.selectedItem.label == "l'addition" && cb3Valeur.selectedItem.label == "la multiplication")
				{
					// nombreBase devient une belle division.
					nombreBase = nombreApresLaValeur * nombreApresLaValeur;
					
					// Formulation de la question.
					question = nombreBase + " / " + nombreApresLaValeur + " - " + nombreApresLaValeur2Moin + " + " + nombreApresLaValeur3 + " x " + nombreApresLaValeur4Moin + " = ";
					
					// Calcule la réponse.
					reponse = nombreBase / nombreApresLaValeur - nombreApresLaValeur2 + nombreApresLaValeur3 * nombreApresLaValeur4;
			
				}
				
				// L'opération mathématique de la multiplication
				if (cbValeur.selectedItem.label == "la multiplication" && cbUneValeur.selectedItem.label == "la multiplication" && cb2Valeur.selectedItem.label == "la multiplication" && cb3Valeur.selectedItem.label == "la multiplication")
				{
					// Formulation de la question.
					question = nombreBase + " x " + nombreApresLaValeur + " x " + nombreApresLaValeur2Moin + " x " + nombreApresLaValeur3 + " x " + nombreApresLaValeur4Moin + " = ";
					
					// Calcule la réponse.
					reponse = nombreBase * nombreApresLaValeur * nombreApresLaValeur2 * nombreApresLaValeur3 * nombreApresLaValeur4;
					
				}
				
				// L'opération mathématique de la multiplication
				else if (cbValeur.selectedItem.label == "la multiplication" && cbUneValeur.selectedItem.label == "la multiplication" && cb2Valeur.selectedItem.label == "l'addition" && cb3Valeur.selectedItem.label == "la multiplication")
				{
					// Formulation de la question.
					question = nombreBase + " x " + nombreApresLaValeur + " x " + nombreApresLaValeur2Moin + " + " + nombreApresLaValeur3 + " x " + nombreApresLaValeur4Moin + " = ";
					
					// Calcule la réponse.
					reponse = nombreBase * nombreApresLaValeur * nombreApresLaValeur2 + nombreApresLaValeur3 * nombreApresLaValeur4;
					
				}
				
				// L'opération mathématique de la multiplication
				else if (cbValeur.selectedItem.label == "la multiplication" && cbUneValeur.selectedItem.label == "la multiplication" && cb2Valeur.selectedItem.label == "la soustraction" && cb3Valeur.selectedItem.label == "la multiplication")
				{
					// Formulation de la question.
					question = nombreBase + " x " + nombreApresLaValeur + " x " + nombreApresLaValeur2Moin + " - " + nombreApresLaValeur3 + " x " + nombreApresLaValeur4Moin + " = ";
					
					// Calcule la réponse.
					reponse = nombreBase * nombreApresLaValeur * nombreApresLaValeur2 - nombreApresLaValeur3 * nombreApresLaValeur4;
					
				}
				
				// L'opération mathématique de la multiplication
				else if (cbValeur.selectedItem.label == "la multiplication" && cbUneValeur.selectedItem.label == "l'addition" && cb2Valeur.selectedItem.label == "l'addition" && cb3Valeur.selectedItem.label == "la multiplication")
				{
					// Formulation de la question.
					question = nombreBase + " x " + nombreApresLaValeur + " + " + nombreApresLaValeur2Moin + " + " + nombreApresLaValeur3 + " x " + nombreApresLaValeur4Moin + " = ";
					
					// Calcule la réponse.
					reponse = nombreBase * nombreApresLaValeur + nombreApresLaValeur2 + nombreApresLaValeur3 * nombreApresLaValeur4;
			
				}
				
				// L'opération mathématique de la multiplication
				else if (cbValeur.selectedItem.label == "la multiplication" && cbUneValeur.selectedItem.label == "l'addition" && cb2Valeur.selectedItem.label == "la multiplication" && cb3Valeur.selectedItem.label == "la multiplication")
				{
					// Formulation de la question.
					question = nombreBase + " x " + nombreApresLaValeur + " + " + nombreApresLaValeur2Moin + " x " + nombreApresLaValeur3 + " x " + nombreApresLaValeur4Moin + " = ";
					
					// Calcule la réponse.
					reponse = nombreBase * nombreApresLaValeur + nombreApresLaValeur2 * nombreApresLaValeur3 * nombreApresLaValeur4;
			
				}
				
				// L'opération mathématique de la multiplication
				else if (cbValeur.selectedItem.label == "la multiplication" && cbUneValeur.selectedItem.label == "l'addition" && cb2Valeur.selectedItem.label == "la soustraction" && cb3Valeur.selectedItem.label == "la multiplication")
				{
					// Formulation de la question.
					question = nombreBase + " x " + nombreApresLaValeur + " + " + nombreApresLaValeur2Moin + " - " + nombreApresLaValeur3 + " x " + nombreApresLaValeur4Moin + " = ";
					
					// Calcule la réponse.
					reponse = nombreBase * nombreApresLaValeur + nombreApresLaValeur2 - nombreApresLaValeur3 * nombreApresLaValeur4;
			
				}
				
				// L'opération mathématique de la multiplication
				else if (cbValeur.selectedItem.label == "la multiplication" && cbUneValeur.selectedItem.label == "la soustraction" && cb2Valeur.selectedItem.label == "la soustraction" && cb3Valeur.selectedItem.label == "la multiplication")
				{
					// Formulation de la question.
					question = nombreBase + " x " + nombreApresLaValeur + " - " + nombreApresLaValeur2Moin + " - " + nombreApresLaValeur3 + " x " + nombreApresLaValeur4Moin + " = ";
					
					// Calcule la réponse.
					reponse = nombreBase * nombreApresLaValeur - nombreApresLaValeur2 - nombreApresLaValeur3 * nombreApresLaValeur4;
			
				}
				
				// L'opération mathématique de la multiplication
				else if (cbValeur.selectedItem.label == "la multiplication" && cbUneValeur.selectedItem.label == "la soustraction" && cb2Valeur.selectedItem.label == "la multiplication" && cb3Valeur.selectedItem.label == "la multiplication")
				{
					// Formulation de la question.
					question = nombreBase + " x " + nombreApresLaValeur + " - " + nombreApresLaValeur2Moin + " x " + nombreApresLaValeur3 + " x " + nombreApresLaValeur4Moin + " = ";
					
					// Calcule la réponse.
					reponse = nombreBase * nombreApresLaValeur - nombreApresLaValeur2 * nombreApresLaValeur3 * nombreApresLaValeur4;
			
				}
				
				// L'opération mathématique de la multiplication
				else if (cbValeur.selectedItem.label == "la multiplication" && cbUneValeur.selectedItem.label == "la soustraction" && cb2Valeur.selectedItem.label == "l'addition" && cb3Valeur.selectedItem.label == "la multiplication")
				{
					// Formulation de la question.
					question = nombreBase + " x " + nombreApresLaValeur + " - " + nombreApresLaValeur2Moin + " + " + nombreApresLaValeur3 + " x " + nombreApresLaValeur4Moin + " = ";
					
					// Calcule la réponse.
					reponse = nombreBase * nombreApresLaValeur - nombreApresLaValeur2 + nombreApresLaValeur3 * nombreApresLaValeur4;
			
				}
		
				// L'opération mathématique de l'addition
				if (cbValeur.selectedItem.label == "l'addition" && cbUneValeur.selectedItem.label == "la multiplication" && cb2Valeur.selectedItem.label == "la multiplication" && cb3Valeur.selectedItem.label == "la multiplication")
				{
					// Formulation de la question.
					question = nombreBase + " + " + nombreApresLaValeur + " x " + nombreApresLaValeur2Moin + " x " + nombreApresLaValeur3 + " x " + nombreApresLaValeur4Moin + " = ";
					
					// Calcule la réponse.
					reponse = nombreBase + nombreApresLaValeur * nombreApresLaValeur2 * nombreApresLaValeur3 * nombreApresLaValeur4;
					
				}
				
				// L'opération mathématique de l'addition
				else if (cbValeur.selectedItem.label == "l'addition" && cbUneValeur.selectedItem.label == "la multiplication" && cb2Valeur.selectedItem.label == "l'addition" && cb3Valeur.selectedItem.label == "la multiplication")
				{
					// Formulation de la question.
					question = nombreBase + " + " + nombreApresLaValeur + " x " + nombreApresLaValeur2Moin + " + " + nombreApresLaValeur3 + " x " + nombreApresLaValeur4Moin + " = ";
					
					// Calcule la réponse.
					reponse = nombreBase + nombreApresLaValeur * nombreApresLaValeur2 + nombreApresLaValeur3 * nombreApresLaValeur4;
					
				}
				
				// L'opération mathématique de l'addition
				else if (cbValeur.selectedItem.label == "l'addition" && cbUneValeur.selectedItem.label == "la multiplication" && cb2Valeur.selectedItem.label == "la soustraction" && cb3Valeur.selectedItem.label == "la multiplication")
				{
					// Formulation de la question.
					question = nombreBase + " + " + nombreApresLaValeur + " x " + nombreApresLaValeur2Moin + " - " + nombreApresLaValeur3 + " x " + nombreApresLaValeur4Moin + " = ";
					
					// Calcule la réponse.
					reponse = nombreBase + nombreApresLaValeur * nombreApresLaValeur2 - nombreApresLaValeur3 * nombreApresLaValeur4;
					
				}
				
				// L'opération mathématique de l'addition
				else if (cbValeur.selectedItem.label == "l'addition" && cbUneValeur.selectedItem.label == "l'addition" && cb2Valeur.selectedItem.label == "l'addition" && cb3Valeur.selectedItem.label == "la multiplication")
				{
					// Formulation de la question.
					question = nombreBase + " + " + nombreApresLaValeur + " + " + nombreApresLaValeur2Moin + " + " + nombreApresLaValeur3 + " x " + nombreApresLaValeur4Moin + " = ";
					
					// Calcule la réponse.
					reponse = nombreBase + nombreApresLaValeur + nombreApresLaValeur2 + nombreApresLaValeur3 * nombreApresLaValeur4;
			
				}
				
				// L'opération mathématique de l'addition
				else if (cbValeur.selectedItem.label == "l'addition" && cbUneValeur.selectedItem.label == "l'addition" && cb2Valeur.selectedItem.label == "la multiplication" && cb3Valeur.selectedItem.label == "la multiplication")
				{
					// Formulation de la question.
					question = nombreBase + " + " + nombreApresLaValeur + " + " + nombreApresLaValeur2Moin + " x " + nombreApresLaValeur3 + " x " + nombreApresLaValeur4Moin + " = ";
					
					// Calcule la réponse.
					reponse = nombreBase + nombreApresLaValeur + nombreApresLaValeur2 * nombreApresLaValeur3 * nombreApresLaValeur4;
			
				}
				
				// L'opération mathématique de l'addition
				else if (cbValeur.selectedItem.label == "l'addition" && cbUneValeur.selectedItem.label == "l'addition" && cb2Valeur.selectedItem.label == "la soustraction" && cb3Valeur.selectedItem.label == "la multiplication")
				{
					// Formulation de la question.
					question = nombreBase + " + " + nombreApresLaValeur + " + " + nombreApresLaValeur2Moin + " - " + nombreApresLaValeur3 + " x " + nombreApresLaValeur4Moin + " = ";
					
					// Calcule la réponse.
					reponse = nombreBase * nombreApresLaValeur + nombreApresLaValeur2 - nombreApresLaValeur3 * nombreApresLaValeur4;
			
				}
				
				// L'opération mathématique de l'addition
				else if (cbValeur.selectedItem.label == "l'addition" && cbUneValeur.selectedItem.label == "la soustraction" && cb2Valeur.selectedItem.label == "la soustraction" && cb3Valeur.selectedItem.label == "la multiplication")
				{
					// Formulation de la question.
					question = nombreBase + " + " + nombreApresLaValeur + " - " + nombreApresLaValeur2Moin + " - " + nombreApresLaValeur3 + " x " + nombreApresLaValeur4Moin + " = ";
					
					// Calcule la réponse.
					reponse = nombreBase * nombreApresLaValeur - nombreApresLaValeur2 - nombreApresLaValeur3 * nombreApresLaValeur4;
			
				}
				
				// L'opération mathématique de l'addition
				else if (cbValeur.selectedItem.label == "l'addition" && cbUneValeur.selectedItem.label == "la soustraction" && cb2Valeur.selectedItem.label == "la multiplication" && cb3Valeur.selectedItem.label == "la multiplication")
				{
					// Formulation de la question.
					question = nombreBase + " + " + nombreApresLaValeur + " - " + nombreApresLaValeur2Moin + " x " + nombreApresLaValeur3 + " x " + nombreApresLaValeur4Moin + " = ";
					
					// Calcule la réponse.
					reponse = nombreBase + nombreApresLaValeur - nombreApresLaValeur2 * nombreApresLaValeur3 * nombreApresLaValeur4;
			
				}
				
				// L'opération mathématique de l'addition
				else if (cbValeur.selectedItem.label == "l'addition" && cbUneValeur.selectedItem.label == "la soustraction" && cb2Valeur.selectedItem.label == "l'addition" && cb3Valeur.selectedItem.label == "la multiplication")
				{
					// Formulation de la question.
					question = nombreBase + " + " + nombreApresLaValeur + " - " + nombreApresLaValeur2Moin + " + " + nombreApresLaValeur3 + " x " + nombreApresLaValeur4Moin + " = ";
					
					// Calcule la réponse.
					reponse = nombreBase + nombreApresLaValeur - nombreApresLaValeur2 + nombreApresLaValeur3 * nombreApresLaValeur4;
			
				}

				// L'opération mathématique de la soustraction
				if (cbValeur.selectedItem.label == "la soustraction" && cbUneValeur.selectedItem.label == "la multiplication" && cb2Valeur.selectedItem.label == "la multiplication" && cb3Valeur.selectedItem.label == "la multiplication")
				{
					// Formulation de la question.
					question = nombreBase + " - " + nombreApresLaValeur + " x " + nombreApresLaValeur2Moin + " x " + nombreApresLaValeur3 + " x " + nombreApresLaValeur4Moin + " = ";
					
					// Calcule la réponse.
					reponse = nombreBase - nombreApresLaValeur * nombreApresLaValeur2 * nombreApresLaValeur3 * nombreApresLaValeur4;
					
				}
				
				// L'opération mathématique de la soustraction
				else if (cbValeur.selectedItem.label == "la soustraction" && cbUneValeur.selectedItem.label == "la multiplication" && cb2Valeur.selectedItem.label == "l'addition" && cb3Valeur.selectedItem.label == "la multiplication")
				{
					// Formulation de la question.
					question = nombreBase + " - " + nombreApresLaValeur + " x " + nombreApresLaValeur2Moin + " + " + nombreApresLaValeur3 + " x " + nombreApresLaValeur4Moin + " = ";
					
					// Calcule la réponse.
					reponse = nombreBase - nombreApresLaValeur * nombreApresLaValeur2 + nombreApresLaValeur3 * nombreApresLaValeur4;
					
				}
				
				// L'opération mathématique de la soustraction
				else if (cbValeur.selectedItem.label == "la soustraction" && cbUneValeur.selectedItem.label == "la multiplication" && cb2Valeur.selectedItem.label == "la soustraction" && cb3Valeur.selectedItem.label == "la multiplication")
				{
					// Formulation de la question.
					question = nombreBase + " - " + nombreApresLaValeur + " x " + nombreApresLaValeur2Moin + " - " + nombreApresLaValeur3 + " x " + nombreApresLaValeur4Moin + " = ";
					
					// Calcule la réponse.
					reponse = nombreBase - nombreApresLaValeur * nombreApresLaValeur2 - nombreApresLaValeur3 * nombreApresLaValeur4;
					
				}
				
				// L'opération mathématique de la soustraction
				else if (cbValeur.selectedItem.label == "la soustraction" && cbUneValeur.selectedItem.label == "l'addition" && cb2Valeur.selectedItem.label == "l'addition" && cb3Valeur.selectedItem.label == "la multiplication")
				{
					// Formulation de la question.
					question = nombreBase + " - " + nombreApresLaValeur + " + " + nombreApresLaValeur2Moin + " + " + nombreApresLaValeur3 + " x " + nombreApresLaValeur4Moin + " = ";
					
					// Calcule la réponse.
					reponse = nombreBase - nombreApresLaValeur + nombreApresLaValeur2 + nombreApresLaValeur3 * nombreApresLaValeur4;
			
				}
				
				// L'opération mathématique de la soustraction
				else if (cbValeur.selectedItem.label == "la soustraction" && cbUneValeur.selectedItem.label == "l'addition" && cb2Valeur.selectedItem.label == "la multiplication" && cb3Valeur.selectedItem.label == "la multiplication")
				{
					// Formulation de la question.
					question = nombreBase + " - " + nombreApresLaValeur + " + " + nombreApresLaValeur2Moin + " x " + nombreApresLaValeur3 + " x " + nombreApresLaValeur4Moin + " = ";
					
					// Calcule la réponse.
					reponse = nombreBase - nombreApresLaValeur + nombreApresLaValeur2 * nombreApresLaValeur3 * nombreApresLaValeur4;
			
				}
				
				// L'opération mathématique de la soustraction
				else if (cbValeur.selectedItem.label == "la soustraction" && cbUneValeur.selectedItem.label == "l'addition" && cb2Valeur.selectedItem.label == "la soustraction" && cb3Valeur.selectedItem.label == "la multiplication")
				{
					// Formulation de la question.
					question = nombreBase + " - " + nombreApresLaValeur + " + " + nombreApresLaValeur2Moin + " - " + nombreApresLaValeur3 + " x " + nombreApresLaValeur4Moin + " = ";
					
					// Calcule la réponse.
					reponse = nombreBase - nombreApresLaValeur + nombreApresLaValeur2 - nombreApresLaValeur3 * nombreApresLaValeur4;
			
				}
				
				// L'opération mathématique de la soustraction
				else if (cbValeur.selectedItem.label == "la soustraction" && cbUneValeur.selectedItem.label == "la soustraction" && cb2Valeur.selectedItem.label == "la soustraction" && cb3Valeur.selectedItem.label == "la multiplication")
				{
					// Formulation de la question.
					question = nombreBase + " - " + nombreApresLaValeur + " - " + nombreApresLaValeur2Moin + " - " + nombreApresLaValeur3 + " x " + nombreApresLaValeur4Moin + " = ";
					
					// Calcule la réponse.
					reponse = nombreBase - nombreApresLaValeur - nombreApresLaValeur2 - nombreApresLaValeur3 * nombreApresLaValeur4;
			
				}
				
				// L'opération mathématique de la soustraction
				else if (cbValeur.selectedItem.label == "la soustraction" && cbUneValeur.selectedItem.label == "la soustraction" && cb2Valeur.selectedItem.label == "la multiplication" && cb3Valeur.selectedItem.label == "la multiplication")
				{
					// Formulation de la question.
					question = nombreBase + " - " + nombreApresLaValeur + " - " + nombreApresLaValeur2Moin + " x " + nombreApresLaValeur3 + " x " + nombreApresLaValeur4Moin + " = ";
					reponse = nombreBase - nombreApresLaValeur - nombreApresLaValeur2 * nombreApresLaValeur3 * nombreApresLaValeur4;
			
				}
				
				// L'opération mathématique de la soustraction
				else if (cbValeur.selectedItem.label == "la soustraction" && cbUneValeur.selectedItem.label == "la soustraction" && cb2Valeur.selectedItem.label == "l'addition" && cb3Valeur.selectedItem.label == "la multiplication")
				{
					// Formulation de la question.
					question = nombreBase + " - " + nombreApresLaValeur + " - " + nombreApresLaValeur2Moin + " + " + nombreApresLaValeur3 + " x " + nombreApresLaValeur4Moin + " = ";
					
					// Calcule la réponse.
					reponse = nombreBase - nombreApresLaValeur - nombreApresLaValeur2 + nombreApresLaValeur3 * nombreApresLaValeur4;
			
				}

				// L'opération mathématique de la division
				if (cbValeur.selectedItem.label == "la division" && cbUneValeur.selectedItem.label == "la multiplication" && cb2Valeur.selectedItem.label == "la multiplication" && cb3Valeur.selectedItem.label == "l'addition")
				{
					// nombreBase devient une belle division.
					nombreBase = nombreApresLaValeur * nombreApresLaValeur;
					
					// Formulation de la question.
					question = nombreBase + " / " + nombreApresLaValeur + " x " + nombreApresLaValeur2Moin + " x " + nombreApresLaValeur3 + " + " + nombreApresLaValeur4Moin + " = ";
					
					// Calcule la réponse.
					reponse = nombreBase / nombreApresLaValeur * nombreApresLaValeur2 * nombreApresLaValeur3 + nombreApresLaValeur4;
					
				}
				
				// L'opération mathématique de la division
				else if (cbValeur.selectedItem.label == "la division" && cbUneValeur.selectedItem.label == "la multiplication" && cb2Valeur.selectedItem.label == "l'addition" && cb3Valeur.selectedItem.label == "l'addition")
				{
					// nombreBase devient une belle division.
					nombreBase = nombreApresLaValeur * nombreApresLaValeur;
					
					// Formulation de la question.
					question = nombreBase + " / " + nombreApresLaValeur + " x " + nombreApresLaValeur2Moin + " + " + nombreApresLaValeur3 + " + " + nombreApresLaValeur4Moin + " = ";
					
					// Calcule la réponse.
					reponse = nombreBase / nombreApresLaValeur * nombreApresLaValeur2 + nombreApresLaValeur3 + nombreApresLaValeur4;
					
				}
				
				// L'opération mathématique de la division
				else if (cbValeur.selectedItem.label == "la division" && cbUneValeur.selectedItem.label == "la multiplication" && cb2Valeur.selectedItem.label == "la soustraction" && cb3Valeur.selectedItem.label == "l'addition")
				{
					// nombreBase devient une belle division.
					nombreBase = nombreApresLaValeur * nombreApresLaValeur;
					
					// Formulation de la question.
					question = nombreBase + " / " + nombreApresLaValeur + " x " + nombreApresLaValeur2Moin + " - " + nombreApresLaValeur3 + " + " + nombreApresLaValeur4Moin + " = ";
					
					// Calcule la réponse.
					reponse = nombreBase / nombreApresLaValeur * nombreApresLaValeur2 - nombreApresLaValeur3 + nombreApresLaValeur4;
					
				}
				
				// L'opération mathématique de la division
				else if (cbValeur.selectedItem.label == "la division" && cbUneValeur.selectedItem.label == "l'addition" && cb2Valeur.selectedItem.label == "l'addition" && cb3Valeur.selectedItem.label == "l'addition")
				{
					// nombreBase devient une belle division.
					nombreBase = nombreApresLaValeur * nombreApresLaValeur;
					
					// Formulation de la question.
					question = nombreBase + " / " + nombreApresLaValeur + " + " + nombreApresLaValeur2Moin + " + " + nombreApresLaValeur3 + " + " + nombreApresLaValeur4Moin + " = ";
					
					// Calcule la réponse.
					reponse = nombreBase / nombreApresLaValeur + nombreApresLaValeur2 + nombreApresLaValeur3 + nombreApresLaValeur4;
			
				}
				
				// L'opération mathématique de la division
				else if (cbValeur.selectedItem.label == "la division" && cbUneValeur.selectedItem.label == "l'addition" && cb2Valeur.selectedItem.label == "la multiplication" && cb3Valeur.selectedItem.label == "l'addition")
				{
					// nombreBase devient une belle division.
					nombreBase = nombreApresLaValeur * nombreApresLaValeur;
					
					// Formulation de la question.
					question = nombreBase + " / " + nombreApresLaValeur + " + " + nombreApresLaValeur2Moin + " x " + nombreApresLaValeur3 + " + " + nombreApresLaValeur4Moin + " = ";
					
					// Calcule la réponse.
					reponse = nombreBase / nombreApresLaValeur + nombreApresLaValeur2 * nombreApresLaValeur3 + nombreApresLaValeur4;
			
				}
				
				// L'opération mathématique de la division
				else if (cbValeur.selectedItem.label == "la division" && cbUneValeur.selectedItem.label == "l'addition" && cb2Valeur.selectedItem.label == "la soustraction" && cb3Valeur.selectedItem.label == "l'addition")
				{
					// nombreBase devient une belle division.
					nombreBase = nombreApresLaValeur * nombreApresLaValeur;
					
					// Formulation de la question.
					question = nombreBase + " / " + nombreApresLaValeur + " + " + nombreApresLaValeur2Moin + " - " + nombreApresLaValeur3 + " + " + nombreApresLaValeur4Moin + " = ";
					
					// Calcule la réponse.
					reponse = nombreBase / nombreApresLaValeur + nombreApresLaValeur2 - nombreApresLaValeur3 + nombreApresLaValeur4;
			
				}
				
				// L'opération mathématique de la division
				else if (cbValeur.selectedItem.label == "la division" && cbUneValeur.selectedItem.label == "la soustraction" && cb2Valeur.selectedItem.label == "la soustraction" && cb3Valeur.selectedItem.label == "l'addition")
				{
					// nombreBase devient une belle division.
					nombreBase = nombreApresLaValeur * nombreApresLaValeur;
					
					// Formulation de la question.
					question = nombreBase + " / " + nombreApresLaValeur + " - " + nombreApresLaValeur2Moin + " - " + nombreApresLaValeur3 + " + " + nombreApresLaValeur4Moin + " = ";
					
					// Calcule la réponse.
					reponse = nombreBase / nombreApresLaValeur - nombreApresLaValeur2 - nombreApresLaValeur3 + nombreApresLaValeur4;
			
				}
				
				// L'opération mathématique de la division
				else if (cbValeur.selectedItem.label == "la division" && cbUneValeur.selectedItem.label == "la soustraction" && cb2Valeur.selectedItem.label == "la multiplication" && cb3Valeur.selectedItem.label == "l'addition")
				{
					// nombreBase devient une belle division.
					nombreBase = nombreApresLaValeur * nombreApresLaValeur;
					
					// Formulation de la question.
					question = nombreBase + " / " + nombreApresLaValeur + " - " + nombreApresLaValeur2Moin + " x " + nombreApresLaValeur3 + " + " + nombreApresLaValeur4Moin + " = ";
					
					// Calcule la réponse.
					reponse = nombreBase / nombreApresLaValeur - nombreApresLaValeur2 * nombreApresLaValeur3 + nombreApresLaValeur4;
			
				}
				
				// L'opération mathématique de la division
				else if (cbValeur.selectedItem.label == "la division" && cbUneValeur.selectedItem.label == "la soustraction" && cb2Valeur.selectedItem.label == "l'addition" && cb3Valeur.selectedItem.label == "l'addition")
				{
					// nombreBase devient une belle division.
					nombreBase = nombreApresLaValeur * nombreApresLaValeur;
					
					// Formulation de la question.
					question = nombreBase + " / " + nombreApresLaValeur + " - " + nombreApresLaValeur2Moin + " + " + nombreApresLaValeur3 + " + " + nombreApresLaValeur4Moin + " = ";
					
					// Calcule la réponse.
					reponse = nombreBase / nombreApresLaValeur - nombreApresLaValeur2 + nombreApresLaValeur3 + nombreApresLaValeur4;
			
				}
				
				// L'opération mathématique de la multiplication
				if (cbValeur.selectedItem.label == "la multiplication" && cbUneValeur.selectedItem.label == "la multiplication" && cb2Valeur.selectedItem.label == "la multiplication" && cb3Valeur.selectedItem.label == "l'addition")
				{
					// Formulation de la question.
					question = nombreBase + " x " + nombreApresLaValeur + " x " + nombreApresLaValeur2Moin + " x " + nombreApresLaValeur3 + " + " + nombreApresLaValeur4Moin + " = ";
					
					// Calcule la réponse.
					reponse = nombreBase * nombreApresLaValeur * nombreApresLaValeur2 * nombreApresLaValeur3 + nombreApresLaValeur4;
					
				}
				
				// L'opération mathématique de la multiplication
				else if (cbValeur.selectedItem.label == "la multiplication" && cbUneValeur.selectedItem.label == "la multiplication" && cb2Valeur.selectedItem.label == "l'addition" && cb3Valeur.selectedItem.label == "l'addition")
				{
					// Formulation de la question.
					question = nombreBase + " x " + nombreApresLaValeur + " x " + nombreApresLaValeur2Moin + " + " + nombreApresLaValeur3 + " + " + nombreApresLaValeur4Moin + " = ";
					
					// Calcule la réponse.
					reponse = nombreBase * nombreApresLaValeur * nombreApresLaValeur2 + nombreApresLaValeur3 + nombreApresLaValeur4;
					
				}
				
				// L'opération mathématique de la multiplication
				else if (cbValeur.selectedItem.label == "la multiplication" && cbUneValeur.selectedItem.label == "la multiplication" && cb2Valeur.selectedItem.label == "la soustraction" && cb3Valeur.selectedItem.label == "l'addition")
				{
					// Formulation de la question.
					question = nombreBase + " x " + nombreApresLaValeur + " x " + nombreApresLaValeur2Moin + " - " + nombreApresLaValeur3 + " + " + nombreApresLaValeur4Moin + " = ";
					
					// Calcule la réponse.
					reponse = nombreBase * nombreApresLaValeur * nombreApresLaValeur2 - nombreApresLaValeur3 + nombreApresLaValeur4;
					
				}
				
				// L'opération mathématique de la multiplication
				else if (cbValeur.selectedItem.label == "la multiplication" && cbUneValeur.selectedItem.label == "l'addition" && cb2Valeur.selectedItem.label == "l'addition" && cb3Valeur.selectedItem.label == "l'addition")
				{
					// Formulation de la question.
					question = nombreBase + " x " + nombreApresLaValeur + " + " + nombreApresLaValeur2Moin + " + " + nombreApresLaValeur3 + " + " + nombreApresLaValeur4Moin + " = ";
					
					// Calcule la réponse.
					reponse = nombreBase * nombreApresLaValeur + nombreApresLaValeur2 + nombreApresLaValeur3 + nombreApresLaValeur4;
			
				}
				
				// L'opération mathématique de la multiplication
				else if (cbValeur.selectedItem.label == "la multiplication" && cbUneValeur.selectedItem.label == "l'addition" && cb2Valeur.selectedItem.label == "la multiplication" && cb3Valeur.selectedItem.label == "l'addition")
				{
					// Formulation de la question.
					question = nombreBase + " x " + nombreApresLaValeur + " + " + nombreApresLaValeur2Moin + " x " + nombreApresLaValeur3 + " + " + nombreApresLaValeur4Moin + " = ";
					
					// Calcule la réponse.
					reponse = nombreBase * nombreApresLaValeur + nombreApresLaValeur2 * nombreApresLaValeur3 + nombreApresLaValeur4;
			
				}
				
				// L'opération mathématique de la multiplication
				else if (cbValeur.selectedItem.label == "la multiplication" && cbUneValeur.selectedItem.label == "l'addition" && cb2Valeur.selectedItem.label == "la soustraction" && cb3Valeur.selectedItem.label == "l'addition")
				{
					// Formulation de la question.
					question = nombreBase + " x " + nombreApresLaValeur + " + " + nombreApresLaValeur2Moin + " - " + nombreApresLaValeur3 + " + " + nombreApresLaValeur4Moin + " = ";
					
					// Calcule la réponse.
					reponse = nombreBase * nombreApresLaValeur + nombreApresLaValeur2 - nombreApresLaValeur3 + nombreApresLaValeur4;
			
				}
				
				// L'opération mathématique de la multiplication
				else if (cbValeur.selectedItem.label == "la multiplication" && cbUneValeur.selectedItem.label == "la soustraction" && cb2Valeur.selectedItem.label == "la soustraction" && cb3Valeur.selectedItem.label == "l'addition")
				{
					// Formulation de la question.
					question = nombreBase + " x " + nombreApresLaValeur + " - " + nombreApresLaValeur2Moin + " - " + nombreApresLaValeur3 + " + " + nombreApresLaValeur4Moin + " = ";
					
					// Calcule la réponse.
					reponse = nombreBase * nombreApresLaValeur - nombreApresLaValeur2 - nombreApresLaValeur3 + nombreApresLaValeur4;
			
				}
				
				// L'opération mathématique de la multiplication
				else if (cbValeur.selectedItem.label == "la multiplication" && cbUneValeur.selectedItem.label == "la soustraction" && cb2Valeur.selectedItem.label == "la multiplication" && cb3Valeur.selectedItem.label == "l'addition")
				{
					// Formulation de la question.
					question = nombreBase + " x " + nombreApresLaValeur + " - " + nombreApresLaValeur2Moin + " x " + nombreApresLaValeur3 + " + " + nombreApresLaValeur4Moin + " = ";
					
					// Calcule la réponse.
					reponse = nombreBase * nombreApresLaValeur - nombreApresLaValeur2 * nombreApresLaValeur3 + nombreApresLaValeur4;
			
				}
				
				// L'opération mathématique de la multiplication
				else if (cbValeur.selectedItem.label == "la multiplication" && cbUneValeur.selectedItem.label == "la soustraction" && cb2Valeur.selectedItem.label == "l'addition" && cb3Valeur.selectedItem.label == "l'addition")
				{
					// Formulation de la question.
					question = nombreBase + " x " + nombreApresLaValeur + " - " + nombreApresLaValeur2Moin + " + " + nombreApresLaValeur3 + " + " + nombreApresLaValeur4Moin + " = ";
					
					// Calcule la réponse.
					reponse = nombreBase * nombreApresLaValeur - nombreApresLaValeur2 + nombreApresLaValeur3 + nombreApresLaValeur4;
			
				}
				
				// L'opération mathématique de l'addition
				if (cbValeur.selectedItem.label == "l'addition" && cbUneValeur.selectedItem.label == "la multiplication" && cb2Valeur.selectedItem.label == "la multiplication" && cb3Valeur.selectedItem.label == "l'addition")
				{
					// Formulation de la question.
					question = nombreBase + " + " + nombreApresLaValeur + " x " + nombreApresLaValeur2Moin + " x " + nombreApresLaValeur3 + " + " + nombreApresLaValeur4Moin + " = ";
					
					// Calcule la réponse.
					reponse = nombreBase + nombreApresLaValeur * nombreApresLaValeur2 * nombreApresLaValeur3 + nombreApresLaValeur4;
					
				}
				
				// L'opération mathématique de l'addition
				else if (cbValeur.selectedItem.label == "l'addition" && cbUneValeur.selectedItem.label == "la multiplication" && cb2Valeur.selectedItem.label == "l'addition" && cb3Valeur.selectedItem.label == "l'addition")
				{
					// Formulation de la question.
					question = nombreBase + " + " + nombreApresLaValeur + " x " + nombreApresLaValeur2Moin + " + " + nombreApresLaValeur3 + " + " + nombreApresLaValeur4Moin + " = ";
					
					// Calcule la réponse.
					reponse = nombreBase + nombreApresLaValeur * nombreApresLaValeur2 + nombreApresLaValeur3 + nombreApresLaValeur4;
					
				}
				
				// L'opération mathématique de l'addition
				else if (cbValeur.selectedItem.label == "l'addition" && cbUneValeur.selectedItem.label == "la multiplication" && cb2Valeur.selectedItem.label == "la soustraction" && cb3Valeur.selectedItem.label == "l'addition")
				{
					// Formulation de la question.
					question = nombreBase + " + " + nombreApresLaValeur + " x " + nombreApresLaValeur2Moin + " - " + nombreApresLaValeur3 + " + " + nombreApresLaValeur4Moin + " = ";
					
					// Calcule la réponse.
					reponse = nombreBase + nombreApresLaValeur * nombreApresLaValeur2 - nombreApresLaValeur3 + nombreApresLaValeur4;
					
				}
				
				// L'opération mathématique de l'addition
				else if (cbValeur.selectedItem.label == "l'addition" && cbUneValeur.selectedItem.label == "l'addition" && cb2Valeur.selectedItem.label == "l'addition" && cb3Valeur.selectedItem.label == "l'addition")
				{
					// Formulation de la question.
					question = nombreBase + " + " + nombreApresLaValeur + " + " + nombreApresLaValeur2Moin + " + " + nombreApresLaValeur3 + " + " + nombreApresLaValeur4Moin + " = ";
					
					// Calcule la réponse.
					reponse = nombreBase + nombreApresLaValeur + nombreApresLaValeur2 + nombreApresLaValeur3 + nombreApresLaValeur4;
			
				}
				
				// L'opération mathématique de l'addition
				else if (cbValeur.selectedItem.label == "l'addition" && cbUneValeur.selectedItem.label == "l'addition" && cb2Valeur.selectedItem.label == "la multiplication" && cb3Valeur.selectedItem.label == "l'addition")
				{
					// Formulation de la question.
					question = nombreBase + " + " + nombreApresLaValeur + " + " + nombreApresLaValeur2Moin + " x " + nombreApresLaValeur3 + " + " + nombreApresLaValeur4Moin + " = ";
					
					// Calcule la réponse.
					reponse = nombreBase + nombreApresLaValeur + nombreApresLaValeur2 * nombreApresLaValeur3 + nombreApresLaValeur4;
			
				}
				
				// L'opération mathématique de l'addition
				else if (cbValeur.selectedItem.label == "l'addition" && cbUneValeur.selectedItem.label == "l'addition" && cb2Valeur.selectedItem.label == "la soustraction" && cb3Valeur.selectedItem.label == "l'addition")
				{
					// Formulation de la question.
					question = nombreBase + " + " + nombreApresLaValeur + " + " + nombreApresLaValeur2Moin + " - " + nombreApresLaValeur3 + " + " + nombreApresLaValeur4Moin + " = ";
					
					// Calcule la réponse.
					reponse = nombreBase * nombreApresLaValeur + nombreApresLaValeur2 - nombreApresLaValeur3 + nombreApresLaValeur4;
			
				}
				
				// L'opération mathématique de l'addition
				else if (cbValeur.selectedItem.label == "l'addition" && cbUneValeur.selectedItem.label == "la soustraction" && cb2Valeur.selectedItem.label == "la soustraction" && cb3Valeur.selectedItem.label == "l'addition")
				{
					// Formulation de la question.
					question = nombreBase + " + " + nombreApresLaValeur + " - " + nombreApresLaValeur2Moin + " - " + nombreApresLaValeur3 + " + " + nombreApresLaValeur4Moin + " = ";
					
					// Calcule la réponse.
					reponse = nombreBase * nombreApresLaValeur - nombreApresLaValeur2 - nombreApresLaValeur3 + nombreApresLaValeur4;
			
				}
				
				// L'opération mathématique de l'addition
				else if (cbValeur.selectedItem.label == "l'addition" && cbUneValeur.selectedItem.label == "la soustraction" && cb2Valeur.selectedItem.label == "la multiplication" && cb3Valeur.selectedItem.label == "l'addition")
				{
					// Formulation de la question.
					question = nombreBase + " + " + nombreApresLaValeur + " - " + nombreApresLaValeur2Moin + " x " + nombreApresLaValeur3 + " + " + nombreApresLaValeur4Moin + " = ";
					
					// Calcule la réponse.
					reponse = nombreBase + nombreApresLaValeur - nombreApresLaValeur2 * nombreApresLaValeur3 + nombreApresLaValeur4;
			
				}
				
				// L'opération mathématique de l'addition
				else if (cbValeur.selectedItem.label == "l'addition" && cbUneValeur.selectedItem.label == "la soustraction" && cb2Valeur.selectedItem.label == "l'addition" && cb3Valeur.selectedItem.label == "l'addition")
				{
					// Formulation de la question.
					question = nombreBase + " + " + nombreApresLaValeur + " - " + nombreApresLaValeur2Moin + " + " + nombreApresLaValeur3 + " + " + nombreApresLaValeur4Moin + " = ";
					
					// Calcule la réponse.
					reponse = nombreBase + nombreApresLaValeur - nombreApresLaValeur2 + nombreApresLaValeur3 + nombreApresLaValeur4;
			
				}
				
				// L'opération mathématique de la soustraction
				if (cbValeur.selectedItem.label == "la soustraction" && cbUneValeur.selectedItem.label == "la multiplication" && cb2Valeur.selectedItem.label == "la multiplication" && cb3Valeur.selectedItem.label == "l'addition")
				{
					// Formulation de la question.
					question = nombreBase + " - " + nombreApresLaValeur + " x " + nombreApresLaValeur2Moin + " x " + nombreApresLaValeur3 + " + " + nombreApresLaValeur4Moin + " = ";
					
					// Calcule la réponse.
					reponse = nombreBase - nombreApresLaValeur * nombreApresLaValeur2 * nombreApresLaValeur3 + nombreApresLaValeur4;
					
				}
				
				// L'opération mathématique de la soustraction
				else if (cbValeur.selectedItem.label == "la soustraction" && cbUneValeur.selectedItem.label == "la multiplication" && cb2Valeur.selectedItem.label == "l'addition" && cb3Valeur.selectedItem.label == "l'addition")
				{
					// Formulation de la question.
					question = nombreBase + " - " + nombreApresLaValeur + " x " + nombreApresLaValeur2Moin + " + " + nombreApresLaValeur3 + " + " + nombreApresLaValeur4Moin + " = ";
					
					// Calcule la réponse.
					reponse = nombreBase - nombreApresLaValeur * nombreApresLaValeur2 + nombreApresLaValeur3 + nombreApresLaValeur4;
					
				}
				
				// L'opération mathématique de la soustraction
				else if (cbValeur.selectedItem.label == "la soustraction" && cbUneValeur.selectedItem.label == "la multiplication" && cb2Valeur.selectedItem.label == "la soustraction" && cb3Valeur.selectedItem.label == "l'addition")
				{
					// Formulation de la question.
					question = nombreBase + " - " + nombreApresLaValeur + " x " + nombreApresLaValeur2Moin + " - " + nombreApresLaValeur3 + " + " + nombreApresLaValeur4Moin + " = ";
					
					// Calcule la réponse.
					reponse = nombreBase - nombreApresLaValeur * nombreApresLaValeur2 - nombreApresLaValeur3 + nombreApresLaValeur4;
					
				}
				
				// L'opération mathématique de la soustraction
				else if (cbValeur.selectedItem.label == "la soustraction" && cbUneValeur.selectedItem.label == "l'addition" && cb2Valeur.selectedItem.label == "l'addition" && cb3Valeur.selectedItem.label == "l'addition")
				{
					// Formulation de la question.
					question = nombreBase + " - " + nombreApresLaValeur + " + " + nombreApresLaValeur2Moin + " + " + nombreApresLaValeur3 + " + " + nombreApresLaValeur4Moin + " = ";
					
					// Calcule la réponse.
					reponse = nombreBase - nombreApresLaValeur + nombreApresLaValeur2 + nombreApresLaValeur3 + nombreApresLaValeur4;
			
				}
				
				// L'opération mathématique de la soustraction
				else if (cbValeur.selectedItem.label == "la soustraction" && cbUneValeur.selectedItem.label == "l'addition" && cb2Valeur.selectedItem.label == "la multiplication" && cb3Valeur.selectedItem.label == "l'addition")
				{
					// Formulation de la question.
					question = nombreBase + " - " + nombreApresLaValeur + " + " + nombreApresLaValeur2Moin + " x " + nombreApresLaValeur3 + " + " + nombreApresLaValeur4Moin + " = ";
					
					// Calcule la réponse.
					reponse = nombreBase - nombreApresLaValeur + nombreApresLaValeur2 * nombreApresLaValeur3 + nombreApresLaValeur4;
			
				}
				
				// L'opération mathématique de la soustraction
				else if (cbValeur.selectedItem.label == "la soustraction" && cbUneValeur.selectedItem.label == "l'addition" && cb2Valeur.selectedItem.label == "la soustraction" && cb3Valeur.selectedItem.label == "l'addition")
				{
					// Formulation de la question.
					question = nombreBase + " - " + nombreApresLaValeur + " + " + nombreApresLaValeur2Moin + " - " + nombreApresLaValeur3 + " + " + nombreApresLaValeur4Moin + " = ";
					
					// Calcule la réponse.
					reponse = nombreBase - nombreApresLaValeur + nombreApresLaValeur2 - nombreApresLaValeur3 + nombreApresLaValeur4;
			
				}
				
				// L'opération mathématique de la soustraction
				else if (cbValeur.selectedItem.label == "la soustraction" && cbUneValeur.selectedItem.label == "la soustraction" && cb2Valeur.selectedItem.label == "la soustraction" && cb3Valeur.selectedItem.label == "l'addition")
				{
					// Formulation de la question.
					question = nombreBase + " - " + nombreApresLaValeur + " - " + nombreApresLaValeur2Moin + " - " + nombreApresLaValeur3 + " + " + nombreApresLaValeur4Moin + " = ";
					
					// Calcule la réponse.
					reponse = nombreBase - nombreApresLaValeur - nombreApresLaValeur2 - nombreApresLaValeur3 + nombreApresLaValeur4;
			
				}
				
				// L'opération mathématique de la soustraction
				else if (cbValeur.selectedItem.label == "la soustraction" && cbUneValeur.selectedItem.label == "la soustraction" && cb2Valeur.selectedItem.label == "la multiplication" && cb3Valeur.selectedItem.label == "l'addition")
				{
					// Formulation de la question.
					question = nombreBase + " - " + nombreApresLaValeur + " - " + nombreApresLaValeur2Moin + " x " + nombreApresLaValeur3 + " + " + nombreApresLaValeur4Moin + " = ";
					
					// Calcule la réponse.
					reponse = nombreBase - nombreApresLaValeur - nombreApresLaValeur2 * nombreApresLaValeur3 + nombreApresLaValeur4;
			
				}
				
				// L'opération mathématique de la soustraction
				else if (cbValeur.selectedItem.label == "la soustraction" && cbUneValeur.selectedItem.label == "la soustraction" && cb2Valeur.selectedItem.label == "l'addition" && cb3Valeur.selectedItem.label == "l'addition")
				{
					// Formulation de la question.
					question = nombreBase + " - " + nombreApresLaValeur + " - " + nombreApresLaValeur2Moin + " + " + nombreApresLaValeur3 + " + " + nombreApresLaValeur4Moin + " = ";
					
					// Calcule la réponse.
					reponse = nombreBase - nombreApresLaValeur - nombreApresLaValeur2 + nombreApresLaValeur3 + nombreApresLaValeur4;
			
				}

				// L'opération mathématique de la division
				if (cbValeur.selectedItem.label == "la division" && cbUneValeur.selectedItem.label == "la multiplication" && cb2Valeur.selectedItem.label == "la multiplication" && cb3Valeur.selectedItem.label == "la soustraction")
				{
					// nombreBase devient une belle division.
					nombreBase = nombreApresLaValeur * nombreApresLaValeur;
					
					// Formulation de la question.
					question = nombreBase + " / " + nombreApresLaValeur + " x " + nombreApresLaValeur2Moin + " x " + nombreApresLaValeur3 + " - " + nombreApresLaValeur4Moin + " = ";
					
					// Calcule la réponse.
					reponse = nombreBase / nombreApresLaValeur * nombreApresLaValeur2 * nombreApresLaValeur3 - nombreApresLaValeur4;
					
				}
				
				// L'opération mathématique de la division
				else if (cbValeur.selectedItem.label == "la division" && cbUneValeur.selectedItem.label == "la multiplication" && cb2Valeur.selectedItem.label == "l'addition" && cb3Valeur.selectedItem.label == "la soustraction")
				{
					// nombreBase devient une belle division.
					nombreBase = nombreApresLaValeur * nombreApresLaValeur;
					
					// Formulation de la question.
					question = nombreBase + " / " + nombreApresLaValeur + " x " + nombreApresLaValeur2Moin + " + " + nombreApresLaValeur3 + " - " + nombreApresLaValeur4Moin + " = ";
					
					// Calcule la réponse.
					reponse = nombreBase / nombreApresLaValeur * nombreApresLaValeur2 + nombreApresLaValeur3 - nombreApresLaValeur4;
					
				}
				
				// L'opération mathématique de la division
				else if (cbValeur.selectedItem.label == "la division" && cbUneValeur.selectedItem.label == "la multiplication" && cb2Valeur.selectedItem.label == "la soustraction" && cb3Valeur.selectedItem.label == "la soustraction")
				{
					// nombreBase devient une belle division.
					nombreBase = nombreApresLaValeur * nombreApresLaValeur;
					
					// Formulation de la question.
					question = nombreBase + " / " + nombreApresLaValeur + " x " + nombreApresLaValeur2Moin + " - " + nombreApresLaValeur3 + " - " + nombreApresLaValeur4Moin + " = ";
					
					// Calcule la réponse.
					reponse = nombreBase / nombreApresLaValeur * nombreApresLaValeur2 - nombreApresLaValeur3 - nombreApresLaValeur4;
					
				}
				
				// L'opération mathématique de la division
				else if (cbValeur.selectedItem.label == "la division" && cbUneValeur.selectedItem.label == "l'addition" && cb2Valeur.selectedItem.label == "l'addition" && cb3Valeur.selectedItem.label == "la soustraction")
				{
					// nombreBase devient une belle division.
					nombreBase = nombreApresLaValeur * nombreApresLaValeur;
					
					// Formulation de la question.
					question = nombreBase + " / " + nombreApresLaValeur + " + " + nombreApresLaValeur2Moin + " + " + nombreApresLaValeur3 + " - " + nombreApresLaValeur4Moin + " = ";
					
					// Calcule la réponse.
					reponse = nombreBase / nombreApresLaValeur + nombreApresLaValeur2 + nombreApresLaValeur3 - nombreApresLaValeur4;
			
				}
				
				// L'opération mathématique de la division
				else if (cbValeur.selectedItem.label == "la division" && cbUneValeur.selectedItem.label == "l'addition" && cb2Valeur.selectedItem.label == "la multiplication" && cb3Valeur.selectedItem.label == "la soustraction")
				{
					// nombreBase devient une belle division.
					nombreBase = nombreApresLaValeur * nombreApresLaValeur;
					
					// Formulation de la question.
					question = nombreBase + " / " + nombreApresLaValeur + " + " + nombreApresLaValeur2Moin + " x " + nombreApresLaValeur3 + " - " + nombreApresLaValeur4Moin + " = ";
					
					// Calcule la réponse.
					reponse = nombreBase / nombreApresLaValeur + nombreApresLaValeur2 * nombreApresLaValeur3 - nombreApresLaValeur4;
			
				}
				
				// L'opération mathématique de la division
				else if (cbValeur.selectedItem.label == "la division" && cbUneValeur.selectedItem.label == "l'addition" && cb2Valeur.selectedItem.label == "la soustraction" && cb3Valeur.selectedItem.label == "la soustraction")
				{
					// nombreBase devient une belle division.
					nombreBase = nombreApresLaValeur * nombreApresLaValeur;
					
					// Formulation de la question.
					question = nombreBase + " / " + nombreApresLaValeur + " + " + nombreApresLaValeur2Moin + " - " + nombreApresLaValeur3 + " - " + nombreApresLaValeur4Moin + " = ";
					
					// Calcule la réponse.
					reponse = nombreBase / nombreApresLaValeur + nombreApresLaValeur2 - nombreApresLaValeur3 - nombreApresLaValeur4;
			
				}
				
				// L'opération mathématique de la division
				else if (cbValeur.selectedItem.label == "la division" && cbUneValeur.selectedItem.label == "la soustraction" && cb2Valeur.selectedItem.label == "la soustraction" && cb3Valeur.selectedItem.label == "la soustraction")
				{
					// nombreBase devient une belle division.
					nombreBase = nombreApresLaValeur * nombreApresLaValeur;
					
					// Formulation de la question.
					question = nombreBase + " / " + nombreApresLaValeur + " - " + nombreApresLaValeur2Moin + " - " + nombreApresLaValeur3 + " - " + nombreApresLaValeur4Moin + " = ";
					
					// Calcule la réponse.
					reponse = nombreBase / nombreApresLaValeur - nombreApresLaValeur2 - nombreApresLaValeur3 - nombreApresLaValeur4;
			
				}
				
				// L'opération mathématique de la division
				else if (cbValeur.selectedItem.label == "la division" && cbUneValeur.selectedItem.label == "la soustraction" && cb2Valeur.selectedItem.label == "la multiplication" && cb3Valeur.selectedItem.label == "la soustraction")
				{
					// nombreBase devient une belle division.
					nombreBase = nombreApresLaValeur * nombreApresLaValeur;
					
					// Formulation de la question.
					question = nombreBase + " / " + nombreApresLaValeur + " - " + nombreApresLaValeur2Moin + " x " + nombreApresLaValeur3 + " - " + nombreApresLaValeur4Moin + " = ";
					
					// Calcule la réponse.
					reponse = nombreBase / nombreApresLaValeur - nombreApresLaValeur2 * nombreApresLaValeur3 - nombreApresLaValeur4;
			
				}
				
				// L'opération mathématique de la division
				else if (cbValeur.selectedItem.label == "la division" && cbUneValeur.selectedItem.label == "la soustraction" && cb2Valeur.selectedItem.label == "l'addition" && cb3Valeur.selectedItem.label == "la soustraction")
				{
					// nombreBase devient une belle division.
					nombreBase = nombreApresLaValeur * nombreApresLaValeur;
					
					// Formulation de la question.
					question = nombreBase + " / " + nombreApresLaValeur + " - " + nombreApresLaValeur2Moin + " + " + nombreApresLaValeur3 + " - " + nombreApresLaValeur4Moin + " = ";
					
					// Calcule la réponse.
					reponse = nombreBase / nombreApresLaValeur - nombreApresLaValeur2 + nombreApresLaValeur3 - nombreApresLaValeur4;
			
				}
				
				// L'opération mathématique de la multiplication
				if (cbValeur.selectedItem.label == "la multiplication" && cbUneValeur.selectedItem.label == "la multiplication" && cb2Valeur.selectedItem.label == "la multiplication" && cb3Valeur.selectedItem.label == "la soustraction")
				{
					// Formulation de la question.
					question = nombreBase + " x " + nombreApresLaValeur + " x " + nombreApresLaValeur2Moin + " x " + nombreApresLaValeur3 + " - " + nombreApresLaValeur4Moin + " = ";
					
					// Calcule la réponse.
					reponse = nombreBase * nombreApresLaValeur * nombreApresLaValeur2 * nombreApresLaValeur3 - nombreApresLaValeur4;
					
				}
				
				// L'opération mathématique de la multiplication
				else if (cbValeur.selectedItem.label == "la multiplication" && cbUneValeur.selectedItem.label == "la multiplication" && cb2Valeur.selectedItem.label == "l'addition" && cb3Valeur.selectedItem.label == "la soustraction")
				{
					// Formulation de la question.
					question = nombreBase + " x " + nombreApresLaValeur + " x " + nombreApresLaValeur2Moin + " + " + nombreApresLaValeur3 + " - " + nombreApresLaValeur4Moin + " = ";
					
					// Calcule la réponse.
					reponse = nombreBase * nombreApresLaValeur * nombreApresLaValeur2 + nombreApresLaValeur3 - nombreApresLaValeur4;
					
				}
				
				// L'opération mathématique de la multiplication
				else if (cbValeur.selectedItem.label == "la multiplication" && cbUneValeur.selectedItem.label == "la multiplication" && cb2Valeur.selectedItem.label == "la soustraction" && cb3Valeur.selectedItem.label == "la soustraction")
				{
					// Formulation de la question.
					question = nombreBase + " x " + nombreApresLaValeur + " x " + nombreApresLaValeur2Moin + " - " + nombreApresLaValeur3 + " - " + nombreApresLaValeur4Moin + " = ";
					
					// Calcule la réponse.
					reponse = nombreBase * nombreApresLaValeur * nombreApresLaValeur2 - nombreApresLaValeur3 - nombreApresLaValeur4;
					
				}
				
				// L'opération mathématique de la multiplication
				else if (cbValeur.selectedItem.label == "la multiplication" && cbUneValeur.selectedItem.label == "l'addition" && cb2Valeur.selectedItem.label == "l'addition" && cb3Valeur.selectedItem.label == "la soustraction")
				{
					// Formulation de la question.
					question = nombreBase + " x " + nombreApresLaValeur + " + " + nombreApresLaValeur2Moin + " + " + nombreApresLaValeur3 + " - " + nombreApresLaValeur4Moin + " = ";
					
					// Calcule la réponse.
					reponse = nombreBase * nombreApresLaValeur + nombreApresLaValeur2 + nombreApresLaValeur3 - nombreApresLaValeur4;
			
				}
				
				// L'opération mathématique de la multiplication
				else if (cbValeur.selectedItem.label == "la multiplication" && cbUneValeur.selectedItem.label == "l'addition" && cb2Valeur.selectedItem.label == "la multiplication" && cb3Valeur.selectedItem.label == "la soustraction")
				{
					// Formulation de la question.
					question = nombreBase + " x " + nombreApresLaValeur + " + " + nombreApresLaValeur2Moin + " x " + nombreApresLaValeur3 + " - " + nombreApresLaValeur4Moin + " = ";
					
					// Calcule la réponse.
					reponse = nombreBase * nombreApresLaValeur + nombreApresLaValeur2 * nombreApresLaValeur3 - nombreApresLaValeur4;
			
				}
				
				// L'opération mathématique de la multiplication
				else if (cbValeur.selectedItem.label == "la multiplication" && cbUneValeur.selectedItem.label == "l'addition" && cb2Valeur.selectedItem.label == "la soustraction" && cb3Valeur.selectedItem.label == "la soustraction")
				{
					// Formulation de la question.
					question = nombreBase + " x " + nombreApresLaValeur + " + " + nombreApresLaValeur2Moin + " - " + nombreApresLaValeur3 + " - " + nombreApresLaValeur4Moin + " = ";
					
					// Calcule la réponse.
					reponse = nombreBase * nombreApresLaValeur + nombreApresLaValeur2 - nombreApresLaValeur3 - nombreApresLaValeur4;
			
				}
				
				// L'opération mathématique de la multiplication
				else if (cbValeur.selectedItem.label == "la multiplication" && cbUneValeur.selectedItem.label == "la soustraction" && cb2Valeur.selectedItem.label == "la soustraction" && cb3Valeur.selectedItem.label == "la soustraction")
				{
					// Formulation de la question.
					question = nombreBase + " x " + nombreApresLaValeur + " - " + nombreApresLaValeur2Moin + " - " + nombreApresLaValeur3 + " - " + nombreApresLaValeur4Moin + " = ";
					
					// Calcule la réponse.
					reponse = nombreBase * nombreApresLaValeur - nombreApresLaValeur2 - nombreApresLaValeur3 - nombreApresLaValeur4;
			
				}
				
				// L'opération mathématique de la multiplication
				else if (cbValeur.selectedItem.label == "la multiplication" && cbUneValeur.selectedItem.label == "la soustraction" && cb2Valeur.selectedItem.label == "la multiplication" && cb3Valeur.selectedItem.label == "la soustraction")
				{
					// Formulation de la question.
					question = nombreBase + " x " + nombreApresLaValeur + " - " + nombreApresLaValeur2Moin + " x " + nombreApresLaValeur3 + " - " + nombreApresLaValeur4Moin + " = ";
					
					// Calcule la réponse.
					reponse = nombreBase * nombreApresLaValeur - nombreApresLaValeur2 * nombreApresLaValeur3 - nombreApresLaValeur4;
			
				}
				
				// L'opération mathématique de la multiplication
				else if (cbValeur.selectedItem.label == "la multiplication" && cbUneValeur.selectedItem.label == "la soustraction" && cb2Valeur.selectedItem.label == "l'addition" && cb3Valeur.selectedItem.label == "la soustraction")
				{
					// Formulation de la question.
					question = nombreBase + " x " + nombreApresLaValeur + " - " + nombreApresLaValeur2Moin + " + " + nombreApresLaValeur3 + " - " + nombreApresLaValeur4Moin + " = ";
					
					// Calcule la réponse.
					reponse = nombreBase * nombreApresLaValeur - nombreApresLaValeur2 + nombreApresLaValeur3 - nombreApresLaValeur4;
			
				}

				// L'opération mathématique de l'addition
				if (cbValeur.selectedItem.label == "l'addition" && cbUneValeur.selectedItem.label == "la multiplication" && cb2Valeur.selectedItem.label == "la multiplication" && cb3Valeur.selectedItem.label == "la soustraction")
				{
					// Formulation de la question.
					question = nombreBase + " + " + nombreApresLaValeur + " x " + nombreApresLaValeur2Moin + " x " + nombreApresLaValeur3 + " - " + nombreApresLaValeur4Moin + " = ";
					
					// Calcule la réponse.
					reponse = nombreBase + nombreApresLaValeur * nombreApresLaValeur2 * nombreApresLaValeur3 - nombreApresLaValeur4;
					
				}
				
				// L'opération mathématique de l'addition
				else if (cbValeur.selectedItem.label == "l'addition" && cbUneValeur.selectedItem.label == "la multiplication" && cb2Valeur.selectedItem.label == "l'addition" && cb3Valeur.selectedItem.label == "la soustraction")
				{
					// Formulation de la question.
					question = nombreBase + " + " + nombreApresLaValeur + " x " + nombreApresLaValeur2Moin + " + " + nombreApresLaValeur3 + " - " + nombreApresLaValeur4Moin + " = ";
					
					// Calcule la réponse.
					reponse = nombreBase + nombreApresLaValeur * nombreApresLaValeur2 + nombreApresLaValeur3 - nombreApresLaValeur4;
					
				}
				
				// L'opération mathématique de l'addition
				else if (cbValeur.selectedItem.label == "l'addition" && cbUneValeur.selectedItem.label == "la multiplication" && cb2Valeur.selectedItem.label == "la soustraction" && cb3Valeur.selectedItem.label == "la soustraction")
				{
					// Formulation de la question.
					question = nombreBase + " + " + nombreApresLaValeur + " x " + nombreApresLaValeur2Moin + " - " + nombreApresLaValeur3 + " - " + nombreApresLaValeur4Moin + " = ";
					
					// Calcule la réponse.
					reponse = nombreBase + nombreApresLaValeur * nombreApresLaValeur2 - nombreApresLaValeur3 - nombreApresLaValeur4;
					
				}
				
				// L'opération mathématique de l'addition
				else if (cbValeur.selectedItem.label == "l'addition" && cbUneValeur.selectedItem.label == "l'addition" && cb2Valeur.selectedItem.label == "l'addition" && cb3Valeur.selectedItem.label == "la soustraction")
				{
					// Formulation de la question.
					question = nombreBase + " + " + nombreApresLaValeur + " + " + nombreApresLaValeur2Moin + " + " + nombreApresLaValeur3 + " - " + nombreApresLaValeur4Moin + " = ";
					
					// Calcule la réponse.
					reponse = nombreBase + nombreApresLaValeur + nombreApresLaValeur2 + nombreApresLaValeur3 - nombreApresLaValeur4;
			
				}
				
				// L'opération mathématique de l'addition
				else if (cbValeur.selectedItem.label == "l'addition" && cbUneValeur.selectedItem.label == "l'addition" && cb2Valeur.selectedItem.label == "la multiplication" && cb3Valeur.selectedItem.label == "la soustraction")
				{
					// Formulation de la question.
					question = nombreBase + " + " + nombreApresLaValeur + " + " + nombreApresLaValeur2Moin + " x " + nombreApresLaValeur3 + " - " + nombreApresLaValeur4Moin + " = ";
					reponse = nombreBase + nombreApresLaValeur + nombreApresLaValeur2 * nombreApresLaValeur3 - nombreApresLaValeur4;
			
				}
				
				// L'opération mathématique de l'addition
				else if (cbValeur.selectedItem.label == "l'addition" && cbUneValeur.selectedItem.label == "l'addition" && cb2Valeur.selectedItem.label == "la soustraction" && cb3Valeur.selectedItem.label == "la soustraction")
				{
					// Formulation de la question.
					question = nombreBase + " + " + nombreApresLaValeur + " + " + nombreApresLaValeur2Moin + " - " + nombreApresLaValeur3 + " - " + nombreApresLaValeur4Moin + " = ";
					
					// Calcule la réponse.
					reponse = nombreBase * nombreApresLaValeur + nombreApresLaValeur2 - nombreApresLaValeur3 - nombreApresLaValeur4;
			
				}
				
				// L'opération mathématique de l'addition
				else if (cbValeur.selectedItem.label == "l'addition" && cbUneValeur.selectedItem.label == "la soustraction" && cb2Valeur.selectedItem.label == "la soustraction" && cb3Valeur.selectedItem.label == "la soustraction")
				{
					// Formulation de la question.
					question = nombreBase + " + " + nombreApresLaValeur + " - " + nombreApresLaValeur2Moin + " - " + nombreApresLaValeur3 + " - " + nombreApresLaValeur4Moin + " = ";
					
					// Calcule la réponse.
					reponse = nombreBase * nombreApresLaValeur - nombreApresLaValeur2 - nombreApresLaValeur3 - nombreApresLaValeur4;
			
				}
				
				// L'opération mathématique de l'addition
				else if (cbValeur.selectedItem.label == "l'addition" && cbUneValeur.selectedItem.label == "la soustraction" && cb2Valeur.selectedItem.label == "la multiplication" && cb3Valeur.selectedItem.label == "la soustraction")
				{
					// Formulation de la question.
					question = nombreBase + " + " + nombreApresLaValeur + " - " + nombreApresLaValeur2Moin + " x " + nombreApresLaValeur3 + " - " + nombreApresLaValeur4Moin + " = ";
					
					// Calcule la réponse.
					reponse = nombreBase + nombreApresLaValeur - nombreApresLaValeur2 * nombreApresLaValeur3 - nombreApresLaValeur4;
			
				}
				
				// L'opération mathématique de l'addition
				else if (cbValeur.selectedItem.label == "l'addition" && cbUneValeur.selectedItem.label == "la soustraction" && cb2Valeur.selectedItem.label == "l'addition" && cb3Valeur.selectedItem.label == "la soustraction")
				{
					// Formulation de la question.
					question = nombreBase + " + " + nombreApresLaValeur + " - " + nombreApresLaValeur2Moin + " + " + nombreApresLaValeur3 + " - " + nombreApresLaValeur4Moin + " = ";
					
					// Calcule la réponse.
					reponse = nombreBase + nombreApresLaValeur - nombreApresLaValeur2 + nombreApresLaValeur3 - nombreApresLaValeur4;
			
				}
				
				// L'opération mathématique de la soustraction
				if (cbValeur.selectedItem.label == "la soustraction" && cbUneValeur.selectedItem.label == "la multiplication" && cb2Valeur.selectedItem.label == "la multiplication" && cb3Valeur.selectedItem.label == "la soustraction")
				{
					// Formulation de la question.
					question = nombreBase + " - " + nombreApresLaValeur + " x " + nombreApresLaValeur2Moin + " x " + nombreApresLaValeur3 + " - " + nombreApresLaValeur4Moin + " = ";
					
					// Calcule la réponse.
					reponse = nombreBase - nombreApresLaValeur * nombreApresLaValeur2 * nombreApresLaValeur3 - nombreApresLaValeur4;
					
				}
				
				// L'opération mathématique de la soustraction
				else if (cbValeur.selectedItem.label == "la soustraction" && cbUneValeur.selectedItem.label == "la multiplication" && cb2Valeur.selectedItem.label == "l'addition" && cb3Valeur.selectedItem.label == "la soustraction")
				{
					// Formulation de la question.
					question = nombreBase + " - " + nombreApresLaValeur + " x " + nombreApresLaValeur2Moin + " + " + nombreApresLaValeur3 + " - " + nombreApresLaValeur4Moin + " = ";
					
					// Calcule la réponse.
					reponse = nombreBase - nombreApresLaValeur * nombreApresLaValeur2 + nombreApresLaValeur3 - nombreApresLaValeur4;
					
				}
				
				// L'opération mathématique de la soustraction
				else if (cbValeur.selectedItem.label == "la soustraction" && cbUneValeur.selectedItem.label == "la multiplication" && cb2Valeur.selectedItem.label == "la soustraction" && cb3Valeur.selectedItem.label == "la soustraction")
				{
					// Formulation de la question.
					question = nombreBase + " - " + nombreApresLaValeur + " x " + nombreApresLaValeur2Moin + " - " + nombreApresLaValeur3 + " - " + nombreApresLaValeur4Moin + " = ";
					
					// Calcule la réponse.
					reponse = nombreBase - nombreApresLaValeur * nombreApresLaValeur2 - nombreApresLaValeur3 - nombreApresLaValeur4;
					
				}
				
				// L'opération mathématique de la soustraction
				else if (cbValeur.selectedItem.label == "la soustraction" && cbUneValeur.selectedItem.label == "l'addition" && cb2Valeur.selectedItem.label == "l'addition" && cb3Valeur.selectedItem.label == "la soustraction")
				{
					// Formulation de la question.
					question = nombreBase + " - " + nombreApresLaValeur + " + " + nombreApresLaValeur2Moin + " + " + nombreApresLaValeur3 + " - " + nombreApresLaValeur4Moin + " = ";
					
					// Calcule la réponse.
					reponse = nombreBase - nombreApresLaValeur + nombreApresLaValeur2 + nombreApresLaValeur3 - nombreApresLaValeur4;
			
				}
				
				// L'opération mathématique de la soustraction
				else if (cbValeur.selectedItem.label == "la soustraction" && cbUneValeur.selectedItem.label == "l'addition" && cb2Valeur.selectedItem.label == "la multiplication" && cb3Valeur.selectedItem.label == "la soustraction")
				{
					// Formulation de la question.
					question = nombreBase + " - " + nombreApresLaValeur + " + " + nombreApresLaValeur2Moin + " x " + nombreApresLaValeur3 + " - " + nombreApresLaValeur4Moin + " = ";
					
					// Calcule la réponse.
					reponse = nombreBase - nombreApresLaValeur + nombreApresLaValeur2 * nombreApresLaValeur3 - nombreApresLaValeur4;
			
				}
				
				// L'opération mathématique de la soustraction
				else if (cbValeur.selectedItem.label == "la soustraction" && cbUneValeur.selectedItem.label == "l'addition" && cb2Valeur.selectedItem.label == "la soustraction" && cb3Valeur.selectedItem.label == "la soustraction")
				{
					// Formulation de la question.
					question = nombreBase + " - " + nombreApresLaValeur + " + " + nombreApresLaValeur2Moin + " - " + nombreApresLaValeur3 + " - " + nombreApresLaValeur4Moin + " = ";
					
					// Calcule la réponse.
					reponse = nombreBase - nombreApresLaValeur + nombreApresLaValeur2 - nombreApresLaValeur3 - nombreApresLaValeur4;
			
				}
				
				// L'opération mathématique de la soustraction
				else if (cbValeur.selectedItem.label == "la soustraction" && cbUneValeur.selectedItem.label == "la soustraction" && cb2Valeur.selectedItem.label == "la soustraction" && cb3Valeur.selectedItem.label == "la soustraction")
				{
					// Formulation de la question.
					question = nombreBase + " - " + nombreApresLaValeur + " - " + nombreApresLaValeur2Moin + " - " + nombreApresLaValeur3 + " - " + nombreApresLaValeur4Moin + " = ";
					
					// Calcule la réponse.
					reponse = nombreBase - nombreApresLaValeur - nombreApresLaValeur2 - nombreApresLaValeur3 - nombreApresLaValeur4;
			
				}
				
				// L'opération mathématique de la soustraction
				else if (cbValeur.selectedItem.label == "la soustraction" && cbUneValeur.selectedItem.label == "la soustraction" && cb2Valeur.selectedItem.label == "la multiplication" && cb3Valeur.selectedItem.label == "la soustraction")
				{
					// Formulation de la question.
					question = nombreBase + " - " + nombreApresLaValeur + " - " + nombreApresLaValeur2Moin + " x " + nombreApresLaValeur3 + " - " + nombreApresLaValeur4Moin + " = ";
					
					// Calcule la réponse.
					reponse = nombreBase - nombreApresLaValeur - nombreApresLaValeur2 * nombreApresLaValeur3 - nombreApresLaValeur4;
			
				}
				
				// L'opération mathématique de la soustraction
				else if (cbValeur.selectedItem.label == "la soustraction" && cbUneValeur.selectedItem.label == "la soustraction" && cb2Valeur.selectedItem.label == "l'addition" && cb3Valeur.selectedItem.label == "la soustraction")
				{
					// Formulation de la question.
					question = nombreBase + " - " + nombreApresLaValeur + " - " + nombreApresLaValeur2Moin + " + " + nombreApresLaValeur3 + " - " + nombreApresLaValeur4Moin + " = ";
					
					// Calcule la réponse.
					reponse = nombreBase - nombreApresLaValeur - nombreApresLaValeur2 + nombreApresLaValeur3 - nombreApresLaValeur4;
			
				}
				
				// L'opération mathématique du hasard.
				else if (cb3Valeur.selectedItem.label == "hasard")
				{
					// Chiffre aléatoire pour opération mathématiques.
					var hasardA = Math.floor(Math.random()* (1+ 2)) ;
					var hasardB = Math.floor(Math.random()* (1+ 2)) ;
					var hasardC = Math.floor(Math.random()* (1+ 2)) ;
					var hasardD = Math.floor(Math.random()* (1+ 2)) ;
					
					// L'opération mathématique de la multiplication et de la multiplication et de la multiplication et de la multiplication.
					if (hasardA==0 &&  hasardB==0 && hasardC==0 && hasardD==0){
						
						// Formulation de la question.
						question = nombreBase + " x " + nombreApresLaValeur + " x " + nombreApresLaValeur2Moin + " x " + nombreApresLaValeur3 + " x " + nombreApresLaValeur4Moin + " = ";
						
						// Calcule la réponse.
						reponse = nombreBase * nombreApresLaValeur * nombreApresLaValeur2 * nombreApresLaValeur3 * nombreApresLaValeur4;
					}
					
					// L'opération mathématique de l'addition et de la multiplication et de la multiplication et de la multiplication.
					else if (hasardA==1 &&  hasardB==0 && hasardC==0 && hasardD==0){
						
						// Formulation de la question.
						question = nombreBase + " + " + nombreApresLaValeur + " x " + nombreApresLaValeur2Moin + " x " + nombreApresLaValeur3 + " x " + nombreApresLaValeur4Moin + " = ";
						
						// Calcule la réponse.
						reponse = nombreBase + nombreApresLaValeur * nombreApresLaValeur2 * nombreApresLaValeur3 * nombreApresLaValeur4;
					}
					
					// L'opération mathématique de la soustraction et de la multiplication et de la multiplication et de la multiplication.
					else if (hasardA==2 &&  hasardB==0 && hasardC==0 && hasardD==0){
						
						// Formulation de la question.
						question = nombreBase + " - " + nombreApresLaValeur + " x " + nombreApresLaValeur2Moin + " x " + nombreApresLaValeur3 + " x " + nombreApresLaValeur4Moin + " = ";
						
						// Calcule la réponse.
						reponse = nombreBase - nombreApresLaValeur * nombreApresLaValeur2 * nombreApresLaValeur3 * nombreApresLaValeur4;
					}
					
					// L'opération mathématique de la multiplication et de l'addition et de la multiplication et de la multiplication.
					if (hasardA==0 &&  hasardB==1 && hasardC==0 && hasardD==0){
						
						// Formulation de la question.
						question = nombreBase + " x " + nombreApresLaValeur + " + " + nombreApresLaValeur2Moin + " x " + nombreApresLaValeur3 + " x " + nombreApresLaValeur4Moin + " = ";
						
						// Calcule la réponse.
						reponse = nombreBase * nombreApresLaValeur + nombreApresLaValeur2 * nombreApresLaValeur3 * nombreApresLaValeur4;
					}
					
					// L'opération mathématique de l'addition et de l'addition et de la multiplication et de la multiplication.
					else if (hasardA==1 &&  hasardB==1 && hasardC==0 && hasardD==0){
						
						// Formulation de la question.
						question = nombreBase + " + " + nombreApresLaValeur + " + " + nombreApresLaValeur2Moin + " x " + nombreApresLaValeur3 + " x " + nombreApresLaValeur4Moin + " = ";
						
						// Calcule la réponse.
						reponse = nombreBase + nombreApresLaValeur + nombreApresLaValeur2 * nombreApresLaValeur3 * nombreApresLaValeur4;
					}
					
					// L'opération mathématique de la soustraction et de l'addition et de la multiplication et de la multiplication.
					else if (hasardA==2 &&  hasardB==1 && hasardC==0 && hasardD==0){
						
						// Formulation de la question.
						question = nombreBase + " - " + nombreApresLaValeur + " + " + nombreApresLaValeur2Moin + " x " + nombreApresLaValeur3 + " x " + nombreApresLaValeur4Moin + " = ";
						
						// Calcule la réponse.
						reponse = nombreBase - nombreApresLaValeur + nombreApresLaValeur2 * nombreApresLaValeur3 * nombreApresLaValeur4;
					}
					
					// L'opération mathématique de la multiplication et de la soustraction et de la multiplication et de la multiplication.
					if (hasardA==0 &&  hasardB==2 && hasardC==0 && hasardD==0){
						
						// Formulation de la question.
						question = nombreBase + " x " + nombreApresLaValeur + " - " + nombreApresLaValeur2Moin + " x " + nombreApresLaValeur3 + " x " + nombreApresLaValeur4Moin + " = ";
						
						// Calcule la réponse.
						reponse = nombreBase * nombreApresLaValeur - nombreApresLaValeur2 * nombreApresLaValeur3 * nombreApresLaValeur4;
					}
					
					// L'opération mathématique de l'addition et de la soustraction et de la multiplication et de la multiplication.
					else if (hasardA==1 &&  hasardB==2 && hasardC==0 && hasardD==0){
						
						// Formulation de la question.
						question = nombreBase + " + " + nombreApresLaValeur + " - " + nombreApresLaValeur2Moin + " x " + nombreApresLaValeur3 + " x " + nombreApresLaValeur4Moin + " = ";
						
						// Calcule la réponse.
						reponse = nombreBase + nombreApresLaValeur - nombreApresLaValeur2 * nombreApresLaValeur3 * nombreApresLaValeur4;
					}
					
					// L'opération mathématique de la soustraction et de la soustraction et de la multiplication et de la multiplication.
					else if (hasardA==2 &&  hasardB==2 && hasardC==0 && hasardD==0){
						
						// Formulation de la question.
						question = nombreBase + " - " + nombreApresLaValeur + " - " + nombreApresLaValeur2Moin + " x " + nombreApresLaValeur3 + " x " + nombreApresLaValeur4Moin + " = ";
						
						// Calcule la réponse.
						reponse = nombreBase - nombreApresLaValeur - nombreApresLaValeur2 * nombreApresLaValeur3 * nombreApresLaValeur4;
					}
					
					// L'opération mathématique de la multiplication et de la multiplication et de l'addition et de la multiplication.
					if (hasardA==0 &&  hasardB==0 && hasardC==1 && hasardD==0){
						
						// Formulation de la question.
						question = nombreBase + " x " + nombreApresLaValeur + " x " + nombreApresLaValeur2Moin + " + " + nombreApresLaValeur3 + " x " + nombreApresLaValeur4Moin + " = ";
						
						// Calcule la réponse.
						reponse = nombreBase * nombreApresLaValeur * nombreApresLaValeur2 + nombreApresLaValeur3 * nombreApresLaValeur4;
					}
					
					// L'opération mathématique de l'addition et de la multiplication et de l'addition et de la multiplication.
					else if (hasardA==1 &&  hasardB==0 && hasardC==1 && hasardD==0){
						
						// Formulation de la question.
						question = nombreBase + " + " + nombreApresLaValeur + " x " + nombreApresLaValeur2Moin + " + " + nombreApresLaValeur3 + " x " + nombreApresLaValeur4Moin + " = ";
						
						// Calcule la réponse.
						reponse = nombreBase + nombreApresLaValeur * nombreApresLaValeur2 + nombreApresLaValeur3 * nombreApresLaValeur4;
					}
					
					// L'opération mathématique de la soustraction et de la multiplication et de l'addition et de la multiplication.
					else if (hasardA==2 &&  hasardB==0 && hasardC==1 && hasardD==0){
						
						// Formulation de la question.
						question = nombreBase + " - " + nombreApresLaValeur + " x " + nombreApresLaValeur2Moin + " + " + nombreApresLaValeur3 + " x " + nombreApresLaValeur4Moin + " = ";
						
						// Calcule la réponse.
						reponse = nombreBase - nombreApresLaValeur * nombreApresLaValeur2 + nombreApresLaValeur3 * nombreApresLaValeur4;
					}
					
					// L'opération mathématique de la multiplication et de l'addition et de l'addition et de la multiplication.
					if (hasardA==0 &&  hasardB==1 && hasardC==1 && hasardD==0){
						
						// Formulation de la question.
						question = nombreBase + " x " + nombreApresLaValeur + " + " + nombreApresLaValeur2Moin + " + " + nombreApresLaValeur3 + " x " + nombreApresLaValeur4Moin + " = ";
						
						// Calcule la réponse.
						reponse = nombreBase * nombreApresLaValeur + nombreApresLaValeur2 + nombreApresLaValeur3 * nombreApresLaValeur4;
					}
					
					// L'opération mathématique de l'addition et de l'addition et de l'addition et de la multiplication.
					else if (hasardA==1 &&  hasardB==1 && hasardC==1 && hasardD==0){
						
						// Formulation de la question.
						question = nombreBase + " + " + nombreApresLaValeur + " + " + nombreApresLaValeur2Moin + " + " + nombreApresLaValeur3 + " x " + nombreApresLaValeur4Moin + " = ";
						
						// Calcule la réponse.
						reponse = nombreBase + nombreApresLaValeur + nombreApresLaValeur2 + nombreApresLaValeur3 * nombreApresLaValeur4;
					}
					
					// L'opération mathématique de la soustraction et de l'addition et de l'addition et de la multiplication.
					else if (hasardA==2 &&  hasardB==1 && hasardC==1 && hasardD==0){
						
						// Formulation de la question.
						question = nombreBase + " - " + nombreApresLaValeur + " + " + nombreApresLaValeur2Moin + " + " + nombreApresLaValeur3 + " x " + nombreApresLaValeur4Moin + " = ";
						
						// Calcule la réponse.
						reponse = nombreBase - nombreApresLaValeur + nombreApresLaValeur2 + nombreApresLaValeur3 * nombreApresLaValeur4;
					}
					
					// L'opération mathématique de la multiplication et de la soustraction et de l'addition et de la multiplication.
					if (hasardA==0 &&  hasardB==2 && hasardC==1 && hasardD==0){
						
						// Formulation de la question.
						question = nombreBase + " x " + nombreApresLaValeur + " - " + nombreApresLaValeur2Moin + " + " + nombreApresLaValeur3 + " x " + nombreApresLaValeur4Moin + " = ";
						
						// Calcule la réponse.
						reponse = nombreBase * nombreApresLaValeur - nombreApresLaValeur2 + nombreApresLaValeur3 * nombreApresLaValeur4;
					}
					
					// L'opération mathématique de l'addition et de la soustraction et de l'addition et de la multiplication.
					else if (hasardA==1 &&  hasardB==2 && hasardC==1 && hasardD==0){
						
						// Formulation de la question.
						question = nombreBase + " + " + nombreApresLaValeur + " - " + nombreApresLaValeur2Moin + " + " + nombreApresLaValeur3 + " x " + nombreApresLaValeur4Moin + " = ";
						
						// Calcule la réponse.
						reponse = nombreBase + nombreApresLaValeur - nombreApresLaValeur2 + nombreApresLaValeur3 * nombreApresLaValeur4;
					}
					
					// L'opération mathématique de la soustraction et de la soustraction et de l'addition et de la multiplication.
					else if (hasardA==2 &&  hasardB==2 && hasardC==1 && hasardD==0){
						
						// Formulation de la question.
						question = nombreBase + " - " + nombreApresLaValeur + " - " + nombreApresLaValeur2Moin + " + " + nombreApresLaValeur3 + " x " + nombreApresLaValeur4Moin + " = ";
						
						// Calcule la réponse.
						reponse = nombreBase - nombreApresLaValeur - nombreApresLaValeur2 + nombreApresLaValeur3 * nombreApresLaValeur4;
					}
					
					// L'opération mathématique de la multiplication et de la multiplication et de la soustraction et de la multiplication.
					if (hasardA==0 &&  hasardB==0 && hasardC==2 && hasardD==0){
						
						// Formulation de la question.
						question = nombreBase + " x " + nombreApresLaValeur + " x " + nombreApresLaValeur2Moin + " - " + nombreApresLaValeur3 + " x " + nombreApresLaValeur4Moin + " = ";
						
						// Calcule la réponse.
						reponse = nombreBase * nombreApresLaValeur * nombreApresLaValeur2 - nombreApresLaValeur3 * nombreApresLaValeur4;
					}
					
					// L'opération mathématique de l'addition et de la multiplication et de la soustraction et de la multiplication.
					else if (hasardA==1 &&  hasardB==0 && hasardC==2 && hasardD==0){
						
						// Formulation de la question.
						question = nombreBase + " + " + nombreApresLaValeur + " x " + nombreApresLaValeur2Moin + " - " + nombreApresLaValeur3 + " x " + nombreApresLaValeur4Moin + " = ";
						
						// Calcule la réponse.
						reponse = nombreBase + nombreApresLaValeur * nombreApresLaValeur2 - nombreApresLaValeur3 * nombreApresLaValeur4;
					}
					
					// L'opération mathématique de la soustraction et de la multiplication et de la soustraction et de la multiplication.
					else if (hasardA==2 &&  hasardB==0 && hasardC==2 && hasardD==0){
						
						// Formulation de la question.
						question = nombreBase + " - " + nombreApresLaValeur + " x " + nombreApresLaValeur2Moin + " - " + nombreApresLaValeur3 + " x " + nombreApresLaValeur4Moin + " = ";
						
						// Calcule la réponse.
						reponse = nombreBase - nombreApresLaValeur * nombreApresLaValeur2 - nombreApresLaValeur3 * nombreApresLaValeur4;
					}
					
					// L'opération mathématique de la multiplication et de l'addition et de la soustraction et de la multiplication.
					if (hasardA==0 &&  hasardB==1 && hasardC==2 && hasardD==0){
						
						// Formulation de la question.
						question = nombreBase + " x " + nombreApresLaValeur + " + " + nombreApresLaValeur2Moin + " - " + nombreApresLaValeur3 + " x " + nombreApresLaValeur4Moin + " = ";
						
						// Calcule la réponse.
						reponse = nombreBase * nombreApresLaValeur + nombreApresLaValeur2 - nombreApresLaValeur3 * nombreApresLaValeur4;
					}
					
					// L'opération mathématique de l'addition et de l'addition et de la soustraction et de la multiplication.
					else if (hasardA==1 &&  hasardB==1 && hasardC==2 && hasardD==0){
						
						// Formulation de la question.
						question = nombreBase + " + " + nombreApresLaValeur + " + " + nombreApresLaValeur2Moin + " - " + nombreApresLaValeur3 + " x " + nombreApresLaValeur4Moin + " = ";
						
						// Calcule la réponse.
						reponse = nombreBase + nombreApresLaValeur + nombreApresLaValeur2 - nombreApresLaValeur3 * nombreApresLaValeur4;
					}
					
					// L'opération mathématique de la soustraction et de l'addition et de la soustraction et de la multiplication.
					else if (hasardA==2 &&  hasardB==1 && hasardC==2 && hasardD==0){
						
						// Formulation de la question.
						question = nombreBase + " - " + nombreApresLaValeur + " + " + nombreApresLaValeur2Moin + " - " + nombreApresLaValeur3 + " x " + nombreApresLaValeur4Moin + " = ";
						
						// Calcule la réponse.
						reponse = nombreBase - nombreApresLaValeur + nombreApresLaValeur2 - nombreApresLaValeur3 * nombreApresLaValeur4;
					}
					
					// L'opération mathématique de la multiplication et de la soustraction et de la soustraction et de la multiplication.
					if (hasardA==0 &&  hasardB==2 && hasardC==2 && hasardD==0){
						
						// Formulation de la question.
						question = nombreBase + " x " + nombreApresLaValeur + " - " + nombreApresLaValeur2Moin + " - " + nombreApresLaValeur3 + " x " + nombreApresLaValeur4Moin + " = ";
						
						// Calcule la réponse.
						reponse = nombreBase * nombreApresLaValeur - nombreApresLaValeur2 - nombreApresLaValeur3 * nombreApresLaValeur4;
					}
					
					// L'opération mathématique de l'addition et de la soustraction et de la soustraction et de la multiplication.
					else if (hasardA==1 &&  hasardB==2 && hasardC==2 && hasardD==0){
						
						// Formulation de la question.
						question = nombreBase + " + " + nombreApresLaValeur + " - " + nombreApresLaValeur2Moin + " - " + nombreApresLaValeur3 + " x " + nombreApresLaValeur4Moin + " = ";
						
						// Calcule la réponse.
						reponse = nombreBase + nombreApresLaValeur - nombreApresLaValeur2 - nombreApresLaValeur3 * nombreApresLaValeur4;
					}
					
					// L'opération mathématique de la soustraction et de la soustraction et de la soustraction et de la multiplication.
					else if (hasardA==2 &&  hasardB==2 && hasardC==2 && hasardD==0){
						
						// Formulation de la question.
						question = nombreBase + " - " + nombreApresLaValeur + " - " + nombreApresLaValeur2Moin + " - " + nombreApresLaValeur3 + " x " + nombreApresLaValeur4Moin + " = ";
						
						// Calcule la réponse.
						reponse = nombreBase - nombreApresLaValeur - nombreApresLaValeur2 - nombreApresLaValeur3 * nombreApresLaValeur4;
					}
					
					// L'opération mathématique de la multiplication et de la multiplication et de la multiplication et de l'addition.
					else if (hasardA==0 &&  hasardB==0 && hasardC==0 && hasardD==1){
						
						// Formulation de la question.
						question = nombreBase + " x " + nombreApresLaValeur + " x " + nombreApresLaValeur2Moin + " x " + nombreApresLaValeur3 + " + " + nombreApresLaValeur4Moin + " = ";
						
						// Calcule la réponse.
						reponse = nombreBase * nombreApresLaValeur * nombreApresLaValeur2 * nombreApresLaValeur3 + nombreApresLaValeur4;
					}
					
					// L'opération mathématique de l'addition et de la multiplication et de la multiplication et de l'addition.
					else if (hasardA==1 &&  hasardB==0 && hasardC==0 && hasardD==1){
						
						// Formulation de la question.
						question = nombreBase + " + " + nombreApresLaValeur + " x " + nombreApresLaValeur2Moin + " x " + nombreApresLaValeur3 + " + " + nombreApresLaValeur4Moin + " = ";
						
						// Calcule la réponse.
						reponse = nombreBase + nombreApresLaValeur * nombreApresLaValeur2 * nombreApresLaValeur3 + nombreApresLaValeur4;
					}
					
					// L'opération mathématique de la soustraction et de la multiplication et de la multiplication et de l'addition.
					else if (hasardA==2 &&  hasardB==0 && hasardC==0 && hasardD==1){
						
						// Formulation de la question.
						question = nombreBase + " - " + nombreApresLaValeur + " x " + nombreApresLaValeur2Moin + " x " + nombreApresLaValeur3 + " + " + nombreApresLaValeur4Moin + " = ";
						
						// Calcule la réponse.
						reponse = nombreBase - nombreApresLaValeur * nombreApresLaValeur2 * nombreApresLaValeur3 + nombreApresLaValeur4;
					}
					
					// L'opération mathématique de la multiplication et de l'addition et de la multiplication et de l'addition.
					if (hasardA==0 &&  hasardB==1 && hasardC==0 && hasardD==1){
						
						// Formulation de la question.
						question = nombreBase + " x " + nombreApresLaValeur + " + " + nombreApresLaValeur2Moin + " x " + nombreApresLaValeur3 + " + " + nombreApresLaValeur4Moin + " = ";
						
						// Calcule la réponse.
						reponse = nombreBase * nombreApresLaValeur + nombreApresLaValeur2 * nombreApresLaValeur3 + nombreApresLaValeur4;
					}
					
					// L'opération mathématique de l'addition et de l'addition et de la multiplication et de l'addition.
					else if (hasardA==1 &&  hasardB==1 && hasardC==0 && hasardD==1){
						
						// Formulation de la question.
						question = nombreBase + " + " + nombreApresLaValeur + " + " + nombreApresLaValeur2Moin + " x " + nombreApresLaValeur3 + " + " + nombreApresLaValeur4Moin + " = ";
						
						// Calcule la réponse.
						reponse = nombreBase + nombreApresLaValeur + nombreApresLaValeur2 * nombreApresLaValeur3 + nombreApresLaValeur4;
					}
					
					// L'opération mathématique de la soustraction et de l'addition et de la multiplication et de l'addition.  
					else if (hasardA==2 &&  hasardB==1 && hasardC==0 && hasardD==1){
						
						// Formulation de la question.
						question = nombreBase + " - " + nombreApresLaValeur + " + " + nombreApresLaValeur2Moin + " x " + nombreApresLaValeur3 + " + " + nombreApresLaValeur4Moin + " = ";
						
						// Calcule la réponse.
						reponse = nombreBase - nombreApresLaValeur + nombreApresLaValeur2 * nombreApresLaValeur3 + nombreApresLaValeur4;
					}
					
					// L'opération mathématique de la multiplication et de la soustraction et de la multiplication et de l'addition.
					if (hasardA==0 &&  hasardB==2 && hasardC==0 && hasardD==1){
						
						// Formulation de la question.
						question = nombreBase + " x " + nombreApresLaValeur + " - " + nombreApresLaValeur2Moin + " x " + nombreApresLaValeur3 + " + " + nombreApresLaValeur4Moin + " = ";
						
						// Calcule la réponse.
						reponse = nombreBase * nombreApresLaValeur - nombreApresLaValeur2 * nombreApresLaValeur3 + nombreApresLaValeur4;
					}
					
					// L'opération mathématique de l'addition et de la soustraction et de la multiplication et de l'addition.
					else if (hasardA==1 &&  hasardB==2 && hasardC==0 && hasardD==1){
						
						// Formulation de la question.
						question = nombreBase + " + " + nombreApresLaValeur + " - " + nombreApresLaValeur2Moin + " x " + nombreApresLaValeur3 + " + " + nombreApresLaValeur4Moin + " = ";
						
						// Calcule la réponse.
						reponse = nombreBase + nombreApresLaValeur - nombreApresLaValeur2 * nombreApresLaValeur3 + nombreApresLaValeur4;
					}
					
					// L'opération mathématique de la soustraction et de la soustraction et de la multiplication et de l'addition.
					else if (hasardA==2 &&  hasardB==2 && hasardC==0 && hasardD==1){
						
						// Formulation de la question.
						question = nombreBase + " - " + nombreApresLaValeur + " - " + nombreApresLaValeur2Moin + " x " + nombreApresLaValeur3 + " + " + nombreApresLaValeur4Moin + " = ";
						
						// Calcule la réponse.
						reponse = nombreBase - nombreApresLaValeur - nombreApresLaValeur2 * nombreApresLaValeur3 + nombreApresLaValeur4;
					}
					
					// L'opération mathématique de la multiplication et de la multiplication et de l'addition et de l'addition.
					if (hasardA==0 &&  hasardB==0 && hasardC==1 && hasardD==1){
						
						// Formulation de la question.
						question = nombreBase + " x " + nombreApresLaValeur + " x " + nombreApresLaValeur2Moin + " + " + nombreApresLaValeur3 + " + " + nombreApresLaValeur4Moin + " = ";
						
						// Calcule la réponse.
						reponse = nombreBase * nombreApresLaValeur * nombreApresLaValeur2 + nombreApresLaValeur3 + nombreApresLaValeur4;
					}
					
					// L'opération mathématique de l'addition et de la multiplication et de l'addition et de l'addition.
					else if (hasardA==1 &&  hasardB==0 && hasardC==1 && hasardD==1){
						
						// Formulation de la question.
						question = nombreBase + " + " + nombreApresLaValeur + " x " + nombreApresLaValeur2Moin + " + " + nombreApresLaValeur3 + " + " + nombreApresLaValeur4Moin + " = ";
						
						// Calcule la réponse.
						reponse = nombreBase + nombreApresLaValeur * nombreApresLaValeur2 + nombreApresLaValeur3 + nombreApresLaValeur4;
					}
					
					// L'opération mathématique de la soustraction et de la multiplication et de l'addition et de l'addition.
					else if (hasardA==2 &&  hasardB==0 && hasardC==1 && hasardD==1){
						
						// Formulation de la question.
						question = nombreBase + " - " + nombreApresLaValeur + " x " + nombreApresLaValeur2Moin + " + " + nombreApresLaValeur3 + " + " + nombreApresLaValeur4Moin + " = ";
						
						// Calcule la réponse.
						reponse = nombreBase - nombreApresLaValeur * nombreApresLaValeur2 + nombreApresLaValeur3 + nombreApresLaValeur4;
					}
					
					// L'opération mathématique de la multiplication et de l'addition et de l'addition et de l'addition.
					if (hasardA==0 &&  hasardB==1 && hasardC==1 && hasardD==1){
						
						// Formulation de la question.
						question = nombreBase + " x " + nombreApresLaValeur + " + " + nombreApresLaValeur2Moin + " + " + nombreApresLaValeur3 + " + " + nombreApresLaValeur4Moin + " = ";
						
						// Calcule la réponse.
						reponse = nombreBase * nombreApresLaValeur + nombreApresLaValeur2 + nombreApresLaValeur3 + nombreApresLaValeur4;
					}
					
					// L'opération mathématique de l'addition et de l'addition et de l'addition et de l'addition.
					else if (hasardA==1 &&  hasardB==1 && hasardC==1 && hasardD==1){
						
						// Formulation de la question.
						question = nombreBase + " + " + nombreApresLaValeur + " + " + nombreApresLaValeur2Moin + " + " + nombreApresLaValeur3 + " + " + nombreApresLaValeur4Moin + " = ";
						
						// Calcule la réponse.
						reponse = nombreBase + nombreApresLaValeur + nombreApresLaValeur2 + nombreApresLaValeur3 + nombreApresLaValeur4;
					}
					
					// L'opération mathématique de la soustraction et de l'addition et de l'addition et de l'addition.
					else if (hasardA==2 &&  hasardB==1 && hasardC==1 && hasardD==1){
						
						// Formulation de la question.
						question = nombreBase + " - " + nombreApresLaValeur + " + " + nombreApresLaValeur2Moin + " + " + nombreApresLaValeur3 + " + " + nombreApresLaValeur4Moin + " = ";
						
						// Calcule la réponse.
						reponse = nombreBase - nombreApresLaValeur + nombreApresLaValeur2 + nombreApresLaValeur3 + nombreApresLaValeur4;
					}
					
					// L'opération mathématique de la multiplication et de la soustraction et de l'addition et de l'addition.
					if (hasardA==0 &&  hasardB==2 && hasardC==1 && hasardD==1){
						
						// Formulation de la question.
						question = nombreBase + " x " + nombreApresLaValeur + " - " + nombreApresLaValeur2Moin + " + " + nombreApresLaValeur3 + " + " + nombreApresLaValeur4Moin + " = ";
						
						// Calcule la réponse.
						reponse = nombreBase * nombreApresLaValeur - nombreApresLaValeur2 + nombreApresLaValeur3 + nombreApresLaValeur4;
					}
					
					// L'opération mathématique de l'addition et de la soustraction et de l'addition et de l'addition.
					else if (hasardA==1 &&  hasardB==2 && hasardC==1 && hasardD==1){
						
						// Formulation de la question.
						question = nombreBase + " + " + nombreApresLaValeur + " - " + nombreApresLaValeur2Moin + " + " + nombreApresLaValeur3 + " + " + nombreApresLaValeur4Moin + " = ";
						
						// Calcule la réponse.
						reponse = nombreBase + nombreApresLaValeur - nombreApresLaValeur2 + nombreApresLaValeur3 + nombreApresLaValeur4;
					}
					
					// L'opération mathématique de la soustraction et de la soustraction et de l'addition et de l'addition.
					else if (hasardA==2 &&  hasardB==2 && hasardC==1 && hasardD==1){
						
						// Formulation de la question.
						question = nombreBase + " - " + nombreApresLaValeur + " - " + nombreApresLaValeur2Moin + " + " + nombreApresLaValeur3 + " + " + nombreApresLaValeur4Moin + " = ";
						
						// Calcule la réponse.
						reponse = nombreBase - nombreApresLaValeur - nombreApresLaValeur2 + nombreApresLaValeur3 + nombreApresLaValeur4;
					}
					
					// L'opération mathématique de la multiplication et de la multiplication et de la soustraction et de l'addition.
					if (hasardA==0 &&  hasardB==0 && hasardC==2 && hasardD==1){
						
						// Formulation de la question.
						question = nombreBase + " x " + nombreApresLaValeur + " x " + nombreApresLaValeur2Moin + " - " + nombreApresLaValeur3 + " + " + nombreApresLaValeur4Moin + " = ";
						
						// Calcule la réponse.
						reponse = nombreBase * nombreApresLaValeur * nombreApresLaValeur2 - nombreApresLaValeur3 + nombreApresLaValeur4;
					}
					
					// L'opération mathématique de l'addition et de la multiplication et de la soustraction et de l'addition.
					else if (hasardA==1 &&  hasardB==0 && hasardC==2 && hasardD==1){
						
						// Formulation de la question.
						question = nombreBase + " + " + nombreApresLaValeur + " x " + nombreApresLaValeur2Moin + " - " + nombreApresLaValeur3 + " + " + nombreApresLaValeur4Moin + " = ";
						
						// Calcule la réponse.
						reponse = nombreBase + nombreApresLaValeur * nombreApresLaValeur2 - nombreApresLaValeur3 + nombreApresLaValeur4;
					}
					
					// L'opération mathématique de la soustraction et de la multiplication et de la soustraction et de l'addition.
					else if (hasardA==2 &&  hasardB==0 && hasardC==2 && hasardD==1){
						
						// Formulation de la question.
						question = nombreBase + " - " + nombreApresLaValeur + " x " + nombreApresLaValeur2Moin + " - " + nombreApresLaValeur3 + " + " + nombreApresLaValeur4Moin + " = ";
						
						// Calcule la réponse.
						reponse = nombreBase - nombreApresLaValeur * nombreApresLaValeur2 - nombreApresLaValeur3 + nombreApresLaValeur4;
					}
					
					// L'opération mathématique de la multiplication et de l'addition et de la soustraction et de l'addition.
					if (hasardA==0 &&  hasardB==1 && hasardC==2 && hasardD==1){
						
						// Formulation de la question.
						question = nombreBase + " x " + nombreApresLaValeur + " + " + nombreApresLaValeur2Moin + " - " + nombreApresLaValeur3 + " + " + nombreApresLaValeur4Moin + " = ";
						
						// Calcule la réponse.
						reponse = nombreBase * nombreApresLaValeur + nombreApresLaValeur2 - nombreApresLaValeur3 + nombreApresLaValeur4;
					}
					
					// L'opération mathématique de l'addition et de l'addition et de la soustraction et de l'addition.
					else if (hasardA==1 &&  hasardB==1 && hasardC==2 && hasardD==1){
						
						// Formulation de la question.
						question = nombreBase + " + " + nombreApresLaValeur + " + " + nombreApresLaValeur2Moin + " - " + nombreApresLaValeur3 + " + " + nombreApresLaValeur4Moin + " = ";
						
						// Calcule la réponse.
						reponse = nombreBase + nombreApresLaValeur + nombreApresLaValeur2 - nombreApresLaValeur3 + nombreApresLaValeur4;
					}
					
					// L'opération mathématique de la soustraction et de l'addition et de la soustraction et de l'addition.
					else if (hasardA==2 &&  hasardB==1 && hasardC==2 && hasardD==1){
						
						// Formulation de la question.
						question = nombreBase + " - " + nombreApresLaValeur + " + " + nombreApresLaValeur2Moin + " - " + nombreApresLaValeur3 + " + " + nombreApresLaValeur4Moin + " = ";
						
						// Calcule la réponse.
						reponse = nombreBase - nombreApresLaValeur + nombreApresLaValeur2 - nombreApresLaValeur3 + nombreApresLaValeur4;
					}
					
					// L'opération mathématique de la multiplication et de la soustraction et de la soustraction et de l'addition.
					if (hasardA==0 &&  hasardB==2 && hasardC==2 && hasardD==1){
						
						// Formulation de la question.
						question = nombreBase + " x " + nombreApresLaValeur + " - " + nombreApresLaValeur2Moin + " - " + nombreApresLaValeur3 + " + " + nombreApresLaValeur4Moin + " = ";
						
						// Calcule la réponse.
						reponse = nombreBase * nombreApresLaValeur - nombreApresLaValeur2 - nombreApresLaValeur3 + nombreApresLaValeur4;
					}
					
					// L'opération mathématique de l'addition et de la soustraction et de la soustraction et de l'addition.
					else if (hasardA==1 &&  hasardB==2 && hasardC==2 && hasardD==1){
						
						// Formulation de la question.
						question = nombreBase + " + " + nombreApresLaValeur + " - " + nombreApresLaValeur2Moin + " - " + nombreApresLaValeur3 + " + " + nombreApresLaValeur4Moin + " = ";
						
						// Calcule la réponse.
						reponse = nombreBase + nombreApresLaValeur - nombreApresLaValeur2 - nombreApresLaValeur3 + nombreApresLaValeur4;
					}
					
					// L'opération mathématique de la soustraction et de la soustraction et de la soustraction et de l'addition.
					else if (hasardA==2 &&  hasardB==2 && hasardC==2 && hasardD==1){
						
						// Formulation de la question.
						question = nombreBase + " - " + nombreApresLaValeur + " - " + nombreApresLaValeur2Moin + " - " + nombreApresLaValeur3 + " + " + nombreApresLaValeur4Moin + " = ";
						
						// Calcule la réponse.
						reponse = nombreBase - nombreApresLaValeur - nombreApresLaValeur2 - nombreApresLaValeur3 + nombreApresLaValeur4;
					}
					
					// L'opération mathématique de la multiplication et de la multiplication et de la multiplication et de la soustraction.
					else if (hasardA==0 &&  hasardB==0 && hasardC==0 && hasardD==2){
						
						// Formulation de la question.
						question = nombreBase + " x " + nombreApresLaValeur + " x " + nombreApresLaValeur2Moin + " x " + nombreApresLaValeur3 + " - " + nombreApresLaValeur4Moin + " = ";
						
						// Calcule la réponse.
						reponse = nombreBase * nombreApresLaValeur * nombreApresLaValeur2 * nombreApresLaValeur3 - nombreApresLaValeur4;
					}
					
					// L'opération mathématique de l'addition et de la multiplication et de la multiplication et de la soustraction.
					else if (hasardA==1 &&  hasardB==0 && hasardC==0 && hasardD==2){
						
						// Formulation de la question.
						question = nombreBase + " + " + nombreApresLaValeur + " x " + nombreApresLaValeur2Moin + " x " + nombreApresLaValeur3 + " - " + nombreApresLaValeur4Moin + " = ";
						
						// Calcule la réponse.
						reponse = nombreBase + nombreApresLaValeur * nombreApresLaValeur2 * nombreApresLaValeur3 - nombreApresLaValeur4;
					}
					
					// L'opération mathématique de la soustraction et de la multiplication et de la multiplication et de la soustraction.
					else if (hasardA==2 &&  hasardB==0 && hasardC==0 && hasardD==2){
						
						// Formulation de la question.
						question = nombreBase + " - " + nombreApresLaValeur + " x " + nombreApresLaValeur2Moin + " x " + nombreApresLaValeur3 + " - " + nombreApresLaValeur4Moin + " = ";
						
						// Calcule la réponse.
						reponse = nombreBase - nombreApresLaValeur * nombreApresLaValeur2 * nombreApresLaValeur3 - nombreApresLaValeur4;
					}
					
					// L'opération mathématique de la multiplication et de l'addition et de la multiplication et de la soustraction.
					if (hasardA==0 &&  hasardB==1 && hasardC==0 && hasardD==2){
						
						// Formulation de la question.
						question = nombreBase + " x " + nombreApresLaValeur + " + " + nombreApresLaValeur2Moin + " x " + nombreApresLaValeur3 + " - " + nombreApresLaValeur4Moin + " = ";
						
						// Calcule la réponse.
						reponse = nombreBase * nombreApresLaValeur + nombreApresLaValeur2 * nombreApresLaValeur3 - nombreApresLaValeur4;
					}
					
					// L'opération mathématique de l'addition et de l'addition et de la multiplication et de la soustraction.
					else if (hasardA==1 &&  hasardB==1 && hasardC==0 && hasardD==2){
						
						// Formulation de la question.
						question = nombreBase + " + " + nombreApresLaValeur + " + " + nombreApresLaValeur2Moin + " x " + nombreApresLaValeur3 + " - " + nombreApresLaValeur4Moin + " = ";
						
						// Calcule la réponse.
						reponse = nombreBase + nombreApresLaValeur + nombreApresLaValeur2 * nombreApresLaValeur3 - nombreApresLaValeur4;
					}
					
					// L'opération mathématique de la soustraction et de l'addition et de la multiplication et de la soustraction.  
					else if (hasardA==2 &&  hasardB==1 && hasardC==0 && hasardD==2){
						
						// Formulation de la question.
						question = nombreBase + " - " + nombreApresLaValeur + " + " + nombreApresLaValeur2Moin + " x " + nombreApresLaValeur3 + " - " + nombreApresLaValeur4Moin + " = ";
						
						// Calcule la réponse.
						reponse = nombreBase - nombreApresLaValeur + nombreApresLaValeur2 * nombreApresLaValeur3 - nombreApresLaValeur4;
					}
					
					// L'opération mathématique de la multiplication et de la soustraction et de la multiplication et de la soustraction.
					if (hasardA==0 &&  hasardB==2 && hasardC==0 && hasardD==2){
						
						// Formulation de la question.
						question = nombreBase + " x " + nombreApresLaValeur + " - " + nombreApresLaValeur2Moin + " x " + nombreApresLaValeur3 + " - " + nombreApresLaValeur4Moin + " = ";
						
						// Calcule la réponse.
						reponse = nombreBase * nombreApresLaValeur - nombreApresLaValeur2 * nombreApresLaValeur3 - nombreApresLaValeur4;
					}
					
					// L'opération mathématique de l'addition et de la soustraction et de la multiplication et de la soustraction.
					else if (hasardA==1 &&  hasardB==2 && hasardC==0 && hasardD==2){
						
						// Formulation de la question.
						question = nombreBase + " + " + nombreApresLaValeur + " - " + nombreApresLaValeur2Moin + " x " + nombreApresLaValeur3 + " - " + nombreApresLaValeur4Moin + " = ";
						
						// Calcule la réponse.
						reponse = nombreBase + nombreApresLaValeur - nombreApresLaValeur2 * nombreApresLaValeur3 - nombreApresLaValeur4;
					}
					
					// L'opération mathématique de la soustraction et de la soustraction et de la multiplication et de la soustraction.
					else if (hasardA==2 &&  hasardB==2 && hasardC==0 && hasardD==2){
						
						// Formulation de la question.
						question = nombreBase + " - " + nombreApresLaValeur + " - " + nombreApresLaValeur2Moin + " x " + nombreApresLaValeur3 + " - " + nombreApresLaValeur4Moin + " = ";
						
						// Calcule la réponse.
						reponse = nombreBase - nombreApresLaValeur - nombreApresLaValeur2 * nombreApresLaValeur3 - nombreApresLaValeur4;
					}
					
					// L'opération mathématique de la multiplication et de la multiplication et de l'addition et de la soustraction.
					if (hasardA==0 &&  hasardB==0 && hasardC==1 && hasardD==2){
						
						// Formulation de la question.
						question = nombreBase + " x " + nombreApresLaValeur + " x " + nombreApresLaValeur2Moin + " + " + nombreApresLaValeur3 + " - " + nombreApresLaValeur4Moin + " = ";
						
						// Calcule la réponse.
						reponse = nombreBase * nombreApresLaValeur * nombreApresLaValeur2 + nombreApresLaValeur3 - nombreApresLaValeur4;
					}
					
					// L'opération mathématique de l'addition et de la multiplication et de l'addition et de la soustraction.
					else if (hasardA==1 &&  hasardB==0 && hasardC==1 && hasardD==2){
						
						// Formulation de la question.
						question = nombreBase + " + " + nombreApresLaValeur + " x " + nombreApresLaValeur2Moin + " + " + nombreApresLaValeur3 + " - " + nombreApresLaValeur4Moin + " = ";
						
						// Calcule la réponse.
						reponse = nombreBase + nombreApresLaValeur * nombreApresLaValeur2 + nombreApresLaValeur3 - nombreApresLaValeur4;
					}
					
					// L'opération mathématique de la soustraction et de la multiplication et de l'addition et de la soustraction.
					else if (hasardA==2 &&  hasardB==0 && hasardC==1 && hasardD==2){
						
						// Formulation de la question.
						question = nombreBase + " - " + nombreApresLaValeur + " x " + nombreApresLaValeur2Moin + " + " + nombreApresLaValeur3 + " - " + nombreApresLaValeur4Moin + " = ";
						
						// Calcule la réponse.
						reponse = nombreBase - nombreApresLaValeur * nombreApresLaValeur2 + nombreApresLaValeur3 - nombreApresLaValeur4;
					}
					
					// L'opération mathématique de la multiplication et de l'addition et de l'addition et de la soustraction.
					if (hasardA==0 &&  hasardB==1 && hasardC==1 && hasardD==2){
						
						// Formulation de la question.
						question = nombreBase + " x " + nombreApresLaValeur + " + " + nombreApresLaValeur2Moin + " + " + nombreApresLaValeur3 + " - " + nombreApresLaValeur4Moin + " = ";
						
						// Calcule la réponse.
						reponse = nombreBase * nombreApresLaValeur + nombreApresLaValeur2 + nombreApresLaValeur3 - nombreApresLaValeur4;
					}
					
					// L'opération mathématique de l'addition et de l'addition et de l'addition et de la soustraction.
					else if (hasardA==1 &&  hasardB==1 && hasardC==1 && hasardD==2){
						
						// Formulation de la question.
						question = nombreBase + " + " + nombreApresLaValeur + " + " + nombreApresLaValeur2Moin + " + " + nombreApresLaValeur3 + " - " + nombreApresLaValeur4Moin + " = ";
						
						// Calcule la réponse.
						reponse = nombreBase + nombreApresLaValeur + nombreApresLaValeur2 + nombreApresLaValeur3 - nombreApresLaValeur4;
					}
					
					// L'opération mathématique de la soustraction et de l'addition et de l'addition et de la soustraction.
					else if (hasardA==2 &&  hasardB==1 && hasardC==1 && hasardD==2){
						
						// Formulation de la question.
						question = nombreBase + " - " + nombreApresLaValeur + " + " + nombreApresLaValeur2Moin + " + " + nombreApresLaValeur3 + " - " + nombreApresLaValeur4Moin + " = ";
						
						// Calcule la réponse.
						reponse = nombreBase - nombreApresLaValeur + nombreApresLaValeur2 + nombreApresLaValeur3 - nombreApresLaValeur4;
					}
					
					// L'opération mathématique de la multiplication et de la soustraction et de l'addition et de la soustraction.
					if (hasardA==0 &&  hasardB==2 && hasardC==1 && hasardD==2){
						
						// Formulation de la question.
						question = nombreBase + " x " + nombreApresLaValeur + " - " + nombreApresLaValeur2Moin + " + " + nombreApresLaValeur3 + " - " + nombreApresLaValeur4Moin + " = ";
						
						// Calcule la réponse.
						reponse = nombreBase * nombreApresLaValeur - nombreApresLaValeur2 + nombreApresLaValeur3 - nombreApresLaValeur4;
					}
					
					// L'opération mathématique de l'addition et de la soustraction et de l'addition et de la soustraction.
					else if (hasardA==1 &&  hasardB==2 && hasardC==1 && hasardD==2){
						
						// Formulation de la question.
						question = nombreBase + " + " + nombreApresLaValeur + " - " + nombreApresLaValeur2Moin + " + " + nombreApresLaValeur3 + " - " + nombreApresLaValeur4Moin + " = ";
						
						// Calcule la réponse.
						reponse = nombreBase + nombreApresLaValeur - nombreApresLaValeur2 + nombreApresLaValeur3 - nombreApresLaValeur4;
					}
					
					// L'opération mathématique de la soustraction et de la soustraction et de l'addition et de la soustraction.
					else if (hasardA==2 &&  hasardB==2 && hasardC==1 && hasardD==2){
						
						// Formulation de la question.
						question = nombreBase + " - " + nombreApresLaValeur + " - " + nombreApresLaValeur2Moin + " + " + nombreApresLaValeur3 + " - " + nombreApresLaValeur4Moin + " = ";
						
						// Calcule la réponse.
						reponse = nombreBase - nombreApresLaValeur - nombreApresLaValeur2 + nombreApresLaValeur3 - nombreApresLaValeur4;
					}
					
					// L'opération mathématique de la multiplication et de la multiplication et de la soustraction et de la soustraction.
					if (hasardA==0 &&  hasardB==0 && hasardC==2 && hasardD==2){
						
						// Formulation de la question.
						question = nombreBase + " x " + nombreApresLaValeur + " x " + nombreApresLaValeur2Moin + " - " + nombreApresLaValeur3 + " - " + nombreApresLaValeur4Moin + " = ";
						
						// Calcule la réponse.
						reponse = nombreBase * nombreApresLaValeur * nombreApresLaValeur2 - nombreApresLaValeur3 - nombreApresLaValeur4;
					}
					
					// L'opération mathématique de l'addition et de la multiplication et de la soustraction et de la soustraction.
					else if (hasardA==1 &&  hasardB==0 && hasardC==2 && hasardD==2){
						
						// Formulation de la question.
						question = nombreBase + " + " + nombreApresLaValeur + " x " + nombreApresLaValeur2Moin + " - " + nombreApresLaValeur3 + " - " + nombreApresLaValeur4Moin + " = ";
						
						// Calcule la réponse.
						reponse = nombreBase + nombreApresLaValeur * nombreApresLaValeur2 - nombreApresLaValeur3 - nombreApresLaValeur4;
					}
					
					// L'opération mathématique de la soustraction et de la multiplication et de la soustraction et de la soustraction.
					else if (hasardA==2 &&  hasardB==0 && hasardC==2 && hasardD==2){
						
						// Formulation de la question.
						question = nombreBase + " - " + nombreApresLaValeur + " x " + nombreApresLaValeur2Moin + " - " + nombreApresLaValeur3 + " - " + nombreApresLaValeur4Moin + " = ";
						
						// Calcule la réponse.
						reponse = nombreBase - nombreApresLaValeur * nombreApresLaValeur2 - nombreApresLaValeur3 - nombreApresLaValeur4;
					}
					
					// L'opération mathématique de la multiplication et de l'addition et de la soustraction et de la soustraction.
					if (hasardA==0 &&  hasardB==1 && hasardC==2 && hasardD==2){
						
						// Formulation de la question.
						question = nombreBase + " x " + nombreApresLaValeur + " + " + nombreApresLaValeur2Moin + " - " + nombreApresLaValeur3 + " - " + nombreApresLaValeur4Moin + " = ";
						
						// Calcule la réponse.
						reponse = nombreBase * nombreApresLaValeur + nombreApresLaValeur2 - nombreApresLaValeur3 - nombreApresLaValeur4;
					}
					
					// L'opération mathématique de l'addition et de l'addition et de la soustraction et de la soustraction.
					else if (hasardA==1 &&  hasardB==1 && hasardC==2 && hasardD==2){
						
						// Formulation de la question.
						question = nombreBase + " + " + nombreApresLaValeur + " + " + nombreApresLaValeur2Moin + " - " + nombreApresLaValeur3 + " - " + nombreApresLaValeur4Moin + " = ";
						
						// Calcule la réponse.
						reponse = nombreBase + nombreApresLaValeur + nombreApresLaValeur2 - nombreApresLaValeur3 - nombreApresLaValeur4;
					}
					
					// L'opération mathématique de la soustraction et de l'addition et de la soustraction et de la soustraction.
					else if (hasardA==2 &&  hasardB==1 && hasardC==2 && hasardD==2){
						
						// Formulation de la question.
						question = nombreBase + " - " + nombreApresLaValeur + " + " + nombreApresLaValeur2Moin + " - " + nombreApresLaValeur3 + " - " + nombreApresLaValeur4Moin + " = ";
						
						// Calcule la réponse.
						reponse = nombreBase - nombreApresLaValeur + nombreApresLaValeur2 - nombreApresLaValeur3 - nombreApresLaValeur4;
					}
					
					// L'opération mathématique de la multiplication et de la soustraction et de la soustraction et de la soustraction.
					if (hasardA==0 &&  hasardB==2 && hasardC==2 && hasardD==2){
						
						// Formulation de la question.
						question = nombreBase + " x " + nombreApresLaValeur + " - " + nombreApresLaValeur2Moin + " - " + nombreApresLaValeur3 + " - " + nombreApresLaValeur4Moin + " = ";
						
						// Calcule la réponse.
						reponse = nombreBase * nombreApresLaValeur - nombreApresLaValeur2 - nombreApresLaValeur3 - nombreApresLaValeur4;
					}
					
					// L'opération mathématique de l'addition et de la soustraction et de la soustraction et de la soustraction.
					else if (hasardA==1 &&  hasardB==2 && hasardC==2 && hasardD==2){
						
						// Formulation de la question.
						question = nombreBase + " + " + nombreApresLaValeur + " - " + nombreApresLaValeur2Moin + " - " + nombreApresLaValeur3 + " - " + nombreApresLaValeur4Moin + " = ";
						
						// Calcule la réponse.
						reponse = nombreBase + nombreApresLaValeur - nombreApresLaValeur2 - nombreApresLaValeur3 - nombreApresLaValeur4;
					}
					
					// L'opération mathématique de la soustraction et de la soustraction et de la soustraction et de la soustraction.
					else if (hasardA==2 &&  hasardB==2 && hasardC==2 && hasardD==2){
						
						// Formulation de la question.
						question = nombreBase + " - " + nombreApresLaValeur + " - " + nombreApresLaValeur2Moin + " - " + nombreApresLaValeur3 + " - " + nombreApresLaValeur4Moin + " = ";
						
						// Calcule la réponse.
						reponse = nombreBase - nombreApresLaValeur - nombreApresLaValeur2 - nombreApresLaValeur3 - nombreApresLaValeur4;
					}
				}
			}
			
			// Affiche le résultat.
			txtQuestionMath.text = question;
			
		}
		
		// La fonction pour savoir si c'est la bonne réponse.
		function reponse1 (event :MouseEvent) :void
		{
			// Calcul les partis.
			parti = parti +1;
			
			// Affiche les partis.
			txtParti.text = "/"+ parti;
			
			// Efface le txtQuestionMathResulat.
			txtQuestionMathResulat.text = "";
			
			// var de la réponse de l'utilisateur.
			var reponseUtilisateur:int;
			
			// var message des résultats.
			var resulat:String;
			
			// Va chercher la réponse de l'utilisateur.
			reponseUtilisateur = int(txtReponse.text);
			
			// Déterminer si c'est la bonne réponse ou pas.
			if (reponse == reponseUtilisateur){
				
				// Message des résultats.
				resulat = "Bravo bonne réponse";
				
				// Calcul les points.
				bonneQ = bonneQ + 1;
				
				// Retourne à la fonction calcule et affiche un autre question.
				calcule(null);
				
				// Affiche le question.
				txtQuestionMath.text = question;
		
			}
			else {
				
				// Message des résultats.
				resulat = "Ce n'est pas la bonne \n réponse, veuillez  réessayer";
				
			}
			
			// Efface le txtReponse.
			txtReponse.text = "";
			
			// Affiche le résultat.
			txtQuestionMathResulat.text = resulat;

		}// Fin de la fonction pour savoir si c'est la bonne réponse.
		
		// La fonction pour sautée les questions.
		function skipB (event :MouseEvent) :void
		{
			// Efface le txtQuestionMathResulat.
			txtQuestionMathResulat.text = "";
			
			// Si ce n'est pas une question.
			if (question == "Tu dois prendre un autre catégorie.")
			{
				// Le message d'erreur.
				question = "Ce n'est pas une question.";
				
			}
			
			// Si ce n'est pas une question.
			else if (question == "Ce n'est pas une question.")
			{
				// Le message d'erreur.
				question = "Ce n'est pas une question.";
				
			}
			else
			{
				// Le numéro de la question sauter.
				nombreQ = nombreQ + 1; 
				
				// Envoie un autre tableau la réponse.
				questionReponse.push([nombreQ,reponse]);
			
				// Envoie un autre tableau la question.
				questionS.push([nombreQ," : ",question]);
				
				// Retourne à la fonction calcule et affiche un autre question.
				calcule(null);
				
				// Affiche le tableau.
				afficher(null);
			}
			
			// Affiche la question.
			txtQuestionMath.text = question;
	
		} // Fin de la fonction pour sautée les questions.
		
		// La fonction qu'on peut rejouer une question qu'on ne sauter.
		function rejouer (event :MouseEvent) :void
		{
			// Efface le txtQuestionMathResulat.
			txtQuestionMathResulat.text = "";
			
			// var numéro de l'utilisateur de la question.
			var numeroQuestion:int;
			
			// Message des résultats.
			var messageQ:String;
			
			// Numéro de l'utilisateur de la question.
			numeroQuestion = int(txtnumeroQuestion.text);
			
			// Si le numéro de la question égale à 0 c'est une erreur.
			if (numeroQuestion == 0){
				
				// Le message que ce n'est pas une question.
				txtQuestionMathResulat.text = "Il n'a pas de question";
			}
			else{
				
				// Envoyer les données à la fonction rechercheBinaire.
				var resule = rechercheBinaire(questionS,0,questionS.length-1,numeroQuestion);
				
				// Les résultats de la recherche binaire.
				if (resule == "Il n'y a pas de question avec \n ce numéro.")
				{
					 // Message qu'il n'y a pas de question dans le tableau qui correspond au numéro.
					
					// Affiche les résultats.
					txtQuestionMathResulat.text = resule;
				}
				else
				{
					 // Message qui affiche la question et qui correspond à un numéro.
					 messageQ = resule;
					 
					 // Pour trouver la réponse de la question.
					 for (var rang:int = 0; rang < questionS.length; rang++) 
					 {
						// Numéro de la question ont été repérés.
						if ((questionS[rang][2]==resule))
						{
						  // rang - indique la rangée à supprimer. 
						  questionS.splice(rang,1);
						  
						  // Message de la réponse.
						  reponse = questionReponse[rang][1];
						  
						   // rang - indique la rangée à supprimer. 
						  questionReponse.splice(rang,1);
						  
						}
					 }
				 }
				 
				 // Affiche la question.
				 txtQuestionMath.text = messageQ;
			 }
			 
			 // Affiche le tableau.
			 afficher(null);
 
		} // Fin de la fonction qu'on peut rejouer une question qu'on ne sauter.
		
		// La recherche binaire.
		function rechercheBinaire(T:Array,gauche:int,droite:int,NumDeRe:Object):String 
		{
			 // l'indice de l'élément au centre du tableau sur lequel porte la recherche.
			 var milieu:int;
			 
			 // Il y a pas de résultats trouvés dans le tableau T.
			 if (gauche > droite) 
			 {
				 // Le message qui retourne à la fonction rejouer.
				 return "Il n'y a pas de question avec \n ce numéro.";
			 }
			 
			 // Calcule et trouve le milieu du tableau T.
			 milieu = (gauche + droite) / 2;
			 
			 // Quand le tableau à la même valeur que le numéro de référence.
			 if (T[milieu][0] == NumDeRe) 
			 {
				 // Le message qui a une question et retourne la question à la fonction rejouer.
				 return T[milieu][2];
			 }
			 
			 // Quand que la valeur du numéro de référence est inférieur au tableau T.
			 if (NumDeRe < T[milieu][0]) 
			 {
				 // recommence la fonction rechercheBinaire.
				 return rechercheBinaire(T,gauche,milieu-1,NumDeRe);
			 }
			 else 
			 {
				 // recommence la fonction rechercheBinaire.
				 return rechercheBinaire(T,milieu+1,droite,NumDeRe);
			 }
			 
		} // Fin fonction rechercheBinaire.
		
		// Fonction qui affiche les tableaux.
		function afficher(event:Event):void 
		{
			// Les messages du tableau.
			var affichage:String;
		    
			// Efface le txtQuestionMathResulat.
			txtnumeroQuestion.text = "";
			
			// Efface le txtReponse.
			txtReponse.text = "";
		  
		  	// Trouve toutes les messages.
			for (var rang:int = 0; rang < questionS.length; rang++) 
			{
				for( var col:int=0; col < questionS[0].length; col++)
				{
				  affichage =  affichage + questionS[rang][col];
				}
				affichage = affichage + "\n"; 
			}
			
			// Affiche tout les messages.
			txtpose.htmlText = affichage;
			 
		}// Fin affiche
	} // fin de la classe 
} // fin du package