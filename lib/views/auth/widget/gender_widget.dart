import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mra/utils/widget/gap.dart';

class GenderSelectionWidget extends StatefulWidget {
  final Function(String) onGenderSelected;

  const GenderSelectionWidget({super.key, required this.onGenderSelected});

  @override
  State<GenderSelectionWidget> createState() => _GenderSelectionWidgetState();
}

class _GenderSelectionWidgetState extends State<GenderSelectionWidget> {
  String? _selectedGender;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildGenderButton('Male'),
            Gap(10.w),
            _buildGenderButton('Female'),
          ],
        ),
        const SizedBox(height: 20),
        if (_selectedGender != null)
          Text(
            'You selected: $_selectedGender',
            style: const TextStyle(fontSize: 16, color: Colors.blue),
          ),
      ],
    );
  }

  Widget _buildGenderButton(String gender) {
    return ElevatedButton(
      onPressed: () {
        setState(() {
          _selectedGender = gender;
        });
        widget.onGenderSelected(gender);
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: _selectedGender == gender ? Colors.blue : Colors.grey,
      ),
      child: Text(gender),
    );
  }
}
