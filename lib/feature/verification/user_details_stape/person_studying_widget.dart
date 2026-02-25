import 'package:flutter/material.dart';

class PersonStudyingWidget extends StatelessWidget {
  const PersonStudyingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          /// TITLE
          Row(
            children: const [
              Expanded(
                child: Text(
                  "If your are person who is studying  thing ...",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 20),

          /// TEXTFIELD
          TextField(
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
            decoration: const InputDecoration(
              hintText: "Enter school name, past or current",
              isDense: true,
              suffixIcon: Icon(Icons.close),// height kam
              contentPadding: EdgeInsets.zero, // padding remove
              border: InputBorder.none,
              hintStyle: TextStyle(
                fontSize: 18,
                color: Colors.grey,
              ),
            ),
          ),

          const SizedBox(height: 6),

          /// UNDERLINE
          Container(
            height: 1,
            width: double.infinity,
            color: Colors.grey.shade400,
          ),

        ],
      ),
    );
  }
}
