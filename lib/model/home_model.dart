class Category{
  final String categoryName;
  final  String categoryImage;
  final  String catdisplayOrder;
  final String catStatus;
  final String categoryId;
  final String cateiconImage;
  final int Totalcount;

  Category({
    required this.categoryName,
    required this.categoryImage,
    required this.catdisplayOrder,
    required this.catStatus,
    required this.categoryId,
    required this.cateiconImage,
    required this.Totalcount,

  });

}

class PostJob {
  final String postedBy;
  final String jobType;
  final String jobTitle;
  final String jobDescription;
  final String jobAddress;
  final String jobImage;
  final String jobContact;
  final String location;
  final String jobFromtime;
  final String jobTotime;
  final String jobFromdate;
  final String jobTodate;
  final String jobcateId;
  final String jobBata;
  final String jobCost;
  final String jobworkingHours;
  final String jobworkingDays;

  PostJob({
    required this.postedBy,
    required this.jobType,
    required this.jobTitle,
    required this.jobDescription,
    required this.jobAddress,
    required this.jobImage,
    required this.jobContact,
    required this.location,
    required this.jobFromtime,
    required this.jobTotime,
    required this.jobFromdate,
    required this.jobTodate,
    required this.jobcateId,
    required this.jobBata,
    required this.jobCost,
    required this.jobworkingHours,
    required this.jobworkingDays,
  });

  Map<String, dynamic> toMap() {
    return {
      'postedBy':postedBy,
      'jobType':jobType,
      'jobTitle':jobTitle,
      'jobDescription':jobDescription,
      'jobAddress':jobAddress,
      'jobImage':jobImage,
      'jobContact':jobContact,
      'location':location,
      'jobFromtime':jobFromtime,
      'jobTotime':jobTotime,
      'jobFromdate':jobFromdate,
      'jobTodate':jobTodate,
      'jobcateId':jobcateId,
      'jobBata':jobBata,
      'jobCost':jobCost,
      'jobworkingHours':jobworkingHours,
      'jobworkingDays':jobworkingDays
    };
  }
}