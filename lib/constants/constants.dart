import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:samay_mvp/utility/dimension.dart';
import 'package:samay_mvp/widget/custom_button.dart';

void showMessage(String message) {
  Fluttertoast.showToast(
    msg: message,
    backgroundColor: Colors.grey,
    textColor: Colors.black,
    fontSize: Dimensions.dimenisonNo16,
  );
}

// Function to show a message when a holiday is selected
void showMeassgeAlertDialog(
  BuildContext context,
  String title,
  message,
) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text(title),
        // content:  Text('The salon is closed on the selected date.'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('OK'),
          ),
        ],
      );
    },
  );
}

// Function to show a message Delete
void showDeleteAlertDialog(
    BuildContext context, String title, message, VoidCallback ontap) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text(title),
        // content:  Text('The salon is closed on the selected date.'),
        content: Text(message),
        actions: [
          SizedBox(
            height: Dimensions.dimenisonNo20,
          ),
          SizedBox(
            height: Dimensions.dimenisonNo40,
            child: Row(
              children: [
                CustomButtom(
                  text: "No",
                  ontap: () {
                    Navigator.pop(context);
                  },
                ),
                Spacer(),
                CustomButtom(text: "Yes", ontap: ontap)
              ],
            ),
          )
          // TextButton(
          //   onPressed: () {
          //     Navigator.pop(context);
          //   },
          //   child: const Text('No'),
          // ),

          // SizedBox(
          //   width: Dimensions.dimenisonNo150,
          // ),
          // TextButton(
          //   onPressed: ontap,
          //   child: const Text('Yes'),
          // ),
        ],
      );
    },
  );
}

showLoaderDialog(BuildContext context) {
  AlertDialog alert = AlertDialog(
    content: Builder(builder: (context) {
      return SizedBox(
        width: Dimensions.dimenisonNo100,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const CircularProgressIndicator(
              color: Color(0xffe16555),
            ),
            SizedBox(
              height: Dimensions.dimenisonNo18,
            ),
            Container(
                margin: const EdgeInsets.only(left: 7),
                child: const Text("Loading...")),
          ],
        ),
      );
    }),
  );
  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}

String getMessageFromErrorCode(String errorCode) {
  switch (errorCode) {
    case "ERROR_EMAIL_ALREADY_IN_USE":
      return "Email already used. Go to login page.";
    case "account-exists-with-different-credential":
      return "Email already used. Go to login page.";
    case "email-already-in-use":
      return "Email already used. Go to login page.";
    case "ERROR_WRONG_PASSWORD":
    case "wrong-password":
      return "Wrong Password ";
    case "ERROR_USER_NOT_FOUND":
      return "No user found with this email.";
    case "user-not-found":
      return "No user found with this email.";
    case "ERROR_USER_DISABLED":
      return "User disabled.";
    case "user-disabled":
      return "User disabled.";
    case "ERROR_TOO_MANY_REQUESTS":
      return "Too many requests to log into this account.";
    case "operation-not-allowed":
      return "Too many requests to log into this account.";
    case "ERROR_OPERATION_NOT_ALLOWED":
      return "Too many requests to log into this account.";
    case "ERROR_INVALID_EMAIL":
      return "Email address is invalid.";
    // case "invalid-email":
    //   return "Email address is invalid.";
    default:
      return "Login failed. Please try again.";
  }
}

bool loginVaildation(String email, String password) {
  if (email.isEmpty && password.isEmpty) {
    showMessage("Both Fields are empty");
    return false;
  } else if (email.isEmpty) {
    showMessage("Email is Empty");
    return false;
  } else if (password.isEmpty) {
    showMessage("Password is Empty");
    return false;
  } else {
    return true;
  }
}

bool signUpVaildation(
  String email,
  String password,
  String name,
  String phone,
) {
  if (email.isEmpty && password.isEmpty && name.isEmpty && phone.isEmpty) {
    showMessage("All Fields are empty");
    return false;
  } else if (name.isEmpty) {
    showMessage("Name is Empty");
    return false;
  } else if (email.isEmpty) {
    showMessage("Email is Empty");
    return false;
  } else if (phone.isEmpty) {
    showMessage("Phone is Empty");
    return false;
  } else if (phone.length != 10) {
    showMessage("Phone is Empty");
    return false;
  } else if (password.isEmpty) {
    showMessage("Password is Empty");
    return false;
  } else {
    return true;
  }
}

bool updateProfileVaildation(
  String name,
  String phone,
) {
  if (name.isEmpty && phone.isEmpty) {
    showMessage("All Fields are empty");
    return false;
  } else if (name.isEmpty) {
    showMessage("Name is Empty");
    return false;
  } else if (phone.isEmpty) {
    showMessage("Phone is Empty");
    return false;
  } else if (phone.length != 10) {
    showMessage("Phone is Empty");
    return false;
  } else {
    return true;
  }
}

bool emailVaildation(
  String email,
) {
  if (email.isEmpty) {
    showMessage("Email is Empty");
    return false;
  } else {
    return true;
  }
}
