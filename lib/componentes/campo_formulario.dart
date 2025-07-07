import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CampoFormulario extends StatefulWidget {
  final TextEditingController controller;
  final FocusNode focusNode;
  final String label;
  final String placeholder;
  final Widget prefixIcon;
  final String? Function(String?)? validator;
  final List<TextInputFormatter>? inputFormatters;
  final bool isDateField;
  final bool isPasswordField;
  final bool isSelectField;
  final List<String>? selectOptions;

  const CampoFormulario({
    super.key,
    required this.controller,
    required this.focusNode,
    required this.label,
    required this.placeholder,
    required this.prefixIcon,
    required this.validator,
    required this.inputFormatters,
    this.isDateField = false,
    this.isPasswordField = false,
    this.isSelectField = false,
    this.selectOptions,
  });

  @override
  State<CampoFormulario> createState() => _CampoFormularioState();
}

class _CampoFormularioState extends State<CampoFormulario> {
  bool _isPasswordFieldVisible = false;
  List<String> _options = [];

  @override
  void initState() {
    super.initState();
    _options = widget.selectOptions ?? [];
  }

  Future<void> _selectDate(BuildContext context) async {
    widget.focusNode.unfocus();
    if (!context.mounted) return;
    final DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
      locale: const Locale('pt', 'BR'),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: Theme.of(context).primaryColorDark,
              onPrimary: Colors.white,
              onSurface: Theme.of(context).primaryColorDark,
            ),
          ),
          child: child!,
        );
      },
    );

    if (selectedDate != null && context.mounted) {
      final TimeOfDay? selectedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
        builder: (BuildContext context, Widget? child) {
          return Theme(
            data: Theme.of(context).copyWith(
              colorScheme: ColorScheme.light(
                primary: Theme.of(context).primaryColorDark,
                onPrimary: Colors.white,
                onSurface: Theme.of(context).primaryColorDark,
              ),
            ),
            child: child!,
          );
        },
      );

      if (selectedTime != null && context.mounted) {
        final DateTime combinedDateTime = DateTime(
          selectedDate.year,
          selectedDate.month,
          selectedDate.day,
          selectedTime.hour,
          selectedTime.minute,
        );
        widget.controller.text = '${UtilData.obterDataDDMMAAAA(combinedDateTime)} ${UtilData.obterHoraHHMM(combinedDateTime)}';
      }
    }
  }

  Future<void> _showSelectDialog() async {
    widget.focusNode.unfocus();
    String? selected = widget.controller.text.isNotEmpty ? widget.controller.text : null;

    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(widget.label),
          content: SizedBox(
            width: double.maxFinite,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ..._options.map((option) => ListTile(
                      title: Text(option),
                      trailing: selected == option
                          ? Icon(Icons.check, color: Colors.green)
                          : null,
                      onTap: () {
                        setState(() {
                          widget.controller.text = option;
                        });
                        Navigator.pop(context);
                      },
                    )),
                const Divider(),
                ListTile(
                  leading: Icon(Icons.add, color: Colors.blue),
                  title: Text('Adicionar nova'),
                  onTap: () async {
                    Navigator.pop(context);
                    await _showAddNewDialog();
                  },
                )
              ],
            ),
          ),
        );
      },
    );
  }

  Future<void> _showAddNewDialog() async {
    String newOption = '';
    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Adicionar nova'),
        content: TextField(
          autofocus: true,
          decoration: const InputDecoration(hintText: 'Digite aqui'),
          onChanged: (value) {
            newOption = value;
          },
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancelar'),
          ),
          ElevatedButton(
            onPressed: () {
              if (newOption.trim().isNotEmpty) {
                setState(() {
                  _options.add(newOption.trim());
                  widget.controller.text = newOption.trim();
                });
              }
              Navigator.pop(context);
            },
            child: const Text('Adicionar'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: TextFormField(
        cursorColor: Colors.grey,
        controller: widget.controller,
        focusNode: widget.focusNode,
        validator: widget.validator,
        readOnly: widget.isDateField || widget.isSelectField,
        onTap: widget.isDateField
            ? () => _selectDate(context)
            : widget.isSelectField
                ? () => _showSelectDialog()
                : null,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        decoration: InputDecoration(
          labelText: widget.label,
          hintText: widget.placeholder,
          floatingLabelBehavior: FloatingLabelBehavior.auto,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.grey),
            borderRadius: BorderRadius.circular(10),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.green, width: 2),
            borderRadius: BorderRadius.circular(10),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.red, width: 2),
            borderRadius: BorderRadius.circular(10),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.red, width: 2),
            borderRadius: BorderRadius.circular(10),
          ),
          prefixIcon: widget.prefixIcon,
          suffixIcon: widget.isPasswordField
              ? IconButton(
                  onPressed: () {
                    setState(() {
                      _isPasswordFieldVisible = !_isPasswordFieldVisible;
                    });
                  },
                  icon: Icon(
                    _isPasswordFieldVisible ? Icons.visibility : Icons.visibility_off,
                    color: Colors.grey,
                  ),
                )
              : null,
        ),
        obscureText: widget.isPasswordField && !_isPasswordFieldVisible,
        textAlign: TextAlign.left,
        style: const TextStyle(fontSize: 16),
        inputFormatters: widget.inputFormatters,
      ),
    );
  }
}