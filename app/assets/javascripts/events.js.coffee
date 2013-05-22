# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
app = angular.module("App", [ "ui.bootstrap" ])
app.controller "AppCtrl", ['$scope', '$http', ($scope, $http) ->
	$scope.to_vote_vm = (vote) ->
		vote.clear_upvote = ->
			vote.upvoted = false
			vote.upvotes--
			console.log {direction:0, vote_id: vote.id, voter_guid: vote.voter}

		vote.clear_downvote = ->
			vote.downvoted = false
			vote.downvotes++
			console.log {direction:0, vote_id: vote.id, voter_guid: vote.voter}

		vote.cast = (delta) ->
			if delta == 1
				@clear_downvote() if vote.downvoted
				vote.upvotes += delta
				vote.upvoted = not vote.upvoted
			else
				@clear_upvote() if vote.upvoted
				vote.downvotes += delta
				vote.downvoted = not vote.downvoted
			console.log {direction: delta, vote_id: vote.id, voter_guid: vote.voter}

	$http(
		method: "GET"
		url: document.URL
	).success (data) ->
		$scope.flexevent = data.flexevent
		$scope.flexevent.votes = data.votes
		$scope.to_vote_vm v for v in $scope.flexevent.votes
]