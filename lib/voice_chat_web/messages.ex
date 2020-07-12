defmodule VoiceChatWeb.Messages do
  use GenServer, restart: :transient

  @name __MODULE__

  def start_link(default) do
    GenServer.start_link(__MODULE__, default, name: __MODULE__)
  end

  def in_msg(msg) do
    GenServer.call @name, {:in, msg}
  end

  def get_msgs() do
    GenServer.call @name, :get
  end

  defp delete_last(msg_q) do
    {{:value, _value}, q} = :queue.out msg_q
    q
  end

  @impl true
  def init(messages) do
    {:ok, messages}
  end

  @impl true
  def handle_call({:in, msg}, _from, msg_queue) do
    if :queue.len(msg_queue) > 9 do
      msg_queue = delete_last msg_queue
      msg_queue = :queue.in msg, msg_queue
      {:reply, :queue.to_list(msg_queue), msg_queue}
    else
      msg_queue = :queue.in msg, msg_queue
      {:reply, :queue.to_list(msg_queue), msg_queue}
    end
  end

  @impl true
  def handle_call(:get, _from, msg_queue) do
    {:reply, :queue.to_list(msg_queue), msg_queue}
  end
end
