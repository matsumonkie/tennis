module User.Predicate
(
  isFemale, isMale
) where

import User.Model

isFemale :: User -> Bool
isFemale = ((== Ms) . title)
isMale = not . isFemale
