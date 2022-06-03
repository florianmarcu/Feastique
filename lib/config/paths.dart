
/// Returns the full asset path for a specific file
String asset(String fileName){
  switch(fileName){
    case 'social-friendly':
      return "assets/icons/social-friendly.png";
    case 'calm':
      return "assets/icons/intimate.png";
    case 'filter':
      return "assets/icons/filter.png";
    case 'list':
      return "assets/icons/list.png";
    default: return "";
  }
}