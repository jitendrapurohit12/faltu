class Constants {
  //Screen Names
  static const APP_NAME = 'Faltu';
  static const MEN = 'Men';
  static const WOMEN = 'Women';
  static const MY_ACCOUNT = 'Account';
  static const MY_ORDERS = 'Orders';
  static const MY_WALLET = 'My Wallet';
  static const MY_WISHLIST = 'My Wishlist';
  static const OUR_STORY = 'Our Story';
  static const BLOG = 'Blog';
  static const EDIT_PROFILE = 'Edit Profile';
  static const MY_ADDRESS = 'My Address';
  static const CONTACT_US = 'Contact Us';
  static const RATE_THE_APP = 'Rate The App';
  static const CHOOSE_ADDRESS = 'Choose Address';
  static const ORDER_SUMMARY = 'Order Summary';
  static const PAYMENTS = 'Payment Methods';

  // User Credentials
  static const EMAIL = 'EMAIL';
  static const NAME = 'NAME';
  static const URL = 'URL';
  static const PHONE = 'PHONE';
  static const GENDER = 'GENDER';
  static const ID = 'ID';

  //json Wearable constants
  static const WEARABLE_ID = 'id';
  static const WEARABLE_NAME = 'name';
  static const WEARABLE_PRICE = 'price';
  static const WEARABLE_DISCOUNT = 'discount';
  static const WEARABLE_IMAGES = 'images';
  static const WEARABLE_TYPE = 'type';
  static const WEARABLE_SIZE = 'size';
  static const WEARABLE_GENDER = 'gender';
  static const WEARABLE_COLORS = 'colors';
  static const WEARABLE_FABRIC = 'fabric';
  static const WEARABLE_STATUS = 'status';
  static const WEARABLE_CASHBACK = 'cashback';
  static const WEARABLE_COLOR = 'color';
  static const WEARABLE_WEARABLES = 'wearables';
  static const WEARABLE_COLOR_NAME = 'color_name';

  //json Address constants
  static const ADDRESS_NAME = 'name';
  static const ADDRESS_PHONE = 'phone';
  static const ADDRESS_ALT_PHONE = 'alt_phone';
  static const ADDRESS_PIN = 'pincode';
  static const ADDRESS_ADDRESS = 'address';
  static const ADDRESS_LOCALITY = 'locality';
  static const ADDRESS_LANDMARK = 'landmark';
  static const ADDRESS_CITY = 'city';
  static const ADDRESS_STATE = 'state';
  static const ADDRESS_TYPE = 'type';
  static const ADDRESS_ADDRESSES = 'address';

  //json orders constants
  static const ORDER_DATE = 'date';
  static const ORDER_ID = 'id';
  static const ORDER_PRODUCT_ID = 'product_id';
  static const ORDER_PRICE = 'price';
  static const ORDER_SIZE = 'size';
  static const ORDER_ADDRESS = 'address';
  static const ORDER_IMAGE = 'image';
  static const ORDER_NAME = 'name';
  static const ORDER_STATUS = 'status';
  static const ORDER_ORDERS = 'orders';
  static const ORDER_AMOUNT = 'amount';
  static const ORDER_ADDITIONAL_DISCOUNT = 'additional_doscount';

  //profile constants
  static const PROFILE_NAME = 'name';
  static const PROFILE_GENDER = 'gender';
  static const PROFILE_IMAGE = 'image';
  static const PROFILE_PHONE = 'phone';

  //order status codes
  static const ORDER_CONFIRMED = '1';
  static const ORDER_PACKED = '2';
  static const ORDER_SHIPPED = '3';
  static const ORDER_DELIVERED = '4';

  //address hints
  static const HINT_NAME = 'Receiver\'s Name';
  static const HINT_PHONE = 'Phone Number';
  static const HINT_ALT_PHONE = 'Alternate Phone Number (Optional)';
  static const HINT_PIN = 'Pincode';
  static const HINT_ADDRESS = 'Address';
  static const HINT_LOCALITY = 'Locality';
  static const HINT_LANDMARK = 'Landmark (Optional)';
  static const HINT_CITY = 'City';
  static const HINT_STATE = 'State';

  //Button Texts
  static const BUTTON_ADD_TO_CART = 'ADD TO CART';
  static const BUTTON_ADD_TO_WISHLIST = 'ADD TO WISHLIST';

  //gender
  static const MALE = 'Male';
  static const FEMALE = 'Female';
  static const MALE_CODE = '1';
  static const FEMALE_CODE = '2';

  //address type
  static const HOME = 'Home';
  static const WORK = 'Work';

  //dialog messages
  static const ADDRESS_DELETE_DIALOG =
      'Would you really like to delete this address?';
  static const WISHLIST_DELETE_DIALOG =
      'Would you really like to remove this product from Wishlist?';
  static const CARTLIST_DELETE_DIALOG =
      'Would you really like to remove this product from Cart?';
  static const DELETE = 'Delete';
  static const REMOVE = 'Remove';
  static const ADD_TO_CART = 'Add To Cart';

  //error messages
  static const ERROR_INVALID_NAME = 'Name can\'t be empty';
  static const ERROR_INVALID_ADDRESS = 'Address can\'t be empty';
  static const ERROR_INVALID_LOCALITY = 'Locality can\'t be empty';
  static const ERROR_INVALID_CITY = 'City can\'t be empty';
  static const ERROR_INVALID_STATE = 'State can\'t be empty';
  static const ERROR_INVALID_MOBILE = 'Mobile no. length should be 10';
  static const ERROR_INVALID_PIN_CODE = 'Pin Code length should be 6';
  static const ERROR_UPDATE_PROFILE =
      'There\'s some issue with updating profile. please try again later!';

  static const ERROR_UPDATE_ADDRESS =
      'There\'s some issue with saving address. please try again later!';

  //cloth types
  static const TSHIRT = 1;

  //Refs
  static const DEV = 'dev';
  static const PRODUCTION = 'production';
  static const PRODUCT_ID = 'product_id';
  static const DETAIL_ID = 'detail_id';
  static const PRODUCTS = 'products';
  static const USERS = 'users';
  static const USER_DATA = 'user_data';
  static const WISHLIST = 'wishlist';
  static const CART = 'cart';
  static const PRODUCT_DETAILS = 'product_details';

  //random
  static const ORDER_SUMMARY_TEXT = 'Order Summary';
  static const TOTAL_AMOUNT = 'Total Amount';
  static const SHIPPING_CHARGES = 'Shipping Charges';
  static const PAYABLE_AMOUNT = 'Payable Amount';
  static const CONTINUE = 'Continue';

  //special chars
  static const RUPEE = '₹';
  static const FALTU_SEPRATOR = '_FALTU_SEPRATOR_';

  //SqFlite constants
  static const TEXT = 'TEXT';
  static const INTEGER = 'INTEGER';
}
