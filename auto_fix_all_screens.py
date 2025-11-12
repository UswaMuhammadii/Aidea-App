#!/usr/bin/env python3
"""
Complete Flutter Arabic Localization Fixer
Automatically adds localization to ALL Flutter screens
"""

import os
import re
import sys

def add_import_if_missing(content):
    """Add localization import if not already present"""
    import_statement = "import '../../gen_l10n/app_localizations.dart';"
    
    # Check if already imported
    if 'app_localizations.dart' in content or 'AppLocalizations' in content[:500]:
        return content
    
    # Find last import line
    lines = content.split('\n')
    last_import_index = -1
    
    for i, line in enumerate(lines):
        if line.strip().startswith('import ') and line.strip().endswith(';'):
            last_import_index = i
    
    if last_import_index >= 0:
        lines.insert(last_import_index + 1, import_statement)
        return '\n'.join(lines)
    
    return content

def add_l10n_variable(content):
    """Add l10n variable in build method if not present"""
    l10n_statement = "final l10n = AppLocalizations.of(context)!;"
    
    # Check if already added
    if 'final l10n = AppLocalizations.of(context)' in content:
        return content
    
    # Find build method and add l10n
    pattern = r'(@override\s+Widget build\(BuildContext context\)\s*\{)'
    
    def replacement(match):
        return match.group(1) + '\n    ' + l10n_statement + '\n'
    
    content = re.sub(pattern, replacement, content, count=1)
    return content

