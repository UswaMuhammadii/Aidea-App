import 'dart:convert';
import 'dart:typed_data';

class ZatcaUtils {
  /// Generates a ZATCA (Phase 1) compliant QR code Base64 string.
  /// 
  /// ZATCA Phase 1 (E-Invoicing) requirements:
  /// Tag 1: Seller's name
  /// Tag 2: VAT registration number of the seller
  /// Tag 3: Timestamp of the invoice (ISO 8601 format: YYYY-MM-DDTHH:mm:ssZ)
  /// Tag 4: Invoice total (with VAT)
  /// Tag 5: VAT total
  static String generateZatcaTlvBase64({
    required String sellerName,
    required String vatNumber,
    required String timestamp,
    required String totalAmount,
    required String vatAmount,
  }) {
    final bytesBuilder = BytesBuilder();

    // Helper to add a TLV record
    void addRecord(int tag, String value) {
      final valueBytes = utf8.encode(value);
      bytesBuilder.addByte(tag); // Tag (1 byte)
      bytesBuilder.addByte(valueBytes.length); // Length (1 byte)
      bytesBuilder.add(valueBytes); // Value (N bytes)
    }

    addRecord(1, sellerName);
    addRecord(2, vatNumber);
    addRecord(3, timestamp);
    addRecord(4, totalAmount);
    addRecord(5, vatAmount);

    return base64.encode(bytesBuilder.toBytes());
  }
}
