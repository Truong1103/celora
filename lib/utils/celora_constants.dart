import '../models/celora_models.dart';

const int dailyPackPrice = 59000;
const int cycleLengthDays = 28;

const flowTypes = [
  FlowType(key: 'red', name: 'Heavy', sub: 'Red', dotColorValue: 0xFFD6336C),
  FlowType(
    key: 'yellow',
    name: 'Medium',
    sub: 'Yellow',
    dotColorValue: 0xFFF2B705,
  ),
  FlowType(
    key: 'green',
    name: 'Light',
    sub: 'Green',
    dotColorValue: 0xFF5BAE7A,
  ),
];

const subscriptionPlans = {
  'monthly': SubscriptionPlan(
    id: 'monthly',
    label: 'Monthly',
    price: 165000,
    per: '/mo',
    billed: 'Billed monthly',
  ),
  'quarterly': SubscriptionPlan(
    id: 'quarterly',
    label: 'Quarterly',
    price: 150000,
    per: '/mo',
    billed: 'Billed every 3 months',
    save: 'Save 9%',
  ),
  'yearly': SubscriptionPlan(
    id: 'yearly',
    label: 'Yearly',
    price: 135000,
    per: '/mo',
    billed: 'Billed annually',
    save: 'Save 18%',
  ),
};

const dailyPadPackPlan = SubscriptionPlan(
  id: 'daily_pack',
  label: 'Daily Pad Pack',
  price: dailyPackPrice,
  per: '',
  billed: '12 pads · equal mix · no subscription',
);

const appTabs = [
  ('home', 'Cycle', '🏠'),
  ('tracker', 'Tracker', '📅'),
  ('shop', 'Subscribe', '🛍️'),
  ('impact', 'Impact', '🌱'),
  ('profile', 'You', '👤'),
];

int mixCountForKey(PadMix mix, String key) {
  switch (key) {
    case 'red':
      return mix.red;
    case 'yellow':
      return mix.yellow;
    case 'green':
      return mix.green;
    default:
      return 0;
  }
}
