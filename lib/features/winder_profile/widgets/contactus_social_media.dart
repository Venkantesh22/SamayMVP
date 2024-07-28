// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:samay_mvp/constants/constants.dart';

import 'package:samay_mvp/constants/custom_icon_button.dart';
import 'package:samay_mvp/models/salon_form_models/salon_infor_model.dart';
import 'package:samay_mvp/utility/dimension.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactUsAndSocialMedia extends StatefulWidget {
  SalonModel salonModel;

  ContactUsAndSocialMedia({
    Key? key,
    required this.salonModel,
  }) : super(key: key);

  @override
  State<ContactUsAndSocialMedia> createState() =>
      _ContactUsAndSocialMediaState();
}

class _ContactUsAndSocialMediaState extends State<ContactUsAndSocialMedia> {
  String instagram = "";

  // Method to launch the dialer with the phone number
  void _launchDialer(String phoneNumber) async {
    try {
      Uri dialNumber = Uri(scheme: "tel", path: phoneNumber);
      await launchUrl(dialNumber);
    } catch (e) {
      showMessage('Could not launch Mobile $e');
    }
  }

  // Method to open WhatsApp with the phone number
  Future<void> _openWhatsApp(String phoneNumber) async {
    try {
      final Uri whatsappUrl = Uri.parse('https://wa.me/$phoneNumber');
      await launchUrl(whatsappUrl);
    } catch (e) {
      showMessage('Could not launch WhatsApp $e');
    }
  }

  // Method to open Instagram
  Future<void> _openInstagram(String url) async {
    try {
      await launchUrl(Uri.parse(url));
    } catch (e) {
      showMessage('Instagram is not available');
    }
  }

  // Method to open Facebook
  Future<void> _openFacebook(String url) async {
    try {
      await launchUrl(Uri.parse(url));
    } catch (e) {
      showMessage('Facebook is not available');
    }
  }

  // Method to open LinkedIn
  Future<void> _openLinkedIn(String url) async {
    try {
      await launchUrl(Uri.parse(url));
    } catch (e) {
      showMessage('LinkedIn is not available');
    }
  }

  // Method to open GoogleMap
  Future<void> _openGoogleMap(String url) async {
    try {
      await launchUrl(Uri.parse(url));
    } catch (e) {
      showMessage('GoogleMap is not available');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(Dimensions.dimenisonNo10),
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 209, 206, 206),
        borderRadius: BorderRadius.circular(Dimensions.dimenisonNo10),
      ),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(Dimensions.dimenisonNo10,
                Dimensions.dimenisonNo10, Dimensions.dimenisonNo10, 0),
            child: Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Contact Us',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: Dimensions.dimenisonNo14,
                        fontFamily: GoogleFonts.roboto().fontFamily,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1,
                      ),
                    ),
                    Text(
                      widget.salonModel.number.toString(),
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: Dimensions.dimenisonNo16,
                        fontFamily: GoogleFonts.roboto().fontFamily,
                        letterSpacing: 1,
                      ),
                    ),
                  ],
                ),
                Spacer(),
                IconButton(
                  icon: Icon(
                    Icons.call,
                    color: Colors.black,
                    size: Dimensions.dimenisonNo36,
                  ),
                  onPressed: () {
                    _launchDialer(widget.salonModel.number.toString());
                  },
                ),
                SizedBox(
                  width: Dimensions.dimenisonNo10,
                ),
                CustomIconButton(
                  icon: FontAwesomeIcons.whatsapp,
                  ontap: () {
                    _openWhatsApp(widget.salonModel.whatApp.toString());
                  },
                ),
              ],
            ),
          ),

          Padding(
            padding: EdgeInsets.only(bottom: Dimensions.dimenisonNo10),
            child: const Divider(
              color: Colors.black,
            ),
          ),

          // Social Media Icons
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              if (widget.salonModel.instagram!.isNotEmpty)
                CustomIconButton(
                  icon: FontAwesomeIcons.instagram,
                  ontap: () {
                    _openInstagram(widget.salonModel.instagram.toString());
                  },
                ),
              if (widget.salonModel.facebook!.isNotEmpty)
                CustomIconButton(
                  icon: FontAwesomeIcons.facebook,
                  ontap: () {
                    _openFacebook(widget.salonModel.facebook.toString());
                  },
                ),
              if (widget.salonModel.linked!.isNotEmpty)
                CustomIconButton(
                  icon: FontAwesomeIcons.linkedin,
                  ontap: () {
                    _openInstagram(widget.salonModel.linked.toString());
                  },
                ),
              if (widget.salonModel.googleMap!.isNotEmpty)
                CustomIconButton(
                  icon: FontAwesomeIcons.mapLocationDot,
                  ontap: () {
                    _openGoogleMap(widget.salonModel.googleMap.toString());
                  },
                ),
            ],
          ),
        ],
      ),
    );
  }
}
