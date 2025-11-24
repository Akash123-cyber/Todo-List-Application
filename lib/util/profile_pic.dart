// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'dart:io';

// class ProfilePictureWidget extends StatefulWidget {
//   @override
//   _ProfilePictureWidgetState createState() => _ProfilePictureWidgetState();
// }

// class _ProfilePictureWidgetState extends State<ProfilePictureWidget> {
//   File? _profileImage;
//   final ImagePicker _picker = ImagePicker();

//   // Function to show the profile picture popup
//   void _showProfilePicturePopup() {
//     showDialog(
//       context: context,

//       builder: (BuildContext context) {
//         return Dialog(
//           backgroundColor: Colors.transparent,

//           child: SafeArea(
//             child: Container(
//               decoration: BoxDecoration(
//                 gradient: LinearGradient(
//                   colors: [Color(0xff2d1b69), Color(0xff1a1b3a)],
//                   begin: Alignment.topLeft,
//                   end: Alignment.centerRight,
//                 ),
//                 borderRadius: BorderRadius.circular(20),
//                 border: Border.all(
//                   color: Colors.white.withOpacity(0.2),
//                   width: 1,
//                 ),
//               ),
//               padding: EdgeInsets.all(20),
//               child: Column(
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   // Large profile picture
//                   Container(
//                     width: 200,
//                     height: 200,
//                     decoration: BoxDecoration(
//                       shape: BoxShape.circle,
//                       border: Border.all(
//                         color: Colors.white.withOpacity(0.3),
//                         width: 2,
//                       ),
//                     ),
//                     child: ClipOval(
//                       child: _profileImage != null
//                           ? Image.file(
//                               _profileImage!,
//                               fit: BoxFit.cover,
//                               width: 200,
//                               height: 200,
//                             )
//                           : Container(
//                               color: Colors.grey[300],
//                               child: Icon(
//                                 Icons.person,
//                                 size: 100,
//                                 color: Colors.grey[600],
//                               ),
//                             ),
//                     ),
//                   ),

//                   SizedBox(height: 20),

//                   // TextField(),

//                   // SizedBox(height: 20),

//                   // Action buttons
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                     children: [
//                       // Camera button
//                       ElevatedButton.icon(
//                         onPressed: () => _pickImage(ImageSource.camera),
//                         icon: Icon(Icons.camera_alt, color: Colors.white),
//                         label: Text(
//                           'Camera',
//                           style: TextStyle(color: Colors.white),
//                         ),
//                         style: ElevatedButton.styleFrom(
//                           backgroundColor: Color(0xff4facfe),
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(10),
//                           ),
//                         ),
//                       ),

//                       // Gallery button
//                       ElevatedButton.icon(
//                         onPressed: () => _pickImage(ImageSource.gallery),
//                         icon: Icon(Icons.photo_library, color: Colors.white),
//                         label: Text(
//                           'Gallery',
//                           style: TextStyle(color: Colors.white),
//                         ),
//                         style: ElevatedButton.styleFrom(
//                           backgroundColor: Color(0xff4facfe),
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(10),
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),

//                   SizedBox(height: 15),

//                   // Close button
//                   TextButton(
//                     onPressed: () => Navigator.of(context).pop(),
//                     child: Text(
//                       'Close',
//                       style: TextStyle(color: Colors.white, fontSize: 16),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         );
//       },
//     );
//   }

//   // Function to pick image from camera or gallery
//   Future<void> _pickImage(ImageSource source) async {
//     try {
//       final XFile? pickedFile = await _picker.pickImage(
//         source: source,
//         maxWidth: 500,
//         maxHeight: 500,
//         imageQuality: 80,
//       );

//       if (pickedFile != null) {
//         setState(() {
//           _profileImage = File(pickedFile.path);
//         });
//         Navigator.of(context).pop(); // Close the dialog
//       }
//     } catch (e) {
//       print('Error picking image: $e');
//       // Show error message
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: Text('Error selecting image. Please try again.'),
//           backgroundColor: Colors.red,
//         ),
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: _showProfilePicturePopup,
//       child: Container(
//         width: 40,
//         height: 40,
//         decoration: BoxDecoration(
//           shape: BoxShape.circle,
//           border: Border.all(color: Colors.white.withOpacity(0.3), width: 1),
//         ),
//         child: ClipOval(
//           child: _profileImage != null
//               ? Image.file(
//                   _profileImage!,
//                   fit: BoxFit.cover,
//                   width: 40,
//                   height: 40,
//                 )
//               : Container(
//                   color: Colors.grey[300],
//                   child: Icon(Icons.person, size: 24, color: Colors.grey[600]),
//                 ),
//         ),
//       ),
//     );
//   }
// }
