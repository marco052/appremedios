import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:pharmacy_wiki/shared/theme/app_colors.dart';
import 'package:pharmacy_wiki/shared/theme/app_text_styles.dart';

class MedicineLeaflet extends StatelessWidget {
  const MedicineLeaflet({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: AppColors.background,
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 340, top: 30),
            child: TextButton.icon(
              icon: Icon(Icons.arrow_back_ios, color: AppColors.text),
              onPressed: () => {Navigator.pop(context)},
              label: Text(""),
              ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: Center(child: Text("Medicamento X", style: AppTextStyles.interRegularTitle,)),
          ),
          Expanded(
            child: SingleChildScrollView(
              dragStartBehavior: DragStartBehavior.start,
              child: Padding(
                padding: const EdgeInsets.only(left: 40, right: 40, bottom: 20),
                child: Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec nec arcu non ante iaculis venenatis at a nisi. Sed dictum mi a massa semper, eu rhoncus arcu maximus. Integer ultricies est sem, quis tristique tortor porta sed. Maecenas vulputate lorem turpis, interdum iaculis urna vestibulum vel. Aliquam eu nibh ex. Duis pellentesque diam convallis velit gravida cursus nec ut elit. Sed hendrerit augue et felis varius, in tempor dolor luctus. Vivamus mauris risus, sagittis at placerat quis, sollicitudin vitae mauris. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec nec arcu non ante iaculis venenatis at a nisi. Sed dictum mi a massa semper, eu rhoncus arcu maximus. Integer ultricies est sem, quis tristique tortor porta sed. Maecenas vulputate lorem turpis, interdum iaculis urna vestibulum vel. Aliquam eu nibh ex. Duis pellentesque diam convallis velit gravida cursus nec ut elit. Sed hendrerit augue et felis varius, in tempor dolor luctus. Vivamus mauris risus, sagittis at placerat quis, sollicitudin vitae mauris. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec nec arcu non ante iaculis venenatis at a nisi. Sed dictum mi a massa semper, eu rhoncus arcu maximus. Integer ultricies est sem, quis tristique tortor porta sed. Maecenas vulputate lorem turpis, interdum iaculis urna vestibulum vel. Aliquam eu nibh ex. Duis pellentesque diam convallis velit gravida cursus nec ut elit. Sed hendrerit augue et felis varius, in tempor dolor luctus. Vivamus mauris risus, sagittis at placerat quis, sollicitudin vitae mauris. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec nec arcu non ante iaculis venenatis at a nisi. Sed dictum mi a massa semper, eu rhoncus arcu maximus. Integer ultricies est sem, quis tristique tortor porta sed. Maecenas vulputate lorem turpis, interdum iaculis urna vestibulum vel. Aliquam eu nibh ex. Duis pellentesque diam convallis velit gravida cursus nec ut elit. Sed hendrerit augue et felis varius, in tempor dolor luctus. Vivamus mauris risus, sagittis at placerat quis, sollicitudin vitae mauris. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec nec arcu non ante iaculis venenatis at a nisi. Sed dictum mi a massa semper, eu rhoncus arcu maximus. Integer ultricies est sem, quis tristique tortor porta sed. Maecenas vulputate lorem turpis, interdum iaculis urna vestibulum vel. Aliquam eu nibh ex. Duis pellentesque diam convallis velit gravida cursus nec ut elit. Sed hendrerit augue et felis varius, in tempor dolor luctus. Vivamus mauris risus, sagittis at placerat quis, sollicitudin vitae mauris. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec nec arcu non ante iaculis venenatis at a nisi. Sed dictum mi a massa semper, eu rhoncus arcu maximus. Integer ultricies est sem, quis tristique tortor porta sed. Maecenas vulputate lorem turpis, interdum iaculis urna vestibulum vel. Aliquam eu nibh ex. Duis pellentesque diam convallis velit gravida cursus nec ut elit. Sed hendrerit augue et felis varius, in tempor dolor luctus. Vivamus mauris risus, sagittis at placerat quis, sollicitudin vitae mauris. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec nec arcu non ante iaculis venenatis at a nisi. Sed dictum mi a massa semper, eu rhoncus arcu maximus. Integer ultricies est sem, quis tristique tortor porta sed. Maecenas vulputate lorem turpis, interdum iaculis urna vestibulum vel. Aliquam eu nibh ex. Duis pellentesque diam convallis velit gravida cursus nec ut elit. Sed hendrerit augue et felis varius, in tempor dolor luctus. Vivamus mauris risus, sagittis at placerat quis, sollicitudin vitae mauris. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec nec arcu non ante iaculis venenatis at a nisi. Sed dictum mi a massa semper, eu rhoncus arcu maximus. Integer ultricies est sem, quis tristique tortor porta sed. Maecenas vulputate lorem turpis, interdum iaculis urna vestibulum vel. Aliquam eu nibh ex. Duis pellentesque diam convallis velit gravida cursus nec ut elit. Sed hendrerit augue et felis varius, in tempor dolor luctus. Vivamus mauris risus, sagittis at placerat quis, sollicitudin vitae mauris. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec nec arcu non ante iaculis venenatis at a nisi. Sed dictum mi a massa semper, eu rhoncus arcu maximus. Integer ultricies est sem, quis tristique tortor porta sed. Maecenas vulputate lorem turpis, interdum iaculis urna vestibulum vel. Aliquam eu nibh ex. Duis pellentesque diam convallis velit gravida cursus nec ut elit. Sed hendrerit augue et felis varius, in tempor dolor luctus. Vivamus mauris risus, sagittis at placerat quis, sollicitudin vitae mauris. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec nec arcu non ante iaculis venenatis at a nisi. Sed dictum mi a massa semper, eu rhoncus arcu maximus. Integer ultricies est sem, quis tristique tortor porta sed. Maecenas vulputate lorem turpis, interdum iaculis urna vestibulum vel. Aliquam eu nibh ex. Duis pellentesque diam convallis velit gravida cursus nec ut elit. Sed hendrerit augue et felis varius, in tempor dolor luctus. Vivamus mauris risus, sagittis at placerat quis, sollicitudin vitae mauris.",
                style: AppTextStyles.interTextArea, textAlign: TextAlign.justify),
              ),
            ),
          )
        ],
      ),
    );
  }
}