enum API {
  startup,
  foreground,
  background,
  userCreate,
  userExist,
  checkJoiningObjectiveRoom,
  login,
  logout,
  myProfile,
  userDetail,
  myGames,
  gameRegistration,
  games,
  // piecesAndJots,
  // piece,
  jot,
  contact,
  agoraTokenForObjectiveRoom,
  agoraTokenForIndividualRoom,
  joinCallObjectiveRoom,
  joinCallIndividualRoom,
  matching,
  objectiveRoom,
  myRoom,
  leaveObjectiveRoom,
  objectiveRoomChat,
  individualRoom,
  individualChat,
  relationShips,
  roomJoin
}

String endPoint(API api) {
  switch (api) {
    case API.startup:
      return 'startup';
    case API.foreground:
      return 'forground';
    case API.background:
      return 'background';
    case API.login:
      return 'rest-auth/login';
    case API.userExist:
      return 'existing-user/';
    case API.logout:
      return 'rest-auth/login';
    case API.userCreate:
      return 'user/create/';
    case API.myProfile:
      return 'my-page/';
    case API.userDetail:
      return 'users/';
    case API.myGames:
      return 'my-games/';
    case API.gameRegistration:
      return 'registration-game/';
    case API.games:
      return 'games/';
    case API.jot:
      return 'jots/';
    case API.contact:
      return 'contact/';
    case API.agoraTokenForObjectiveRoom:
      return 'agora-token/objective-room/';
    case API.agoraTokenForIndividualRoom:
      return 'agora-token/individual-room/';
    case API.joinCallObjectiveRoom:
      return 'objective_room/call-join/';
    case API.joinCallIndividualRoom:
      return 'invitation_room/call-join/';
    case API.matching:
      return 'matching/';
    case API.objectiveRoom:
      return 'objective-room/';
    case API.individualRoom:
      return 'individual-room/';
    case API.individualChat:
      return 'individual-chat/';
    case API.myRoom:
      return 'my-room/';
    case API.leaveObjectiveRoom:
      return 'room-leaving/';
    case API.objectiveRoomChat:
      return 'objective-chat/';
    case API.relationShips:
      return 'relation-ships/';
      case API.checkJoiningObjectiveRoom:
      return 'taking_room/';
      case API.roomJoin:
      return 'room_join/';
  }
}
