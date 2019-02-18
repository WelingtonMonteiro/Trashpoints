(function (angular, M) {

	var module = angular.module('app');

	viewService.$inject = ['$timeout', '$state'];

	module.service('viewService', viewService);

	function viewService($timeout, $state) {
		return {
			onReady,
			timeout,
			go,
			isMobileWidth,
			closeSidenav
		};

		function onReady(onReadyCallback) {
			angular.element(document).ready(onReadyDocument);

			function onReadyDocument() {
				onReadyCallback();
				timeout(onTimeoutOnReady, 100);

				function onTimeoutOnReady() {
					updateSidenav();
					updateTabs();
					updateFixedActionButton();
					updateSelect();
					updateTextFields();
				}
			}
		}

		function timeout(timeoutCallback, milliseconds) {
			$timeout(timeoutCallback, milliseconds);
		}

		function go(nameRouter) {
			$state.go(nameRouter);
		}

		function updateSidenav() {
			var Sidenavs = document.querySelectorAll('.sidenav');

			M.Sidenav.init(Sidenavs);
		}

		function updateTabs() {
			var Options = {
				// swipeable: true
			};
			var Tabs = document.querySelectorAll('ul.tabs');

			M.Tabs.init(Tabs, Options);
		}

		function updateTextFields() {
			M.updateTextFields();
		}

		function updateSelect() {
			var Selects = document.querySelectorAll('select');

			M.FormSelect.init(Selects);
		}

		function updateFixedActionButton() {
			var FloatActionButtons = document.querySelectorAll('.fixed-action-btn');

			M.FloatingActionButton.init(FloatActionButtons);
		}

		function isMobileWidth() {
			return window.innerWidth <= 992;
		}

		function closeSidenav(id) {
			var MenuElement = document.getElementById(id);
			var MenuInstance = M.Sidenav.getInstance(MenuElement);

			MenuInstance.close();
		}
	}

})(window.angular, window.M);