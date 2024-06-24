import 'package:realtbox/data/model/enquiry/enquiry_request.dart';
import 'package:realtbox/domain/entity/amenity.dart';
import 'package:realtbox/domain/entity/category-type/category.dart';
import 'package:realtbox/domain/entity/enquiry_list/enquiry_data_model.dart';
import 'package:realtbox/domain/entity/property/property.dart';
import 'package:realtbox/core/resources/data_state.dart';
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
  );
  Future<DataState> enquiry(EnquiryRequestObject enquiryRequest);
  Future<DataState<List<EnquiryDataModel>>> enquiryList(String propertyId);
  Future<DataState<List<Category>>> categoryList();
  Future<DataState<List<Amenity>>> amenityList();
}
