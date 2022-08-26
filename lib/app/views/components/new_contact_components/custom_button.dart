import 'package:agenda_eletronica/app/controllers/add_contact_controller.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  const CustomButton(this.controller, {Key? key}) : super(key: key);
  final AddContactController controller;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 14.0, top: 10),
      child: Row(
        children: [
          SizedBox(
            height: 50,
            width: MediaQuery.of(context).size.width / 2.0,
            child: OutlinedButton.icon(
              icon: const Icon(Icons.add),
              onPressed: () {},
              style: ButtonStyle(
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                      side: const BorderSide(color: Colors.red)),
                ),
              ),
              label: const Text(
                'Criar Lembrete',
                style: TextStyle(color: Colors.white, fontSize: 19),
              ),
            ),
          ),
          const Text('testeee'),
        ],
      ),
    );
  }
}
