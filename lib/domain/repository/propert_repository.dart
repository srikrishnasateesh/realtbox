import 'package:realtbox/domain/entity/amenity.dart';
import 'package:realtbox/domain/entity/birdview.dart';
import 'package:realtbox/domain/entity/category-type/category.dart';
import 'package:realtbox/domain/entity/enquiry_list/enquiry_data_model.dart';
import 'package:realtbox/domain/entity/favourite.dart';
import 'package:realtbox/domain/entity/property/property.dart';
import 'package:realtbox/core/resources/data_state.dart';
import 'package:realtbox/domain/entity/user_enquiry.dart';
import 'package:realtbox/domain/usecase/submit_enquiry.dart';

abstract class PropertyRepository {
  Future<DataState<List<Property>>> getPropertiesList(
    int skip,
    String? category,
    String? amenitiesIn,
    String? price_min,
    String? price_max,
    String? sort,
    String? sortDir,
    double? latitude,
    double? longitude,
  );
  Future<DataState<List<Property>>> getSavedPropertiesList(
    int skip,
    String? category,
    String? amenitiesIn,
    String? price_min,
    String? price_max,
    String? sort,
    String? sortDir,
    double? latitude,
    double? longitude,
   final bool onlyFavourites,
  );
   Future<DataState<List<Property>>> getLastViewedPropertiesList(
    int skip,
    String? category,
    String? amenitiesIn,
    String? price_min,
    String? price_max,
    String? sort,
    String? sortDir,
    double? latitude,
    double? longitude,
  );
   Future<DataState<Property>> getPropertiesDetails(
    String id,
  );
  Future<DataState> enquiry(EnquiryRequestObject enquiryRequest);
  Future<DataState<List<EnquiryDataModel>>> enquiryList(String propertyId);
  Future<DataState<List<UserEnquiry>>> userEnquiryList();
  Future<DataState<List<Category>>> categoryList();
  Future<DataState<List<Amenity>>> amenityList();
  Future<DataState<List<BirdView>>> birdView();
  Future<DataState<Favourite>> toggleFavorite(String id);
}

