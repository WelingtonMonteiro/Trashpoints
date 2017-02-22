function openModalViewCollectImage(collectId) {
	$("#viewCollectImage").modal('open');
	loadCollectImage(collectId)
}

function openModalCompanyDetails(companyId) {
	$("#modalCompanyDetails").modal('open');
	loadCompanyDetails(companyId)
}

function loadCollectImage(collectId) {
	$(".preloader-wrapper").show();

	$.ajax({
		url: window.domain + "/Collect/loadCollectImage/",
		data: {
			id: collectId
		},
		method: "post",
		success: function (data) {
			$("#collectImage").html("")

			if (data.imagePath) {
				var UPLOAD_FOLDER_PATH = window.domain + "/images/uploads/" + data.imagePath;

				var imageUpload = "<img src='" + UPLOAD_FOLDER_PATH + "' style='max-height: 284px;'>"
				$("#collectImage").append(imageUpload)
			} else {
				var imageUpload = "<i class='fa fa-file-image-o fa-5x center-align'></i>"
				$("#collectImage").append(imageUpload)
			}
		},
		complete: function () {
			$(".preloader-wrapper").hide();
		}
	});
}

function loadCompanyDetails(companyId) {
	$(".preloader-wrapper").show();

	$.ajax({
		url: window.domain + "/Collaborator/loadCompanyDetails/",
		data: {
			id: companyId
		},
		method: "post",
		success: function (data) {
			var company = data.company
			var address = data.address

			if (company) {
				$("#companyDetails #companyName").text(company.companyName)
				$("#companyDetails #tradingName").text(company.tradingName)
				$("#companyDetails #phone").text(company.phone)
				$("#companyDetails #site").text(company.site)
			}
			if (address) {
				$("#collaboratorDetails span#zipCode").text(address.zipCode)
				$("#collaboratorDetails span#street").text(address.street)
				$("#collaboratorDetails span#number").text(address.number)
				$("#collaboratorDetails span#neighborhood").text(address.neighborhood)
				$("#collaboratorDetails span#city").text(address.city)
				$("#collaboratorDetails span#state").text(address.state)
			}
		},
		complete: function () {
			$(".preloader-wrapper").hide();
		}
	});
}