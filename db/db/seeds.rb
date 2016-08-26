user01 = User.create(
  email: 'iori@mail.com',
  name: 'tsu',
  gender: "male",
)
user02 = User.create(
  email: 'claire@mail.com',
  name: 'gury',
  gender: "female",
)

club01 = Club.create(
  name: 'Roland Garros Tennis Club',
)
club02 = Club.create(
  name: 'Suzanne Lenglen Tennis Club',
)

ClubUsers.create(
  club_id: club01.id,
  user_id: user01.id,
)
