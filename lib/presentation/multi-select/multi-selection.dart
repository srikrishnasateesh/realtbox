import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:realtbox/presentation/multi-select/bloc/multi_dropdown_bloc.dart';

class MultiSelectDropdownWidget extends StatelessWidget {
  const MultiSelectDropdownWidget({super.key});

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<MultiDropdownBloc>(context).add(SetItems(const ["Item 1", "Item 2", "Item 3"]));
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          BlocBuilder<MultiDropdownBloc, MultiDropdownState>(
            builder: (context, state) {
              return MultiSelectDropdown(
                items: state.items,
                selectedItems: state.selectedItems,
                onItemSelected: (item) {
                  context.read<MultiDropdownBloc>().add(ItemSelected(item));
                },
                onItemDeselected: (item) {
                  context.read<MultiDropdownBloc>().add(ItemDeselected(item));
                },
              );
            },
          ),
          SizedBox(height: 20),
          BlocBuilder<MultiDropdownBloc, MultiDropdownState>(
            builder: (context, state) {
              return Text('Selected Items: ${state.selectedItems.join(', ')}');
            },
          ),
        ],
      ),
    );
  }
}

class MultiSelectDropdown extends StatelessWidget {
  final List<String> items;
  final List<String> selectedItems;
  final ValueChanged<String> onItemSelected;
  final ValueChanged<String> onItemDeselected;

  MultiSelectDropdown({
    required this.items,
    required this.selectedItems,
    required this.onItemSelected,
    required this.onItemDeselected,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        List<String>? results = await showDialog<List<String>>(
          context: context,
          builder: (context) {
            return MultiSelectDialog(
              items: items,
              initiallySelectedItems: selectedItems,
            );
          },
        );

        if (results != null) {
          final bloc = context.read<MultiDropdownBloc>();
          bloc.add(SetItems(items));
          results.forEach((item) {
            if (!selectedItems.contains(item)) {
              bloc.add(ItemSelected(item));
            }
          });
          selectedItems.forEach((item) {
            if (!results.contains(item)) {
              bloc.add(ItemDeselected(item));
            }
          });
        }
      },
      child: InputDecorator(
        decoration: InputDecoration(
          labelText: 'Select Items',
          border: OutlineInputBorder(),
        ),
        child: Text(selectedItems.join(', ')),
      ),
    );
  }
}

class MultiSelectDialog extends StatefulWidget {
  final List<String> items;
  final List<String> initiallySelectedItems;

  MultiSelectDialog({
    required this.items,
    required this.initiallySelectedItems,
  });

  @override
  _MultiSelectDialogState createState() => _MultiSelectDialogState();
}

class _MultiSelectDialogState extends State<MultiSelectDialog> {
  late List<String> selectedItems;

  @override
  void initState() {
    super.initState();
    selectedItems = List.from(widget.initiallySelectedItems);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Select Items'),
      content: SingleChildScrollView(
        child: ListBody(
          children: widget.items.map((item) {
            return CheckboxListTile(
              value: selectedItems.contains(item),
              title: Text(item),
              controlAffinity: ListTileControlAffinity.leading,
              onChanged: (bool? checked) {
                setState(() {
                  if (checked ?? false) {
                    selectedItems.add(item);
                  } else {
                    selectedItems.remove(item);
                  }
                });
              },
            );
          }).toList(),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text('Cancel'),
        ),
        TextButton(
          onPressed: () {
            Navigator.pop(context, selectedItems);
          },
          child: Text('OK'),
        ),
      ],
    );
  }
}