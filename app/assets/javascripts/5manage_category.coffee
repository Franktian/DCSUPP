controllerFunction = ($scope, $http) ->

    $scope.flip_category = (direction) ->
        request = 
            method: 'POST',
            url: '/flip_direction.html',
            headers: { 'X-CSRF-Token': $('meta[name="csrf-token"]').attr('content') },
            data: { pageNumber: $scope.pagenumber, direction: direction }

        $http(request).success($scope.flipSuccess)
        $scope.flip_direction = direction/10


    $scope.flipSuccess = (data) ->
        if (data)
            $scope.return_html = data
            if ($scope.flip_direction > 0)
                $scope.pagenumber = $scope.pagenumber + $scope.flip_direction
            else if ($scope.flip_direction < 0 and $scope.pagenumber > 1)
                $scope.pagenumber = $scope.pagenumber + $scope.flip_direction


    $scope.flip_direction = 0
    $scope.pagenumber = 1
    $scope.return_html = ''
    $scope.flip_category(0)


angular
    .module("dcsupp", [])
    .controller("cateCtrl", controllerFunction)