var weatherModel;

weatherModel = angular.module('weather', []);

weatherModel.service("weather", [
  '$http', function($http) {
    var that;
    that = this;
    this.convertTime = function(time) {
      var date;
      date = new Date(parseInt(time) * 1000..toString());
      return date.getFullYear().toString() + '-' + date.getMonth().toString() + '-' + date.getDay().toString();
    };
    this.convertemperatures = function(temp) {
      return (temp / 33.8).toFixed(2);
    };
    this.getWeatherPost = function(weatherData, city) {
      var url;
      url = "http://api.openweathermap.org/data/2.5/forecast/daily?q=" + city + "&units=metric&cnt=7&appid=bd82977b86bf27fb59a04b61b657fb6f";
      return $http.get(url).success(function(data) {
        var Wdata, i, len, ref;
        if (data.cod === '200') {
          ref = data.list;
          for (i = 0, len = ref.length; i < len; i++) {
            Wdata = ref[i];
            weatherData.push({
              date: that.convertTime(Wdata.dt),
              low: that.convertemperatures(Wdata.temp.min),
              high: that.convertemperatures(Wdata.temp.max),
              weather: Wdata.weather[0].main
            });
          }
        }
      });
    };
    return {
      getWeather: this.getWeatherPost
    };
  }
]);

weatherModel.controller('weatherCtl', [
  '$scope', 'weather', function($scope, weather) {
    $scope.weatherData = [];
    $scope.City = [
      {
        seachcity: "beijing",
        name: '北京'
      }, {
        seachcity: "shanghai",
        name: '上海'
      }, {
        seachcity: "shenzhun",
        name: '深圳'
      }, {
        seachcity: "nanjing",
        name: '南京'
      }, {
        seachcity: "tianjing",
        name: '天津'
      }
    ];
    $scope.defaultSelect = {
      selectName: $scope.City[0].name,
      seachcity: $scope.City[0].seachcity
    };
    $scope.clickSelect = function(index) {
      $scope.defaultSelect.selectName = $scope.City[index].name;
      $scope.defaultSelect.seachcity = $scope.City[index].seachcity;
      return $scope.weatherData = [];
    };
    return $scope.getWeather = function() {
      $scope.weatherData = [];
      hshs
      return weather.getWeather($scope.weatherData, $scope.defaultSelect.seachcity);
    };
  }
]);
