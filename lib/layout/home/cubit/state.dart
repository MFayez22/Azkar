abstract class AzkarState {}

class AzkarInitialState extends AzkarState {}

class AzkarLoadingGetWeatherState extends AzkarState {}

class AzkarGetWeatherState extends AzkarState {}

class AzkarGetLocationSuccessState extends AzkarState {}

class AzkarGetLocationPermissionSuccessState extends AzkarState {}

class AzkarChangeNameTW extends AzkarState {}

class AzkarChangeNumTW extends AzkarState {}

class AzkarChangeDateTime extends AzkarState {}

class AzkarGetAyatLoadingState extends AzkarState {}

class AzkarGetAyatSuccessState extends AzkarState {}

class AzkarGetAyatErrorState extends AzkarState {}

class AzkarChangeTitleSuccessState extends AzkarState {}

class AzkarGetAzkarMusicSuccessState extends AzkarState {}

class AzkarGetAzkarMusicErrorState extends AzkarState {}


class LocationServiceDisEnabledState extends AzkarState {}
class LocationServiceEnabledState extends AzkarState {}

class IsFirstTimeState extends AzkarState {}
class IsNOtFirstTimeState extends AzkarState {}
