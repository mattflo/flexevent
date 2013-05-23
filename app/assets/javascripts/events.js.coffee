# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
app = angular.module("App", [ "ui.bootstrap" ])
app.controller "AppCtrl", ['$scope', '$http', ($scope, $http) ->
	$scope.to_vote_vm = (vote) ->
		vote.clear_upvote = (skip) ->
			vote.upvoted = false
			vote.upvotes--
			console.log {direction:0, vote_id: vote.id, voter_guid: vote.voter} unless skip?

		vote.clear_downvote = (skip) ->
			vote.downvoted = false
			vote.downvotes++
			console.log {direction:0, vote_id: vote.id, voter_guid: vote.voter} unless skip?

		vote.cast = (delta) ->
			if delta is 1
				@clear_downvote('skip') if vote.downvoted
				vote.upvotes += delta
				vote.upvoted = not vote.upvoted
			else
				@clear_upvote('skip') if vote.upvoted
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