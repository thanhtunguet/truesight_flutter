part of 'models.dart';

void configureBuiltInModels() {
  DataModel.setType(EnumModel, EnumModel.new);
  DataModel.setType(File, File.new);
  DataModel.setType(Tenant, Tenant.new);
  DataModel.setType(TruesightAppUser, TruesightAppUser.new);
}
