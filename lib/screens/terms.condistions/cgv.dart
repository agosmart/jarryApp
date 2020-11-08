import 'package:flutter/material.dart';
import 'package:jariapp/themes/colors.dart';
import 'package:jariapp/widgets/title.text.dart';

class CGVPage extends StatelessWidget {
  const CGVPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: TitleText(
          color: AppColors.black,
          fontSize: 16.0,
          uppercase: true,
          fontWeight: FontWeight.w600,
          textAlign: TextAlign.center,
          text: 'Conditions Générales ',
        ),
        elevation: 0,
        backgroundColor: AppColors.white,
        iconTheme: IconThemeData(color: AppColors.icongray),
      ),

      //++++++++++++++++++++++++++++++++++++++++++++++++++++++
      body: SafeArea(
        child: InteractiveViewer(
          maxScale: 2.5,
          minScale: 1,
          //+++++++++++++++++++++
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  BodyText(
                      text:
                          'Merci de lire attentivement les Conditions Générales de Vente et d’utilisation ci-dessous avant de passer une/des commande(s) des produits DANONE sur JARRY. En passant une telle commande sur notre application, vous acceptez de vous soumettre à ces Conditions Générales de Vente et d’utilisation.'),
                  //+++++++++++++++++++++++++++++++++++
                  SizedBox(height: 20.0),
                  //+++++++++++++++++++++++++++++++++++
                  Container(
                    width: double.maxFinite,
                    child: TitleText(
                      color: AppColors.black,
                      fontSize: 16.0,
                      uppercase: true,
                      fontWeight: FontWeight.w600,
                      textAlign: TextAlign.center,
                      text: 'Section 1 :',
                    ),
                  ),
                  BodyText(
                      text:
                          'Présentation de JARRY est une Application de DANONE DJURDJURA ALGERIE SPA.'),
                  //+++++++++++++++++++++++++++++++++++
                  SizedBox(height: 20.0),
                  //+++++++++++++++++++++++++++++++++++

                  Container(
                    width: double.maxFinite,
                    child: TitleText(
                      color: AppColors.black,
                      fontSize: 16.0,
                      uppercase: true,
                      fontWeight: FontWeight.w600,
                      textAlign: TextAlign.center,
                      text: ' Section 2 : Définitions',
                    ),
                  ),
                  //+++++++++++++++++++++++++++++++++++
                  SizedBox(height: 16.0),
                  //+++++++++++++++++++++++++++++++++++
                  BodyText(
                      text:
                          '2.1. “Accord” se réfère à ces Conditions Générales de Vente et d’utilisation (CGV/CGU)'),
                  SizedBox(height: 16.0),
                  BodyText(
                      text:
                          '2.2. “vous”, “votre”, et “vos” se réfèrent à vous, la personne accédant à l’application, et passant commande pour des produits Danone. L’accès à JARRY vous lie également à ces CGV/CGU ;'),
                  SizedBox(height: 16.0),
                  BodyText(
                      text:
                          '2.3. “nous”, “notre”, “nos” et JARRY " se réfèrent à l’entreprise DANONE DJURDJURA ALGERIE ;'),
                  SizedBox(height: 16.0),
                  BodyText(
                      text:
                          '2.4. “Produits” se réfèrent à tous les produits que nous proposons à la vente sur notre application mobile pendant une période donnée ;'),
                  SizedBox(height: 16.0),
                  BodyText(
                      text:
                          '2.5. "Livraison de Produits Danone" se réfère à des produits périssables et à toutes les formes de service de livraison, tous deux fournis par nos collaborateurs, et desquels l’entreprise assument l’entière responsabilité ;'),
                  SizedBox(height: 16.0),
                  BodyText(
                      text:
                          '2.6. “APPLICATION JARRY” se réfère à notre application mobile pour vous proposer des produits et service de livraison'),
                  //+++++++++++++++++++++++++++++++++++
                  SizedBox(height: 20.0),
                  //+++++++++++++++++++++++++++++++++++

                  Container(
                    width: double.maxFinite,
                    child: TitleText(
                      color: AppColors.black,
                      fontSize: 16.0,
                      uppercase: true,
                      fontWeight: FontWeight.w600,
                      textAlign: TextAlign.center,
                      text: ' Section 3 : Commander',
                    ),
                  ),
                  //+++++++++++++++++++++++++++++++++++
                  SizedBox(height: 16.0),
                  //+++++++++++++++++++++++++++++++++++
                  BodyText(
                      text:
                          '3.1. Tout contrat pour la fourniture de Livraison de produits Danone sur cette application se fait entre vous et Danone DJURDJURA ALGERIE, et tout contact se fait entre vous et DANONE DJURDJURA ALGERIE. Vous acceptez de nous apporter toutes les informations vous concernant ainsi que votre commande. Lorsque vous passez une commande, assurez-vous que ces informations sont exactes et à jour.'),
                  SizedBox(height: 16.0),
                  BodyText(
                      text:
                          '3.2. Toute commande passée sur notre Application est sujette à la disponibilité, la capacité de livraison, et à son acceptation par Danone Djurdjura Algérie. Une fois la commande passée en ligne, un livreur vous contactera par téléphone afin de confirmer les détails de la commande ainsi que les délais de livraison.'),
                  SizedBox(height: 16.0),
                  BodyText(
                      text:
                          '3.3. Si des produits proposés par Jarry sont commandés, Danone Djurdjura Algérie confirmera leurs disponibilités en liaison avec le stock disponible.'),
                  SizedBox(height: 16.0),
                  BodyText(
                      text:
                          "3.4. La livraison d’une commande se fait le jour même si la commande est faite avant midi 14H. Dans le cas contraire le délai de livraison est de 24H après la commande."),
                  SizedBox(height: 16.0),
                  BodyText(
                      text:
                          "3.5. Si la livraison des produits n’est pas possible ou si la capacité de livraison n’est pas suffisante, nous vous en tiendrons informé par message textuel (SMS) ou par appel téléphonique."),
                  SizedBox(height: 16.0),
                  BodyText(
                      text:
                          "3.6. La livraison des produits n’est pas disponible le vendredi et les jours fériées, les commandes de ces journées se feront à partir de la journée suivante."),
                  //+++++++++++++++++++++++++++++++++++
                  SizedBox(height: 20.0),
                  //+++++++++++++++++++++++++++++++++++

                  Container(
                    width: double.maxFinite,
                    child: TitleText(
                      color: AppColors.black,
                      fontSize: 16.0,
                      uppercase: true,
                      fontWeight: FontWeight.w600,
                      textAlign: TextAlign.center,
                      text: ' Section 4 :',
                    ),
                  ),
                  //+++++++++++++++++++++++++++++++++++
                  SizedBox(height: 16.0),
                  //+++++++++++++++++++++++++++++++++++
                  BodyText(
                      text:
                          '4.1. Tous les prix affichés sur l’application Jarry sont exacts au moment de leurs publication ; cependant nous nous réservons le droit de les modifier dans le futur. Nous nous réservons également le droit de modifier des produits disponibles à la vente sur JARRY, et d’arrêter de référencer des Produits.'),

                  //+++++++++++++++++++++++++++++++++++
                  SizedBox(height: 20.0),
                  //+++++++++++++++++++++++++++++++++++

                  Container(
                    width: double.maxFinite,
                    child: TitleText(
                      color: AppColors.black,
                      fontSize: 16.0,
                      uppercase: true,
                      fontWeight: FontWeight.w600,
                      textAlign: TextAlign.center,
                      text: 'Section 5 : Livraison',
                    ),
                  ),
                  //+++++++++++++++++++++++++++++++++++
                  SizedBox(height: 16.0),
                  //+++++++++++++++++++++++++++++++++++

                  BodyText(
                      text:
                          "5.1. Le délai de livraison est communiqué par le livreur au moment de la commande. Ce dernier doit être considérés de manière approximative seulement."),
                  SizedBox(height: 16.0),
                  BodyText(
                      text:
                          "5.2. Toute remarque qualitative liée aux produits doit être communiquée au Customer care center au 034 19 61 69"),
                  SizedBox(height: 16.0),
                  BodyText(
                      text:
                          "5.3. Les collaborateurs qui prépareront votre commande ont pour but : "),
                  Padding(
                    padding: const EdgeInsets.only(top: 4, left: 20),
                    child: BodyText(
                        text:
                            "5.3.1. De vous livrer le produit au lieu de livraison convenu par vos soins lors de la commande ;"),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 4, left: 20),
                    child: BodyText(text: "5.3.2. De livrer dans le temps ;"),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 4, left: 20),
                    child: BodyText(
                        text:
                            "5.3.3. De vous informer s’ils estiment ne pas pouvoir livrer dans le temps imparti."),
                  ),

                  SizedBox(height: 16.0),
                  BodyText(
                      text:
                          "5.4. Merci de prendre en compte l’impossibilité pour les collaborateurs de livrer à certains endroits. Si c’est le cas, le collaborateur vous informera en vous contactant grâce aux contacts que vous nous aurez transmis au moment de passer la commande, et vous proposera l’annulation de la commande ou la livraison à une adresse alternative ;"),

                  //+++++++++++++++++++++++++++++++++++
                  SizedBox(height: 20.0),
                  //+++++++++++++++++++++++++++++++++++

                  Container(
                    width: double.maxFinite,
                    child: TitleText(
                      color: AppColors.black,
                      fontSize: 16.0,
                      uppercase: true,
                      fontWeight: FontWeight.w600,
                      textAlign: TextAlign.center,
                      text: 'Section 6 : Annulation',
                    ),
                  ),
                  //+++++++++++++++++++++++++++++++++++
                  SizedBox(height: 16.0),
                  //+++++++++++++++++++++++++++++++++++

                  BodyText(
                      text:
                          "6.1. Une fois la commande validée sur l’application, vous pouvez l’annuler directement via le bouton annuler dans votre panier de commande. "),
                  SizedBox(height: 16.0),
                  BodyText(
                      text:
                          "6.2. En cas de non-possibilité de répondre à votre commande, l’annulation ou la modification vous sera communiqué par notre collaborateur par téléphone."),
                  //+++++++++++++++++++++++++++++++++++
                  SizedBox(height: 20.0),
                  //+++++++++++++++++++++++++++++++++++

                  Container(
                    width: double.maxFinite,
                    child: TitleText(
                      color: AppColors.black,
                      fontSize: 16.0,
                      uppercase: true,
                      fontWeight: FontWeight.w600,
                      textAlign: TextAlign.center,
                      text: 'Section 7 : Information',
                    ),
                  ),
                  //+++++++++++++++++++++++++++++++++++
                  SizedBox(height: 16.0),
                  //+++++++++++++++++++++++++++++++++++

                  BodyText(
                      text:
                          "7.1. Là où nous vous demandons des informations pour vous livrer les produits, vous acceptez de nous donner des informations complètes et exactes."),
                  SizedBox(height: 16.0),
                  BodyText(
                      text:
                          "7.2. Danone Djurdjura Algérie n’utilise vos données personnelles qu’à des fins liées à achat via l’application JARRY.Nous considérons la protection de vos données personnelles comme un enjeu important. Nous assurons une protection stricte de vos informations au niveau de nos serveurs. Danone Djurdjura Algérie ne vend ni ne loue vos données personnelles à des tiers dans un but marketing. »"),

                  //+++++++++++++++++++++++++++++++++++
                  SizedBox(height: 20.0),
                  //+++++++++++++++++++++++++++++++++++

                  Container(
                    width: double.maxFinite,
                    child: TitleText(
                      color: AppColors.black,
                      fontSize: 16.0,
                      uppercase: true,
                      fontWeight: FontWeight.w600,
                      textAlign: TextAlign.center,
                      text: 'Section 8 : Réclamation',
                    ),
                  ),
                  //+++++++++++++++++++++++++++++++++++
                  SizedBox(height: 16.0),
                  //+++++++++++++++++++++++++++++++++++
                  BodyText(
                      text:
                          "Nous prenons les réclamations très au sérieux et plaçons les clients au centre de notre activité. Nous faisons tout notre possible pour vous répondre dans les 7 jours ouvrés. Merci d’adresser vos réclamations au 034 19 61 69"),

                  //+++++++++++++++++++++++++++++++++++
                  SizedBox(height: 20.0),
                  //+++++++++++++++++++++++++++++++++++

                  Container(
                    width: double.maxFinite,
                    child: TitleText(
                      color: AppColors.black,
                      fontSize: 16.0,
                      uppercase: true,
                      fontWeight: FontWeight.w600,
                      textAlign: TextAlign.center,
                      text: 'Section 9 : Limitation de responsabilité',
                    ),
                  ),
                  //+++++++++++++++++++++++++++++++++++
                  SizedBox(height: 16.0),
                  //+++++++++++++++++++++++++++++++++++

                  BodyText(
                      text:
                          "9.1. Nous prenons le plus grand soin de vérifier l’exactitude des données de l’application. Si des erreurs apparaissent, nous nous en excusons. Nous ne pouvons pas garantir que l’utilisation de notre application sera faite à bon escient ou de manière totalement sûre. Nous ferons de notre mieux pour corriger de telles erreurs rapidement et efficacement. "),
                  SizedBox(height: 16.0),
                  BodyText(
                      text:
                          "9.2. Nous ne pouvons pas non plus garantir que notre application ou le serveur sont vierges de tout virus ou bug ou représentent toutes les fonctionnalités, l’exactitude et la fiabilité du site internet. Nous ne garantissons pas non plus l’adéquation à l’usage."),
                  SizedBox(height: 16.0),
                  BodyText(
                      text:
                          "9.3. Nous déclinons toute responsabilité concernant les retards, échecs, omissions ou pertes d’informations transmises, les virus ou autre contamination envoyés à votre appareil via notre application."),
                  SizedBox(height: 16.0),
                  BodyText(
                      text:
                          "9.4. Danone Djurdjura Algérie ne sera tenus responsable d’aucune défaillance, erreur ou retard dans l'exécution de ses services ou durant la livraison de produits, lorsque ce défaut survient à la suite de tout acte, qui est hors de notre contrôle raisonnable, comme tous les événements extrêmes et inévitables causés directement et exclusivement par les forces de la nature et hors du porté de Danone Djurdjura Algérie"),
                  SizedBox(height: 16.0),
                  BodyText(
                      text:
                          "9.5. Les offres sont sujettes à la volonté de Danone Djurdjura Algérie et peuvent être retirées à tout moment sans notification."),

                  //+++++++++++++++++++++++++++++++++++
                  SizedBox(height: 20.0),
                  //+++++++++++++++++++++++++++++++++++

                  Container(
                    width: double.maxFinite,
                    child: TitleText(
                      color: AppColors.black,
                      fontSize: 16.0,
                      uppercase: true,
                      fontWeight: FontWeight.w600,
                      textAlign: TextAlign.center,
                      text: 'Section 10 : Généralités',
                    ),
                  ),
                  //+++++++++++++++++++++++++++++++++++
                  SizedBox(height: 16.0),
                  //+++++++++++++++++++++++++++++++++++
                  /* RichText(
                    textAlign: TextAlign.center,
                    softWrap: true,
                    text: TextSpan(
                      style: TextStyle(fontSize: 16, color: AppColors.icongray),
                      children: [
                        TextSpan(
                            text: "10.1",
                            style: TextStyle(fontWeight: FontWeight.w600)),
                        TextSpan(
                          text: "Tous les prix sont en Dinar Algérien DA",
                        )
                      ],
                    ),
                  ),
                  */

                  BodyText(
                      text: "10.1. Tous les prix sont en Dinar Algérien DA"),
                  SizedBox(height: 16.0),
                  BodyText(
                      text:
                          "10.2. Nous pouvons sous-traiter toutes les parties services que nous vous proposons et nous pouvons assigner une partie de nos droits cités dans ces CGV sans votre consentement ou sans vous en notifier par avance."),
                  SizedBox(height: 16.0),
                  BodyText(
                      text:
                          "10.3. Nous nous réservons le droit de modifier les Conditions Générales de Vente à tout moment sans vous en tenir informé."),
                  SizedBox(height: 16.0),
                  BodyText(
                      text:
                          "10.4. Le paiement doit être effectué au moment la livraison en espèces. Le non-paiement de la commande à temps entraînera son annulation."),
                  SizedBox(height: 16.0),
                  BodyText(
                      text:
                          "10.5. Les Conditions Générales de Vente et d’utilisation, une commande et une instruction de paiement constitue un accord entre vous et nous. Aucun autre terme ne peut faire partie de cet accord. Dans l’éventualité d’un conflit entre ces Conditions Générales de Vente et d’autres termes sur l’application, les Conditions Générales de Vente prévalent."),
                  SizedBox(height: 16.0),
                  BodyText(
                      text:
                          "10.6. Si un terme ou une condition de notre accord est détermine invalide, illégal ou inapplicable, les partis s’accordent sur le fit que ce terme ou cette condition doit être détruit et que le reste de l’accord continue sans ce terme ou cette condition."),
                  SizedBox(height: 16.0),
                  BodyText(
                      text:
                          "10.7. Ces Conditions Générales de Vente et notre accord doivent être gouvernées et interprétées selon les lois algériennes. Les partis sont soumis à la juridiction exclusive des tribunaux algériens."),
                  SizedBox(height: 16.0),
                  BodyText(
                      text:
                          "10.8. Tout retard ou incapacité à faire respecter les termes du présent contrat ne constitue pas une renonciation de notre part à nos droits sauf dans le cas où notre renonciation est confirmée par écrit."),
                  SizedBox(height: 16.0),
                  BodyText(
                      text:
                          "10.9. Ces Conditions Générales de Vente et un contrat (et toutes les obligations non-contractuelles qui y sont liées ou en découlent) doivent être gouvernées et interprétées en accord avec les lois algériennes. Nous et vous nous soumettons à la non-exclusive juridiction des tribunaux algériens."),

                  //+++++++++++++++++++++++++++++++++++
                  SizedBox(height: 40.0),
                  //+++++++++++++++++++++++++++++++++++
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
