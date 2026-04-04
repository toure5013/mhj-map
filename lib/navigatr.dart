library navigatr;

export 'src/models/lat_lng.dart';
export 'src/models/route_result.dart';
export 'src/models/geocode_result.dart';
export 'src/models/autocomplete_result.dart';
export 'src/models/maneuver.dart';
export 'src/models/navigatr_config.dart';
export 'src/services/navigatr_service.dart';
export 'src/widgets/navigatr_map.dart';
export 'src/utils/format_utils.dart';
export 'src/utils/polyline_decoder.dart';
export 'src/models/map_style.dart';
export 'src/models/map_style_presets.dart';

import 'src/services/navigatr_service.dart';
import 'src/models/navigatr_config.dart';

class Navigatr extends NavigatrService {
  Navigatr({super.config = const NavigatrConfig()});
}
