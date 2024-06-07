import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:realtbox/config/resources/color_manager.dart';
import 'package:realtbox/presentation/enquiry/bloc/enquiry_bloc.dart';

class BottomSheetWidget extends StatefulWidget {
  const BottomSheetWidget({super.key});

  @override
  _BottomSheetWidgetState createState() => _BottomSheetWidgetState();
}

class _BottomSheetWidgetState extends State<BottomSheetWidget> {
   final TextEditingController _field1Controller = TextEditingController();
   final TextEditingController _field2Controller = TextEditingController(text: "");

  void _submitData() {
    BlocProvider.of<EnquiryBloc>(context).add(
      OnEnquirySubmitted(
        mobileNumber: _field1Controller.text,
        message: _field2Controller.text,
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    BlocProvider.of<EnquiryBloc>(context).add(
      OnAppStarted());
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<EnquiryBloc, EnquiryState>(
      listener: (context, state) {
        if (state is EnquiryValidationSuccess) {
          Navigator.pop(context, {
            'mobile': _field1Controller.text,
            'message': _field2Controller.text,
          });
        }
        if(state is UserMobileNumber){
          _field1Controller.value = _field1Controller.value.copyWith(
                  text: state.mobile,
                  selection: TextSelection.fromPosition(
                    TextPosition(offset: state.mobile.length),
                  ),
                );
        }
      },
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
        child: SingleChildScrollView(
          child: SizedBox(
            width: double.infinity,
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Enquire Now',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextField(
                    keyboardType: const TextInputType.numberWithOptions(
                        signed: true, decimal: true),
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                    ],
                    maxLength: 10,
                    controller: _field1Controller,
                    decoration: InputDecoration(
                      labelText: 'Mobile Number',
                      border: const OutlineInputBorder(),
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Theme.of(context).primaryColor),
                      ),
                    ),
                    onChanged: (value) => 
                    BlocProvider.of<EnquiryBloc>(context).add(OnMobileNumberChanged(text: value)),
                  ),
                  const SizedBox(height: 20),
                  TextField(
                    controller: _field2Controller,
                    keyboardType: TextInputType.text,
                    maxLines: 3,
                    decoration: InputDecoration(
                      labelText: 'Message',
                      border: const OutlineInputBorder(),
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Theme.of(context).primaryColor),
                      ),
                    ),
                    onChanged: (value) => 
                    BlocProvider.of<EnquiryBloc>(context).add(OnValuesChanged()),
                  ),
                  const SizedBox(height: 10),
                  BlocBuilder<EnquiryBloc, EnquiryState>(
                    builder: (context, state) {
                      if (state is EnquiryValidationFailed) {
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
                              backgroundColor: Colors.green)),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
