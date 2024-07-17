import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:realtbox/config/resources/color_manager.dart';
import 'package:realtbox/presentation/delete_account/bloc/delete_account_bloc.dart';

class DeleteAccountBottomsheet extends StatelessWidget {
  const DeleteAccountBottomsheet({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController textEditingController = TextEditingController();
    void _submitData() {
      context
          .read<DeleteAccountBloc>()
          .add(OnFormSubmit(reason: textEditingController.text));
    }

    return BlocListener<DeleteAccountBloc, DeleteAccountState>(
      listener: (context, state) {
        if (state is Navigate) {
          Navigator.pushNamedAndRemoveUntil(
              context, state.route, (route) => true);
        }
      },
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: SizedBox(
            width: double.infinity,
            child: Stack(
              children: [
                Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Delete Account',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                      const SizedBox(height: 20),
                      TextField(
                        controller: textEditingController,
                        keyboardType: TextInputType.text,
                        maxLines: 3,
                        decoration: InputDecoration(
                          labelText: 'Reason',
                          border: const OutlineInputBorder(),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Theme.of(context).primaryColor),
                          ),
                        ),
                        onChanged: (value) => {},
                      ),
                      BlocBuilder<DeleteAccountBloc, DeleteAccountState>(
                        builder: (context, state) {
                          if (state is ValidationError) {
                            return Center(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(state.message,
                                    style: const TextStyle(color: Colors.red)),
                              ),
                            );
                          } else {
                            return Container();
                          }
                        },
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      OverflowBar(
                        spacing: 5,
                        alignment: MainAxisAlignment.end,
                        overflowAlignment: OverflowBarAlignment.end,
                        children: [
                          FilledButton.icon(
                            onPressed: () => Navigator.pop(context),
                            icon: const Icon(Icons.close),
                            label: const Text('Cancel'),
                            iconAlignment: IconAlignment.start,
                            style: FilledButton.styleFrom(
                                backgroundColor: Colors.white,
                                foregroundColor: Colors.red),
                          ),
                          FilledButton.icon(
                            onPressed: () => _submitData(),
                            icon: const Icon(Icons.done),
                            label: const Text('Submit'),
                            iconAlignment: IconAlignment.start,
                            style: FilledButton.styleFrom(
                                backgroundColor: Colors.green),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                BlocBuilder<DeleteAccountBloc, DeleteAccountState>(
                  builder: (context, state) {
                    if (state is ShowProgress) {
                      return const Center(
                        child: CircularProgressIndicator.adaptive(
                          backgroundColor: kPrimaryColor,
                          valueColor:
                              AlwaysStoppedAnimation<Color>(kSecondaryColor),
                        ),
                      );
                    }
                    return Container();
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
