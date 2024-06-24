import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:realtbox/config/resources/color_manager.dart';
import 'package:realtbox/presentation/budget-dropdown/bloc/budget_dropdown_bloc.dart';
import 'package:realtbox/presentation/widgets/basic_text.dart';

class BudgetDropDownFiled extends StatelessWidget {
  final String title;
  final Function(String? selectedItem) onValueChanged;
  const BudgetDropDownFiled({
    super.key,
    required this.title,
    required this.onValueChanged,
  });

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<BudgetDropdownBloc>(context).add(LoadDropdownItems());
    return BlocBuilder<BudgetDropdownBloc, BudgetDropdownState>(
      builder: (context, state) {
        if (state is DropdownLoaded) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              height: 90,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 3.0),
                    child: BasicText(
                      text: title,
                      textStyle: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  ButtonTheme(
                    alignedDropdown: true,
                    child: DropdownButtonFormField<String>(
                      value: state.selectedItem,
                      focusColor: kPrimaryColor,
                      isDense: true,
                      isExpanded: true,
                      onChanged: (value) {
                        context
                            .read<BudgetDropdownBloc>()
                            .add(SelectDropdownItem(value!));
                        if (value != state.items.first) {
                          onValueChanged(value);
                        } else {
                          onValueChanged(null);
                        }
                      },
                      items: state.items
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: SizedBox(
                              width: double.infinity, child: Text(value)),
                        );
                      }).toList(),
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: const BorderSide(color: dropdownBoarder),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: const BorderSide(color: kPrimaryColor),
                        ),
                      ),
                      dropdownColor: Colors.white,
                      style: const TextStyle(color: kSecondaryColor),
                      icon: const Icon(Icons.keyboard_arrow_down,
                          color: kSecondaryColor),
                    ),
                  ),
                ],
              ),
            ),
          );
        }
        return Container();
      },
    );
  }
}
