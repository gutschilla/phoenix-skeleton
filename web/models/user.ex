defmodule Hello2.User do
    use Ecto.Model

    validate user,

        username: present(),
        username: has_length(3..32),
        # do not allow unicode or special characters (except ".", "-" , _")
        username: has_format(~r/^[a-zA-Z0-9.\-_]+$/),

        password_hash: has_length(0..64)


    schema "users" do
        field :username,      :string
        field :password_hash, :string
    end
end
