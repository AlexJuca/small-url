defmodule SmallUrlWeb.Helpers do
    import Phoenix.LiveView.Helpers
    import Phoenix.HTML.Tag

    @doc """
  Renders a component inside the `Livebook.ModalComponent` component.

  The rendered modal receives a `:return_to` option to properly update
  the URL when the modal is closed.
  """
  def live_modal(component, opts) do
    path = Keyword.fetch!(opts, :return_to)
    modal_class = Keyword.get(opts, :modal_class)

    modal_opts = [
      id: :modal,
      return_to: path,
      modal_class: modal_class,
      component: component,
      opts: opts
    ]

    live_component(SmallUrlWeb.ModalComponent, modal_opts)
  end

  @doc """
  Returns [Remix](https://remixicon.com) icon tag.
  """
  def remix_icon(name, attrs \\ []) do
    icon_class = "ri-#{name}"
    attrs = Keyword.update(attrs, :class, icon_class, fn class -> "#{icon_class} #{class}" end)
    content_tag(:i, "", attrs)
  end

  def slice_original_url(url), do: "#{String.slice(url, 0, 30)}..."
end