// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
//
// class ReportTypeDropdown extends StatefulWidget {
//   const ReportTypeDropdown({super.key});
//
//   @override
//   State<ReportTypeDropdown> createState() => _ReportTypeDropdownState();
// }
//
// class _ReportTypeDropdownState extends State<ReportTypeDropdown> {
//   final LayerLink _layerLink = LayerLink();
//   OverlayEntry? _overlayEntry;
//   bool _isOpen = false;
//
//   void _toggleDropdown() {
//     _isOpen ? _closeDropdown() : _openDropdown();
//   }
//
//   void _openDropdown() {
//     _overlayEntry = _createOverlayEntry();
//     Overlay.of(context).insert(_overlayEntry!);
//     setState(() => _isOpen = true);
//   }
//
//   void _closeDropdown() {
//     _overlayEntry?.remove();
//     _overlayEntry = null;
//     setState(() => _isOpen = false);
//   }
//
//   OverlayEntry _createOverlayEntry() {
//     RenderBox renderBox = context.findRenderObject() as RenderBox;
//     var size = renderBox.size;
//
//     return OverlayEntry(
//       builder: (context) => Stack(
//         children: [
//           // This allows closing the dropdown by clicking anywhere else
//           GestureDetector(
//             onTap: _closeDropdown,
//             behavior: HitTestBehavior.translucent,
//             child: Container(color: Colors.transparent),
//           ),
//           Positioned(
//             width: size.width,
//             child: CompositedTransformFollower(
//               link: _layerLink,
//               showWhenUnlinked: false,
//               offset: Offset(0, size.height + 5),
//               child: Material(
//                 elevation: 8,
//                 borderRadius: BorderRadius.circular(12),
//                 child: Container(
//                   constraints: const BoxConstraints(maxHeight: 400),
//                   decoration: BoxDecoration(
//                     color: Colors.white,
//                     borderRadius: BorderRadius.circular(12),
//                     border: Border.all(color: Colors.grey.shade300),
//                   ),
//                   child: BlocBuilder<ReportBloc, ReportState>(
//                     builder: (context, state) {
//                       return ListView.builder(
//                         shrinkWrap: true,
//                         padding: EdgeInsets.zero,
//                         itemCount: state.reportTypes.length,
//                         itemBuilder: (context, index) {
//                           final category = state.reportTypes[index];
//                           if (category.subCategories.isEmpty) return const SizedBox.shrink();
//
//                           return Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               // Group Title Header
//                               Container(
//                                 width: double.infinity,
//                                 padding: const EdgeInsets.fromLTRB(16, 12, 16, 4),
//                                 color: Colors.grey[100],
//                                 child: Text(
//                                   category.reportType.toUpperCase(),
//                                   style: GoogleFonts.inter(
//                                     fontSize: 11,
//                                     fontWeight: FontWeight.w800,
//                                     color: const Color(0xFF27AE60),
//                                   ),
//                                 ),
//                               ),
//                               // Sub-Category Items
//                               ...category.subCategories.map((subItem) {
//                                 final isSelected = state.selectedSubItem?.subReportTypeId == subItem.subReportTypeId;
//                                 return ListTile(
//                                   dense: true,
//                                   title: Text(
//                                     subItem.subReportType ?? '',
//                                     style: GoogleFonts.inter(
//                                       fontSize: 14,
//                                       fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
//                                       color: isSelected ? const Color(0xFF27AE60) : Colors.black87,
//                                     ),
//                                   ),
//                                   trailing: isSelected ? const Icon(Icons.check, size: 16, color: Color(0xFF27AE60)) : null,
//                                   onTap: () {
//                                     context.read<ReportBloc>().add(SelectSubCategoryEvent(subItem));
//                                     _closeDropdown();
//                                   },
//                                 );
//                               }).toList(),
//                               const Divider(height: 1),
//                             ],
//                           );
//                         },
//                       );
//                     },
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return CompositedTransformTarget(
//       link: _layerLink,
//       child: BlocBuilder<ReportBloc, ReportState>(
//         builder: (context, state) {
//           return InkWell(
//             onTap: _toggleDropdown,
//             child: Container(
//               padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
//               decoration: BoxDecoration(
//                 color: const Color(0xFFE9FBF4),
//                 borderRadius: BorderRadius.circular(12),
//                 border: Border.all(color: const Color(0xFF27AE60).withOpacity(0.3)),
//               ),
//               child: Row(
//                 children: [
//                   Expanded(
//                     child: Text(
//                       state.selectedSubItem?.subReportType ?? "Select Report Category",
//                       style: GoogleFonts.inter(
//                         fontSize: 14,
//                         fontWeight: FontWeight.w500,
//                         color: state.selectedSubItem != null ? Colors.black : Colors.grey[600],
//                       ),
//                       overflow: TextOverflow.ellipsis,
//                     ),
//                   ),
//                   Icon(
//                     _isOpen ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
//                     color: const Color(0xFF27AE60)
//                   ),
//                 ],
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }
// }
