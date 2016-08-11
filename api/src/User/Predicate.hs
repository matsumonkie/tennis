module User.Predicate
(
  isFemale
, isMale
) where

import User.Model

isFemale :: User -> Bool
isFemale (User { gender = Just Female }) = True
isFemale _ = False

isMale (User { gender = Just Male }) = True
isMale _ = False
