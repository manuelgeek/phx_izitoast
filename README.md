# Phx Izitoast

This is a Phoenix Elixir IziToast Notification wrapper by [IziToast](https://izitoast.marcelodolza.com), A JavaScript Notifications Toast Library

**TODO: Add description**

## Installation

The package can be installed
by adding `phx_izitoast` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:phx_izitoast, "~> 0.1.0"}
  ]
end
```

## Configuration

Add the below config to `config/config.exs`. This includes the default configurations.  

```elixir
config :phx_izitoast, :opts, # bottomRight, bottomLeft, topRight, topLeft, topCenter, 
    position: "topRight", # dark,
    theme: "light",
    timeout: 5000,
    close: true,
    titleSize: 18,
    messageSize: 18,
    progressBar: true
```

Adding the JS Files to Layout  and Template. First import the Izitoast to your `layout_view.ex`
```elixir
import Blog.Toast.IziToast
```
Add the below function to the bottom of your `app.html.eex` just efore the closing `</body>` tag . This will import the needed  `css` and `js` files.
```elixir
<body>
...............
<%= izi_toast(@conn) %>
.................
</body>
```

## Usage 
Quickest way to use PhxIzitoast

```elixir 
conn
|> IziToast.message("message")
```
        
### More functions include:

```elixir 
conn 
|> IziToast.success("title", "awesome", position: "bottomRight")
```

```elixir 
conn 
|> IziToast.success("title", "awesome")
```

```elixir 
conn 
|> IziToast.info("Success", "awesome", position: "topRight")
```

``` elixir 
conn 
|> IziToast.info("Hey", "This is Info")
```

```elixir 
conn 
|> IziToast.warning("title", "awesome", timeout: 1000)
```

```elixir 
conn 
|> IziToast.warning("title", "not very awesome")
```

```elixir 
conn 
|> IziToast.error("Arrow", "You've Failed this city", position: "bottomLeft")
```

```elixir 
conn 
|> IziToast.info("Error 500", "Error Occured !!!")
``` 

## Documentation 
 The docs can
be found at [https://hexdocs.pm/phx_izitoast](https://hexdocs.pm/phx_izitoast).

 ## AUthor 

[ManuEl Geek](https://manuel.appslab.co.ke)

## Contributing & Licence

Phx Izitoast is released under [MIT License](https://github.com/appcues/exsentry/blob/master/LICENSE.txt)


