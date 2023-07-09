import 'package:flutter/material.dart';

List<String> imgs = [
  "https://img.freepik.com/photos-gratuite/portrait-belle-jeune-femme-gesticulant_273609-41056.jpg?w=826&t=st=1688759510~exp=1688760110~hmac=8e724d6dd77e4ddcfde4270a3e17675ad9cbd5212d80819c10d7e6c7a6479c04",
  "https://img.freepik.com/photos-gratuite/pizza-fraichement-italienne-tranche-fromage-mozzarella-ia-generative_188544-12347.jpg?w=826&t=st=1688756507~exp=1688757107~hmac=e214ecebf359358745aeddfd09b0b83202422d9653ec87f0bc3da3ca0cd316f2",
  "https://img.freepik.com/photos-gratuite/gros-coup-bel-homme-race-blanche-barbe-vetu-t-shirt-recherche-souriant-expression-joyeuse-heureuse-assis-au-restaurant-trottoir-journee-ensoleillee-attente-amis_273609-6600.jpg?w=740&t=st=1688819218~exp=1688819818~hmac=dbd90ca95ebe27be6deb3db6a7d2db6b0af55c25dc5a5f45c30030a6a428887b",
  "https://img.freepik.com/photos-gratuite/homme-ecarte-paumes-se-sent-desempare-incertain-ne-peut-pas-faire-choix-porte-lunettes-rondes-chemise-jean-pose_273609-51731.jpg?w=740&t=st=1688819317~exp=1688819917~hmac=fbca76e215a9d1d80f95a685dbb4051edf931513295aaef164a7c3020ca3ecd1"
      "https://png.pngitem.com/pimgs/s/454-4545381_promotion-stars-hd-png-download.png",
];
Widget defaultTextField(
    {required TextEditingController controller,
    required icons,
    required String hint,
    required String label}) {
  return Container(
    padding: EdgeInsets.all(8),
    child: TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        prefixIcon: Icon(icons),
        border: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.blue,
            width: 2.0,
          ),
        ),
      ),
    ),
  );
}
