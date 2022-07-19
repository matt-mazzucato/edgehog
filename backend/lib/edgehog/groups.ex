#
# This file is part of Edgehog.
#
# Copyright 2022 SECO Mind Srl
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#    http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#
# SPDX-License-Identifier: Apache-2.0
#

defmodule Edgehog.Groups do
  @moduledoc """
  The Groups context.
  """

  import Ecto.Query, warn: false
  alias Edgehog.Devices
  alias Edgehog.Groups.DeviceGroup
  alias Edgehog.Repo
  alias Edgehog.Selector

  @doc """
  Returns the list of device_groups.

  ## Examples

      iex> list_device_groups()
      [%DeviceGroup{}, ...]

  """
  def list_device_groups do
    Repo.all(DeviceGroup)
  end

  @doc """
  Returns the list of devices belonging to `device_group`.

  ## Examples

  iex> list_devices_in_group(device_group)
  [%Devices.Device{}, ...]

  """
  def list_devices_in_group(%DeviceGroup{} = device_group) do
    # This gets validated when the DeviceGroup is created, if it fails here then there's a bug
    # and it's legitimate we crash
    {:ok, device_query} = Selector.to_ecto_query(device_group.selector)

    Repo.all(device_query)
    |> Devices.preload_defaults_for_device()
  end

  @doc """
  Gets a single device_group.

  Raises `Ecto.NoResultsError` if the Device group does not exist.

  ## Examples

      iex> get_device_group!(123)
      %DeviceGroup{}

      iex> get_device_group!(456)
      ** (Ecto.NoResultsError)

  """
  def get_device_group!(id), do: Repo.get!(DeviceGroup, id)

  @doc """
  Creates a device_group.

  ## Examples

      iex> create_device_group(%{field: value})
      {:ok, %DeviceGroup{}}

      iex> create_device_group(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_device_group(attrs \\ %{}) do
    %DeviceGroup{}
    |> DeviceGroup.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a device_group.

  ## Examples

      iex> update_device_group(device_group, %{field: new_value})
      {:ok, %DeviceGroup{}}

      iex> update_device_group(device_group, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_device_group(%DeviceGroup{} = device_group, attrs) do
    device_group
    |> DeviceGroup.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a device_group.

  ## Examples

      iex> delete_device_group(device_group)
      {:ok, %DeviceGroup{}}

      iex> delete_device_group(device_group)
      {:error, %Ecto.Changeset{}}

  """
  def delete_device_group(%DeviceGroup{} = device_group) do
    Repo.delete(device_group)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking device_group changes.

  ## Examples

      iex> change_device_group(device_group)
      %Ecto.Changeset{data: %DeviceGroup{}}

  """
  def change_device_group(%DeviceGroup{} = device_group, attrs \\ %{}) do
    DeviceGroup.changeset(device_group, attrs)
  end
end
