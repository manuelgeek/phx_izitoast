defmodule PhxIzitoast do
  @moduledoc """
  Documentation for `PhxIzitoast` - Phoenix Notification Package.

  ![img](https://github.com/manuelgeek/phx_izitoast/raw/master/priv/static/img/iziToast.png)

  ## Configuration
  Add the below config to `config/config.exs`. This includes the default configurations(optional).  

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
   import PhxIzitoast
  ```
  Add the below function to the bottom of your `app.html.eex` just efore the closing `</body>` tag . This will import the needed  `css` and `js` files.
  ```elixir
  <body>
    ...............
    <%= izi_toast(@conn) %>
    .................
  </body>
  ```

  Add the below code to your `app_web/endpoint.ex` file  just below the existing `plug Plug.Static` configuration.
  ```elixir 
  plug Plug.Static, 
    at: "/", 
    from: {:phx_izitoast, "priv/static"}, 
    gzip: false, 
    only: ~w(css  js )
  ```
  This adds the necessary js and css for iziToast

  ## Usage 
  Quickest way to use PhxIzitoast
  ```elixir 
  conn
  |> PhxIzitoast.message("message")
  ```

  Usage in code would be like:

  ```elixir
  def create(conn, %{"category" => category_params}) do
    slug = slugified_title(category_params["name"])
    category_params = Map.put(category_params, "slug", slug)

    case Categories.create_category(category_params) do
      {:ok, _category} ->
        conn
        |> PhxIzitoast.success("Category", "Category created successfully")
        |> redirect(to: Routes.category_path(conn, :index))

      {:error, %Ecto.Changeset{} = changeset} ->
        conn 
        |> PhxIzitoast.error("Category", "A Validation Error !!!")
        |> render("new.html", changeset: changeset)
    end
  end
  ```

  WIth this you can remove the default notification alerts in `app.html.eex` and replace all your `put_flash/2` with `PhxIzitoast` .

  ### More functions include:
  """

  import Phoenix.HTML.Tag
  import Phoenix.HTML
  import Phoenix.Controller

  @defaults [
    position: "bottomRight",
    theme: "light",
    timeout: 5000,
    close: true,
    titleSize: 18,
    messageSize: 18,
    progressBar: true
  ]

  @doc """
  Inserts the CSS and Js files, takes in the `@conn`.Its is added  in the `app.html.eex` just before `</body>`
  """
  def izi_toast(conn) do
    toasts = get_flash(conn, :izitoast)
    # toasts = conn.assigns[:izitoast]
    IO.inspect(toasts)
    IO.inspect("toasts")
    # conn |> fetch_session |> delete_session(:izitoast)

    # delete_session(conn, :izitoast)

    if toasts do
      [toast_required_tags(), create_toast_tag(toasts)]
    end
  end

  @doc false
  def flash(conn, opts) do
    toasts = get_flash(conn, :izitoast)

    # toasts = conn.assigns[:izitoast]

    if(toasts) do
    #   # delete_session(conn, :izitoast)
      opts = toasts ++ [opts]
    conn = put_flash(conn, :izitoast, opts)

      conn
    #   #   assign(conn, :izitoast, opts)
    else
    #   # delete_session(conn, :izitoast)
    # #   assign(conn, :izitoast, [opts])
      conn = put_flash(conn, :izitoast, [opts])
      conn
    end

    # assign(conn, :izitoast, opts)
    # put_flash(conn, :message, "new stuff we just set in the session")
  end

  @doc false
  def make_toast(conn, title, message, color, opts) do
    opts = Keyword.merge(Application.get_env(:phx_izitoast, :opts) || [], opts)

    merged_opts = Keyword.merge(@defaults, opts)
    final_opts = merged_opts ++ [title: title, message: message, color: color]

    flash(conn, final_opts)
  end

  @doc false
  def make_toast(conn, title, message, color),
    do: make_toast(conn, title, message, color, [])

  @doc """
  ```elixir 
  conn 
  |> PhxIzitoast.message("awesome things only")
  ```
  """
  def message(conn, message),
    do: make_toast(conn, " ", message, "blue", [])

  @doc """
  ```elixir 
  conn 
  |> PhxIzitoast.success("title", "awesome", position: "bottomRight")
  ```
  """
  def success(conn, title, message, opts),
    do: make_toast(conn, title, message, "green", opts)

  @doc """
  ```elixir 
  conn 
  |> PhxIzitoast.success("title", "awesome")
  ```
  """
  def success(conn, title, message),
    do: make_toast(conn, title, message, "green", [])

  @doc """
  ```elixir 
  conn 
  |> PhxIzitoast.info("Success", "awesome", position: "topRight")
  ```
  """
  def info(conn, title, message, opts),
    do: make_toast(conn, title, message, "blue", opts)

  @doc """
  ```elixir 
  conn 
  |> PhxIzitoast.info("Hey", "This is Info")
  ```
  """
  def info(conn, title, message),
    do: make_toast(conn, title, message, "blue", [])

  @doc """
  ```elixir 
  conn 
  |> PhxIzitoast.warning("title", "awesome", timeout: 1000)
  ```
  """
  def warning(conn, title, message, opts),
    do: make_toast(conn, title, message, "yellow", opts)

  @doc """
  ```elixir 
  conn 
  |> PhxIzitoast.warning("title", "not very awesome")
  ```
  """
  def warning(conn, title, message),
    do: make_toast(conn, title, message, "yellow", [])

  @doc """
  ```elixir 
  conn 
  |> PhxIzitoast.error("Arrow", "You've Failed this city", position: "bottomLeft")
  ```
  """
  def error(conn, title, message, opts),
    do: make_toast(conn, title, message, "red", opts)

  @doc """
  ```elixir 
  conn 
  |> PhxIzitoast.info("Error 500", "Error Occured !!!")
  ```
  """
  def error(conn, title, message),
    do: make_toast(conn, title, message, "red", [])

  @doc false
  def create_toast_tag(toasts) do
    for toast <- toasts do
      content_tag(:script, raw("
        var options = {
          title: '#{toast[:title]}',
          message: '#{toast[:message]}',
          color: '#{toast[:color]}', // blue, red, green, yellow
          position: '#{toast[:position]}', // bottomRight, bottomLeft, topRight, topLeft, topCenter, bottomCenter, center
          theme: '#{toast[:theme]}', // dark
          timeout: #{toast[:timeout]},
          close: #{toast[:close]},
          titleSize: '#{toast[:titleSize]}',
          messageSize: '#{toast[:messageSize]}',
          progressBar: '#{toast[:progressBar]}'
      };
      var color = '#{toast[:color]}';
      if (color === 'blue'){
            iziToast.info(options);
        }
        else if (color === 'green'){
            iziToast.success(options);
        }
        else if  (color === 'yellow'){
            iziToast.warning(options);
        }
        else if (color === 'red'){
            iziToast.error(options);
        } else {
            iziToast.show(options);
        }
      // console.log('here')
      "), type: 'text/javascript')
    end
  end

  @doc false
  def toast_required_tags do
    ~E(<link href="/css/iziToast.css" rel="stylesheet" />
        <script src="/js/iziToast.js"></script>)
  end

  @doc """
  ```elixir 
  conn 
  |> PhxIzitoast.clear_toast()
  ```
  """
  def clear_toast(conn) do
      conn |> clear_flash()
  end
end
