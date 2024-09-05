class CommonParameter {
  String? memberId;

  CommonParameter({this.memberId});

  CommonParameter.fromJson(Map<String, dynamic> json) {
    memberId = json['MemberId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['MemberId'] = memberId;
    return data;
  }
}

class CommonsParameter {
  String? membersId;
  String? Id;

  CommonsParameter({this.membersId, this.Id = ""});

  CommonsParameter.fromJson(Map<String, dynamic> json) {
    membersId = json['MembersId'];
    Id = json['MembersId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['MembersId'] = membersId;
    data['Id'] = Id;
    return data;
  }
}

class CommonParameterForInvitation {
  String? MemberInvitationId;

  CommonParameterForInvitation({this.MemberInvitationId});

  CommonParameterForInvitation.fromJson(Map<String, dynamic> json) {
    MemberInvitationId = json['MemberInvitationId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['MemberInvitationId'] = MemberInvitationId;
    return data;
  }
}
