class Rain {
	double? onehours;

	Rain({this.onehours});

	factory Rain.fromJson(Map<String, dynamic> json) => Rain(
		onehours: (json['1h'] as num?)?.toDouble(),
			);

	Map<String, dynamic> toJson() => {
				'1h': onehours,
			};
}