# Comprehensive list of all replacements
REPLACEMENTS = [
    # Common words
    ("'Cancel'", "l10n.cancel"),
    ("'Save'", "l10n.save"),
    ("'Done'", "l10n.done"),
    ("'Submit'", "l10n.submit"),
    ("'Yes'", "l10n.yes"),
    ("'No'", "l10n.no"),
    ("'Edit'", "l10n.edit"),
    ("'Delete'", "l10n.delete"),
    
    # Navigation & Main
    ("'Dashboard'", "l10n.dashboard"),
    ("'Orders'", "l10n.orders"),
    ("'My Orders'", "l10n.myOrders"),
    ("'Invoices'", "l10n.invoices"),
    ("'Reviews'", "l10n.reviews"),
    ("'My Reviews'", "l10n.myReviews"),
    ("'Profile'", "l10n.profile"),
    ("'Cart'", "l10n.cart"),
    ("'Services'", "l10n.services"),
    ("'Home'", "l10n.home"),
    
    # Dashboard specific
    ("'Our Services'", "l10n.ourServices"),
    ("'View all services'", "l10n.viewAllServices"),
    ("'Active'", "l10n.active"),
    ("'Previous'", "l10n.previous"),
    ("'No Active Orders'", "l10n.noActiveOrders"),
    ("'Book your first service today!'", "l10n.bookYourFirstServiceToday"),
    ("'No Previous Orders'", "l10n.noPreviousOrders"),
    ("'Your completed orders will appear here'", "l10n.yourCompletedOrdersWillAppearHere"),
    ("'Book Now'", "l10n.bookNow"),
    ("'Track Order'", "l10n.trackOrder"),
    ("'View Technician Details'", "l10n.viewTechnicianDetails"),
    
    # Notifications
    ("'Enable Notifications'", "l10n.enableNotifications"),
    ("'Get real-time updates about your bookings, technician assignments, and service completion.'", "l10n.getRealTimeUpdatesAboutYourBookings"),
    ("'Not Now'", "l10n.notNow"),
    ("'Allow'", "l10n.allow"),
    ("'Notifications enabled successfully!'", "l10n.notificationsEnabledSuccessfully"),
    ("'Notifications'", "l10n.notifications"),
    ("'No Notifications'", "l10n.noNotifications"),
    ("'You\\'re all caught up!'", "l10n.youreAllCaughtUp"),
    ("'Mark all read'", "l10n.markAllRead"),
    ("'Clear All Notifications'", "l10n.clearAllNotifications"),
    ("'Notification deleted'", "l10n.notificationDeleted"),
    ("'Undo'", "l10n.undo"),
    
    # Invoices
    ("'No Invoices Yet'", "l10n.noInvoicesYet"),
    ("'Complete a service to generate invoices'", "l10n.completeServiceToGenerateInvoices"),
    ("'Invoice #'", "l10n.invoiceNumber"),
    ("'PAID'", "l10n.paid"),
    ("'Download / Share Invoice'", "l10n.downloadShareInvoice"),
    
    # Reviews
    ("'To Review'", "l10n.toReview"),
    ("'No Services to Review'", "l10n.noServicesToReview"),
    ("'Complete services to leave reviews'", "l10n.completeServicesToLeaveReviews"),
    ("'Completed on'", "l10n.completedOn"),
    ("'Write a Review'", "l10n.writeAReview"),
    ("'No Reviews Yet'", "l10n.noReviewsYet"),
    ("'Your reviews will appear here'", "l10n.yourReviewsWillAppearHere"),
    ("'Rate Your Experience'", "l10n.rateYourExperience"),
    ("'Tap to rate'", "l10n.tapToRate"),
    ("'Excellent!'", "l10n.excellent"),
    ("'Very Good!'", "l10n.veryGood"),
    ("'Good'", "l10n.good"),
    ("'Fair'", "l10n.fair"),
    ("'Poor'", "l10n.poor"),
    ("'Share your experience (optional)...'", "l10n.shareYourExperience"),
    ("'Thank you for your review!'", "l10n.thankYouForYourReview"),
    
    # Profile / Settings
    ("'Edit Profile'", "l10n.editProfile"),
    ("'Settings'", "l10n.settings"),
    ("'Manage notification preferences'", "l10n.manageNotificationPreferences"),
    ("'Saved Addresses'", "l10n.savedAddresses"),
    ("'Payment Methods'", "l10n.paymentMethods"),
    ("'Manage payment options'", "l10n.managePaymentOptions"),
    ("'Help & Support'", "l10n.helpAndSupport"),
    ("'Get help and contact us'", "l10n.getHelpAndContactUs"),
    ("'About'", "l10n.about"),
    ("'App version and information'", "l10n.appVersionAndInformation"),
    ("'Logout'", "l10n.logout"),
    ("'Are you sure you want to logout?'", "l10n.areYouSureYouWantToLogout"),
    ("'Full Name'", "l10n.fullName"),
    ("'Email Address'", "l10n.emailAddress"),
    ("'Phone Number'", "l10n.phoneNumber"),
    ("'Address'", "l10n.address"),
    ("'Save Changes'", "l10n.saveChanges"),
    ("'Profile updated successfully!'", "l10n.profileUpdatedSuccessfully"),
    
    # Cart
    ("'Your cart is empty'", "l10n.yourCartIsEmpty"),
    ("'Add some services to get started'", "l10n.addSomeServicesToGetStarted"),
    ("'Clear All'", "l10n.clearAll"),
    ("'Are you sure you want to remove all items?'", "l10n.areYouSureYouWantToRemoveAllItems"),
    ("'Clear'", "l10n.clear"),
    ("'Total'", "l10n.total"),
    ("'Proceed to Checkout'", "l10n.proceedToCheckout"),
    
    # Services
    ("'Search services...'", "l10n.searchServices"),
    ("'No services found'", "l10n.noServicesFound"),
    ("'Try adjusting your search terms'", "l10n.tryAdjustingYourSearchTerms"),
    ("'Add to Cart'", "l10n.addToCart"),
    ("'View Cart'", "l10n.viewCart"),
    ("'Service Detail'", "l10n.serviceDetail"),
    ("'What\\'s Included'", "l10n.whatsIncluded"),
    ("'Not Included'", "l10n.notIncluded"),
    
    # Orders
    ("'Order Details'", "l10n.orderDetails"),
    ("'Order #'", "l10n.orderNumber"),
    ("'Services List'", "l10n.servicesList"),
    ("'Booking Date'", "l10n.bookingDate"),
    ("'Service Time'", "l10n.serviceTime"),
    ("'Order Status'", "l10n.orderStatus"),
    ("'Pending'", "l10n.pending"),
    ("'Confirmed'", "l10n.confirmed"),
    ("'In Progress'", "l10n.inProgress"),
    ("'Completed'", "l10n.completed"),
    ("'Cancelled'", "l10n.cancelled"),
    ("'Technician'", "l10n.technician"),
    ("'Orders Done'", "l10n.ordersDone"),
    ("'Experience'", "l10n.experience"),
    ("'View Profile'", "l10n.viewProfile"),
    ("'Chat'", "l10n.chat"),
    ("'Cancel Booking'", "l10n.cancelBooking"),
    
    # Chat
    ("'Type a message...'", "l10n.typeAMessage"),
    ("'No messages yet'", "l10n.noMessagesYet"),
    ("'Just now'", "l10n.justNow"),
    ("'Calling technician...'", "l10n.callingTechnician"),
    
    # Addresses
    ("'Home Address'", "l10n.homeAddress"),
    ("'Editing'", "l10n.editing"),
    ("'Enter your address'", "l10n.enterYourAddress"),
    ("'Address updated successfully!'", "l10n.addressUpdatedSuccessfully"),
    ("'Add New Address'", "l10n.addNewAddress"),
    
    # Vendor Profile
    ("'Vendor Profile'", "l10n.vendorProfile"),
    ("'Order Done'", "l10n.orderDone"),
    ("'Time Period'", "l10n.timePeriod"),
    ("'Profile Verified'", "l10n.profileVerified"),
    ("'Police Verified'", "l10n.policeVerified"),
    ("'Services Provide'", "l10n.servicesProvide"),
    
    # Form validation
    ("'Please enter your name'", "l10n.pleaseEnterYourName"),
    ("'Please enter your email'", "l10n.pleaseEnterYourEmail"),
    ("'Please enter a valid email'", "l10n.pleaseEnterValidEmail"),
    ("'Please enter your phone number'", "l10n.pleaseEnterYourPhoneNumber"),
    ("'Phone number must contain only digits'", "l10n.phoneNumberMustContainOnlyDigits"),
]

