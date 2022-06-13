
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
    case 'no-results-found':
      return "assets/icons/no-results-found.png";
    case 'map':
      return "assets/icons/map.png";
    case 'cuisine':
      return "assets/icons/cuisine.png";
    case 'edit':
      return "assets/icons/edit.png";
    case 'time':
      return "assets/icons/time.png";
    case 'calendar':
      return "assets/icons/calendar.png";
    case 'user':
      return "assets/icons/user.png";
    case 'detail':
      return "assets/icons/detail.png";
    case 'phone':
      return "assets/icons/phone.png";
    case 'place':
      return "assets/icons/place.png";
    case 'question':
      return "assets/icons/question.png";
    case 'reservation':
      return "assets/icons/reservation.png";
    case 'orders':
      return "assets/icons/reservation.png";
    default: return "";
  }
}