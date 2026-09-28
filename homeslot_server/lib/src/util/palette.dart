import 'dart:math';

/// Default personal colors assigned to new users (calendar colors).
const memberPalette = [
  '#E57373',
  '#F06292',
  '#BA68C8',
  '#7986CB',
  '#4FC3F7',
  '#4DB6AC',
  '#81C784',
  '#FFB74D',
  '#A1887F',
  '#90A4AE',
];

const formerMemberColor = '#9E9E9E';

String randomMemberColor([Random? random]) =>
    memberPalette[(random ?? Random()).nextInt(memberPalette.length)];
