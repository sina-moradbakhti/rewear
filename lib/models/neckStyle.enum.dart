enum NeckStyle { style0, style1, style2, style3 }

String neckStyleToString(NeckStyle neckStyle) => neckStyle.toString();

NeckStyle stringToNeckStyle(String neckStyleStr) {
  switch (neckStyleStr) {
    case 'NeckStyle.style0':
      return NeckStyle.style0;
    case 'NeckStyle.style1':
      return NeckStyle.style1;
    case 'NeckStyle.style2':
      return NeckStyle.style2;
    case 'NeckStyle.style3':
      return NeckStyle.style3;
    default:
      return NeckStyle.style0;
  }
}
