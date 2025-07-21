import 'dart:io';
import 'package:flutter/material.dart';
import 'package:file_selector/file_selector.dart';
import 'package:kendin_ye/data/models/user.dart';

class ProfileScreen extends StatefulWidget {
  final User user;

  const ProfileScreen({super.key, required this.user});

  @override
  ProfileScreenState createState() => ProfileScreenState();
}

class ProfileScreenState extends State<ProfileScreen> {
  late TextEditingController _firstNameController;
  late TextEditingController _lastNameController;
  late TextEditingController _phoneController;
  late TextEditingController _passwordController;
  String? _profileImagePath;

  @override
  void initState() {
    super.initState();
    _firstNameController = TextEditingController(text: widget.user.firstName);
    _lastNameController = TextEditingController(text: widget.user.lastName);
    _phoneController = TextEditingController(text: widget.user.phoneNumber);
    _passwordController = TextEditingController(text: widget.user.password);
    _profileImagePath = widget.user.profileImage.isNotEmpty
        ? widget.user.profileImage
        : null;
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _pickImage() async {
    final XFile? file = await openFile(
      acceptedTypeGroups: [
        XTypeGroup(label: 'images', extensions: ['jpg', 'png', 'jpeg']),
      ],
    );
    if (file != null) {
      setState(() => _profileImagePath = file.path);
    }
  }

  void _saveProfile() {
    // Create updated User object with new values
    final updatedUser = User(
      username: widget.user.username,
      password: _passwordController.text,
      firstName: _firstNameController.text,
      lastName: _lastNameController.text,
      phoneNumber: _phoneController.text,
      profileImage: _profileImagePath ?? '',
    );
    updateUser(updatedUser);
    Navigator.of(context).pop(updatedUser);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    ImageProvider? avatar;
    if (_profileImagePath != null && _profileImagePath!.isNotEmpty) {
      // Use AssetImage for bundled assets, FileImage for picked files
      avatar = _profileImagePath!.startsWith('assets/')
          ? AssetImage(_profileImagePath!)
          : FileImage(File(_profileImagePath!));
    }

    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Theme.of(context).colorScheme.onPrimary,
        ),
        elevation: 4,
        shadowColor: Theme.of(context).colorScheme.onSecondary,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(20)),
        ),
        title: Text(
          '${widget.user.firstName} ${widget.user.lastName}',
          style: TextStyle(
            fontFamily: 'SegoeUI',
            fontWeight: FontWeight.bold,
            fontSize: 20,
            color: Theme.of(context).colorScheme.onPrimary,
          ),
        ),
        backgroundColor: theme.primaryColor,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: _pickImage,
              child: CircleAvatar(
                radius: 80,
                backgroundColor: theme.colorScheme.surface,
                backgroundImage: avatar,
                child: avatar == null
                    ? Icon(
                        Icons.person,
                        size: 60,
                        color: theme.colorScheme.onSurface,
                      )
                    : null,
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _firstNameController,
              decoration: const InputDecoration(labelText: 'First Name'),
            ),
            TextField(
              controller: _lastNameController,
              decoration: const InputDecoration(labelText: 'Last Name'),
            ),
            TextField(
              controller: _phoneController,
              decoration: const InputDecoration(labelText: 'Phone Number'),
              keyboardType: TextInputType.phone,
            ),
            TextField(
              controller: _passwordController,
              decoration: const InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            TextField(
              controller: TextEditingController(text: widget.user.username),
              decoration: const InputDecoration(labelText: 'Username'),
              enabled: false,
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: _saveProfile,
              style: ElevatedButton.styleFrom(
                backgroundColor: theme.primaryColor,
                minimumSize: Size(250, 50),
              ),
              child: const Text('Save', style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }
}
