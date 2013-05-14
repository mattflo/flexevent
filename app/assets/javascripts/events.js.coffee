# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
app = angular.module("App", [ "ui.bootstrap" ])
app.controller "AppCtrl", ($scope, $http) ->
  $scope.to_vote_vm = (vote) ->
    vote.upvote_symbol = ->
      return "^"  unless vote.upvoted
      "X"

    vote.downvote_symbol = ->
      return "∨"  unless vote.downvoted
      "X"

    vote.clear_upvote = ->
      vote.upvoted = false
      vote.upvotes--

    vote.clear_downvote = ->
      vote.downvoted = false
      vote.downvotes++

    vote.upcast = ->
      @clear_downvote()  if vote.downvoted
      delta = 1
      delta = -1  if vote.upvoted
      vote.upvotes += delta
      vote.upvoted = not vote.upvoted

    vote.downcast = ->
      @clear_upvote()  if vote.upvoted
      delta = -1
      delta = 1  if vote.downvoted
      vote.downvotes += delta
      vote.downvoted = not vote.downvoted

    vote.up_tip = ->
      return "Up vote this day if it's good for you."  unless vote.upvoted
      "Whoops! Undo your up vote."

    vote.down_tip = ->
      return "Down vote this day if it isn't good for you."  unless vote.downvoted
      "Whoops! Undo your down vote."

  $http(
    method: "GET"
    url: document.URL
  ).success (data) ->
    $scope.flexevent = data.flexevent
    $scope.flexevent.votes = data.votes
    _.each $scope.flexevent.votes, $scope.to_vote_vm

app.controller.$inject = ['$scope', '$http']