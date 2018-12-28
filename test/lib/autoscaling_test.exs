defmodule ExAws.AutoScalingTest do
  use ExUnit.Case, async: true
  doctest ExAws.AutoScaling

  alias ExAws.AutoScaling


  @version "2011-01-01"

  defp build_query(action, params) do
    action_string = action |> Atom.to_string |> Macro.camelize

    %ExAws.Operation.Query{
      path: "/",
      params: params |> Map.merge(%{"Version" => @version, "Action" => action_string}),
      service: :autoscaling,
      action: action
    }
  end

  test "describe_auto_scaling_groups no options" do
    expected = build_query(:describe_auto_scaling_groups, %{})
    assert expected == AutoScaling.describe_auto_scaling_groups
  end

  test "describe_auto_scaling_groups with group names" do
    expected = build_query(:describe_auto_scaling_groups, %{
      "AutoScalingGroupNames.member.1" => "GroupA",
      "AutoScalingGroupNames.member.2" => "GroupB",
    })

    assert expected == AutoScaling.describe_auto_scaling_groups(
      auto_scaling_group_names: ["GroupA", "GroupB"]
    )
  end

  test "describe_auto_scaling_groups with next_token and max_results"do
    expected = build_query(:describe_auto_scaling_groups, %{
      "NextToken" => "TestToken",
      "MaxResults" => 10
    })

    assert expected == AutoScaling.describe_auto_scaling_groups(
      next_token: "TestToken",
      max_results: 10
    )
  end
end
