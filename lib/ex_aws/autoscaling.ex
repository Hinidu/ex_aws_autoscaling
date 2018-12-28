defmodule ExAws.AutoScaling do
  @moduledoc """
  Operations on AWS AutoScaling

  A selection of the most common operations from the AutoScaling API are 
  implemented here.
  https://docs.aws.amazon.com/autoscaling/ec2/APIReference/API_Operations.html
  """

  use ExAws.Utils,
    format_type: :xml,
    non_standard_keys: %{}

  @version "2011-01-01"

  @doc """
  Describes one or more Auto Scaling groups.
  If you specify the Auto Scaling group names, Amazon Auto Scaling returns
  information for those groups.
  If you do not specify group names, then it'll return all the relevant groups.

  Doc: https://docs.aws.amazon.com/autoscaling/ec2/APIReference/API_DescribeAutoScalingGroups.html

  ## Examples:
      iex> ExAws.AutoScaling.describe_auto_scaling_groups
      %ExAws.Operation.Query{action: :describe_auto_scaling_groups,
      params: %{
        "Action" => "DescribeAutoScalingGroups",
        "Version" => "2011-01-01"
      }, parser: &ExAws.Utils.identity/2, path: "/", service: :autoscaling}

      iex> ExAws.AutoScaling.describe_auto_scaling_groups(auto_scaling_group_names: ["test-group"])
      %ExAws.Operation.Query{action: :describe_auto_scaling_groups,
      params: %{
        "Action" => "DescribeAutoScalingGroups",
        "AutoScalingGroupNames.member.1" => "test-group",
        "Version" => "2011-01-01"
      }, parser: &ExAws.Utils.identity/2, path: "/", service: :autoscaling}
  """
  @type describe_auto_scaling_groups_opts :: [
    auto_scaling_group_names: [binary, ...],
    max_results: integer,
    next_token: binary
  ]
  @spec describe_auto_scaling_groups() :: ExAws.Operation.Query.t
  @spec describe_auto_scaling_groups(opts :: describe_auto_scaling_groups_opts) :: ExAws.Operation.Query.t
  def describe_auto_scaling_groups(opts \\ []) do
    opts |> build_request(:describe_auto_scaling_groups)
  end

  defp build_request(opts, action) do
    opts
    |> Enum.flat_map(&format_param/1)
    |> request(action)
  end

  defp request(params, action) do
    action_string = action |> Atom.to_string |> Macro.camelize

    %ExAws.Operation.Query{
      path: "/",
      params:
        params
        |> filter_nil_params
        |> Map.put("Action", action_string)
        |> Map.put("Version", @version),
      service: :autoscaling,
      action: action
    }
  end

  defp format_param({:auto_scaling_group_names, auto_scaling_group_names}) do
    auto_scaling_group_names |> format(prefix: "AutoScalingGroupNames.member")
  end

  defp format_param({key, parameters}) do
    format([{key, parameters}])
  end
end