def apply_replacements(content):
    """Apply all text replacements"""
    for old, new in REPLACEMENTS:
        content = content.replace(old, new)
    return content

def fix_deprecated_code(content):
    """Fix deprecated withOpacity calls"""
    content = re.sub(r'\.withOpacity\(', '.withValues(alpha: ', content)
    return content

def process_file(filepath):
    """Process a single Dart file"""
    try:
        with open(filepath, 'r', encoding='utf-8') as f:
            content = f.read()
        
        original_content = content
        
        # Apply all fixes
        content = add_import_if_missing(content)
        content = add_l10n_variable(content)
        content = apply_replacements(content)
        content = fix_deprecated_code(content)
        
        # Only write if content changed
        if content != original_content:
            with open(filepath, 'w', encoding='utf-8') as f:
                f.write(content)
            return True
        return False
        
    except Exception as e:
        print(f"❌ Error processing {filepath}: {e}")
        return False

def main():
    """Main function"""
    print("╔══════════════════════════════════════════════════════════════╗")
    print("║       🌍 Flutter Arabic Localization Auto-Fixer             ║")
    print("╚══════════════════════════════════════════════════════════════╝")
    print()
    
    # Get project path
    if len(sys.argv) > 1:
        project_path = sys.argv[1]
    else:
        project_path = input("Enter your Flutter project directory path: ").strip()
    
    if not os.path.exists(project_path):
        print("❌ Directory not found!")
        return
    
    screens_dir = os.path.join(project_path, 'lib', 'screens')
    
    if not os.path.exists(screens_dir):
        print("❌ lib/screens directory not found!")
        return
    
    print(f"\n📂 Scanning: {screens_dir}\n")
    print("─" * 60)
    
    fixed_count = 0
    total_count = 0
    
    # Process all .dart files in screens directory
    for root, dirs, files in os.walk(screens_dir):
        for file in files:
            if file.endswith('.dart'):
                total_count += 1
                filepath = os.path.join(root, file)
                rel_path = os.path.relpath(filepath, project_path)
                
                print(f"Processing: {rel_path}...", end=" ")
                
                if process_file(filepath):
                    print("✅ FIXED")
                    fixed_count += 1
                else:
                    print("⏭️  Skipped (no changes needed)")
    
    print("─" * 60)
    print(f"\n🎉 Completed!")
    print(f"📊 Processed: {total_count} files")
    print(f"✅ Fixed: {fixed_count} files")
    print(f"⏭️  Skipped: {total_count - fixed_count} files")
    print()
    print("🚀 Next steps:")
    print("   1. cd", project_path)
    print("   2. flutter gen-l10n")
    print("   3. flutter run")
    print("   4. Select 'العربية' to test Arabic!")
    print()
    print("✨ All screens should now work in Arabic!")
    print()

if __name__ == '__main__':
    main()
