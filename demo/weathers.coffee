weatherModel = angular.module 'weather' ,[]


weatherModel.service "weather",['$http',
($http) ->
	that = this
	this.convertTime = (time) ->
		date = new Date parseInt(time) * 1000.toString()
		date.getFullYear().toString() + '-' + date.getMonth().toString() + '-'+date.getDay().toString()		
	this.convertemperatures = (temp) ->
		 return temp
		 #(temp / 33.8).toFixed 2	
	this.getWeatherPost = (weatherData,city) ->
		url ="http://api.openweathermap.org/data/2.5/forecast/daily?q=" + city + "&units=metric&cnt=7&appid=bd82977b86bf27fb59a04b61b657fb6f"	
		$http.get url 
			.success (data) ->
				if 	data.cod is '200' 
					for Wdata in data.list
						weatherData.push  {						
								date: that.convertTime Wdata.dt
								low:  that.convertemperatures Wdata.temp.min
								high: that.convertemperatures Wdata.temp.max
								weather: Wdata.weather[0].main
							}
					return 	
						 
	{ getWeather:this.getWeatherPost}	]		
  
  
 
weatherModel.controller 'weatherCtl' , ['$scope','weather',
($scope,weather) -> 
	$scope.weatherData = []	
	$scope.City = [
		{ seachcity : "beijing",name : '北京'},
		{ seachcity : "shanghai",name : '上海'},
		{ seachcity : "shenzhun",name : '深圳'},
		{ seachcity : "nanjing",name : '南京'},
		{ seachcity : "tianjing",name : '天津'}
	]
	$scope.defaultSelect = {selectName: $scope.City[0].name,seachcity:$scope.City[0].seachcity} 
	$scope.clickSelect = (index) ->
		$scope.defaultSelect.selectName = $scope.City[index].name
		$scope.defaultSelect.seachcity = $scope.City[index].seachcity
		$scope.weatherData = []	
	$scope.getWeather = () ->
		$scope.weatherData = []			
		weather.getWeather $scope.weatherData,$scope.defaultSelect.seachcity	
  
		
] 