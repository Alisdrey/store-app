alias StoreApi.Repo
alias StoreApi.Accounts.User

if Repo.all(User) == [] do
  IO.puts("No user found. Entering a default user.")

  hashed_password = Bcrypt.hash_pwd_salt("123456")

  %User{
    email: "alisson@email.com",
    password_hash: hashed_password
  }
  |> Repo.insert!()
else
  IO.puts("User already exists, seed will not be executed.")
end
