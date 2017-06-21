module Taco
  # Untested, WIP.

  struct Payload
    JSON.mapping(model: Model, action: Action)
  end

  struct Model
    JSON.mapping({
      id:   String,
      name: String,
      url:  String,
    })
  end

  struct Action
    TIME_FORMAT = Time::Format.new("%FT%T.%L%:z")
    JSON.mapping({
     data:   ActionData,
     type:   String,
     date:   {type: Time, key: "date", converter: TIME_FORMAT},
     member: {key: "memberCreator", type: Member},
    })
  end

  struct ActionData
    JSON.mapping({
      card:  Card?
      label: Label?
      board: Board?
      list:  List?
    })
  end

  struct Card
    JSON.mapping({
      short_link: {key: "shortLink", type: String},
      name:       String,
    })
  end

  struct Label
    JSON.mapping(name: String, color: String)
  end

  struct Board
    JSON.mapping({
      short_link: {key: "shortLink", type: String},
      name:       String
    })
  end

  struct List
    JSON.mapping(name: String)
  end

  struct Member
    JSON.mapping({
      avatar_hash: {key: "avatarHash", type: String},
      full_name:   {key: "fullName", type: String},
      username:    {key: "username", type: String},
    })

    def avatar
     "http://trello-avatars.s3.amazonaws.com/#{avatar_hash}/50.png"
    end
  end
end
