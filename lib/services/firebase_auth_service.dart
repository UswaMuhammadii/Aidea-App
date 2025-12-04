import 'package:firebase_auth/firebase_auth.dart';

class FirebaseAuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String? _verificationId;

  // Phone number verification send karna
  Future<void> verifyPhoneNumber({
    required String phoneNumber,
    required Function(PhoneAuthCredential) onVerificationCompleted,
    required Function(FirebaseAuthException) onVerificationFailed,
    required Function(String, int?) onCodeSent,
    required Function(String) onCodeAutoRetrievalTimeout,
  }) async {
    await _auth.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      verificationCompleted: onVerificationCompleted,
      verificationFailed: onVerificationFailed,
      codeSent: (String verificationId, int? resendToken) {
        _verificationId = verificationId;
        onCodeSent(verificationId, resendToken);
      },
      codeAutoRetrievalTimeout: onCodeAutoRetrievalTimeout,
      timeout: const Duration(seconds: 120),
    );
  }

  // OTP verification complete karna
  Future<UserCredential> signInWithCredential(PhoneAuthCredential credential) {
    return _auth.signInWithCredential(credential);
  }

  // Current user check karna
  User? getCurrentUser() {
    return _auth.currentUser;
  }

  // Sign out karna
  Future<void> signOut() async {
    await _auth.signOut();
  }

  // Get verification ID (for testing)
  String? getVerificationId() {
    return _verificationId;
  }

  // Set verification ID manually
  void setVerificationId(String verificationId) {
    _verificationId = verificationId;
  }

  // Create credential with OTP
  PhoneAuthCredential createCredential({required String smsCode}) {
    if (_verificationId == null) {
      throw Exception('Verification ID not available');
    }
    return PhoneAuthProvider.credential(
      verificationId: _verificationId!,
      smsCode: smsCode,
    );
  }
}