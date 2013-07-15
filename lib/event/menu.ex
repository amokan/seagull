defmodule Event.Menu do

  @events [
      open: :menu_open,
      close: :menu_close,
      highlight: :menu_highlight
    ]

  def get_events() do
    @events
  end

  lc {sg, wx} inlist @events do
    def react(data, unquote(sg)) do
      :wxEvtHandler.connect Keyword.get(data, :wxobject), unquote(wx), [userData: {Keyword.get(data, :type), Keyword.get(data, :id)}]
      true
    end
  end

  def react(_data, _event), do: false

  lc {sg, wx} inlist @events do
    def translate(_wxid, _wxobject, id, {_, unquote(wx)}, window) do
      widget=Keyword.get window, id
      pid=Keyword.get widget, :pid
      pid<-[self, id, unquote(sg)]
      true
    end
  end
  def translate(_wx_id, _object, _id, _event, _window) do
    false
  end


end